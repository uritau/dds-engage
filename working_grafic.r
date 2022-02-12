### Goals and Approaches
```{r goals_approaches, echo=FALSE}
target <- unlist(llply(approach_details, function(x) x$name))
#source <- unlist(llply(approach_details, function(x) x$goals))
#source <- unlist(llply(source, function(x) goal_details[[x]]$name))

source <- unlist(
  llply(llply(approach_details, function(x) x$goals),
  function(x) goal_details[[x]]$name))



# A connection data frame is a list of flows with intensity for each flow
links <- data.frame(
  source=source,
  target=target,
  value=1
  )
 
# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(
  name=c(as.character(links$source), 
  as.character(links$target)) %>% unique()
)
 
# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1
 
# Make the Network
p <- sankeyNetwork(Links = links, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE)
p

