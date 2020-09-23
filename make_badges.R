proper_repos <- "~/proper_repos.json" %>%
  jsonlite::read_json(simplifyVector = T) %>%
  dplyr::mutate(owner_name = owner$login)

links <- proper_repos %>%
  purrr::pmap(function(
    nameWithOwner, url, name, owner_name, ...
  ) {

    label <- glue::glue(
      '{owner_name}%20/%20{name}%20{star}',
      star  = '%E2%AD%90'
    )

    out <- glue::glue(
      '<a href="{url}/commits?author=matthewstrasiotto">',
      '<img align="center"',
      'src="{endpoint}/{nameWithOwner}?label={label}&style={style}&logo=GitHub"',
      ' />',
      '</a>',
      endpoint = "https://img.shields.io/github/stars",
      style = 'for-the-badge'
    )
  })

links %>% glue::glue_collapse(sep = "\n")
