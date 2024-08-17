"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"sudo add-apt-repository ppa:jonathonf/vim
"pip install pyvim
"
"--- For GitBash's builtin vim follow below
" https://quakkels.com/posts/configuring-vim-when-using-git-bash/
" https://www.reddit.com/r/vim/comments/6w3jmc/installing_plugins_for_the_vim_in_git_bash_for/

let mapleader = ","
let maplocalleader = "\\"

call plug#begin() "'C:\Bin\vimfiles\vim_plugged\autoload')
Plug 'sillybun/vim-repl'
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " do CocInstall coc-metals, coc-python
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'                         " adds icons in nerdtree 
Plug 'itchyny/lightline.vim'                          " status tabline bottom
Plug 'joshdick/onedark.vim'                           " Color Theme 
Plug 'morhetz/gruvbox'                                " Classic Color Theme 

"Plug 'sheerun/vim-polyglot'                           " py syntax highlight
"Plug 'liuchengxu/vista.vim'                           " Show cTags
"Plug 'ctrlpvim/ctrlp.vim'                             " fuzzy find files
"Plug 'prettier/vim-prettier', {'do': 'yarn install'} " Not working in vim? or yarn issue
"Plug 'christoomey/vim-tmux-navigator'                " interphere w/ NERDTreeToggle <c-\>
"Plug 'tsony-tsonev/nerdtree-git-plugin'
"Plug 'airblade/vim-gitgutter'
call plug#end()

" https://vi.stackexchange.com/questions/5441/is-it-possible-and-useful-to-split-vimrc
" ___ 
filetype plugin on
" " This script contains plugin specific settings
if has("win64")
    source $HOME/vimfiles/coc-config.vim
    colorscheme gruvbox " this came with init.vim
else
    source $HOME/.vim/coc-config.vim
    colorscheme onedark
endif

" ___ 
""let g:python3_host_prog = $CONDA_PYTHON_EXE " DOES NOT really do much
let g:repl_program = { 
    \ 'python': ['ipython'],
    \ 'default': ['bash'],
    \ 'lua': ['lua'],
    \ 'vim': ['vim -e']
    \ }
   "\ 'scala': [ $HOME . '/bin/mill_repl.sh'],
   "\ 'scala': ['sbt console'],

let g:repl_exit_commands = {
	\ 'python': 'quit()', 
	\ 'bash': 'exit',
    \ 'zsh': 'exit',
    \ 'default': 'exit',
    \ }

let g:repl_predefine_python = {
    \ 'numpy': 'import numpy as np',
    \ 'pandas': 'import pandas as pd',
    \ 'matplotlib': 'from matplotlib import pyplot as plt'
    \ }


"___ keyMaps for Sillybun vim-repl ____________________________________
"
nnoremap <leader>r :REPLToggle<Cr>
" ipdb to debug python script
nnoremap <localleader>\ :REPLToggle<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
"autocmd FileType json syntax match Comment +\/\/.\+$+ 


"-- Sillybun repl setups --
let g:repl_output_copy_to_register = "t"
let g:repl_position = 0 " 0 bot 3 right
let g:sendtorepl_invoke_key = "<localleader>\\"
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version  = '7'
let g:repl_stayatrepl_when_open = 0

" https://github.com/sillybun/vim-repl/issues/84
" -- support scroll vertical --
tnoremap <C-n> <C-w>N
tnoremap <ScrollWheelUp> <C-w>Nk
tnoremap <ScrollWheelDown> <C-w>Nj



"___ For NERDTree _______________________________________________
"
"ignore files in nerdtree
let nerdtreeignore=['\.pyc$', '\~$','^node_modules$']
map <C-\> :NERDTreeToggle<CR>

"inoremap jk <ESC>
"comments sections out by visual or by line 

vmap "" <plug>NERDCommenterToggle
nmap "" <plug>NERDCommenterToggle

"-- open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeGitStatusNodeColorization = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1


"___ ctrlp ____________________________________
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set cindent
set shiftwidth=2

au BufRead,BufNewFile *.scala   set expandtab
au BufRead,BufNewFile *.sc      set expandtab
au BufRead,BufNewFile *.py      set expandtab
au BufRead,BufNewFile *.c       set noexpandtab
au BufRead,BufNewFile *.h       set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

filetype on
filetype plugin indent on
au VimEnter,BufRead,BufNewFile *.jl set filetype=julia
au VimEnter,BufRead,BufNewFile *.scala set filetype=scala
au VimEnter,BufRead,BufNewFile *.sc set filetype=scala
au VimEnter,BufRead,BufNewFile *.py set filetype=python
"
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css,*.scala,*.sc,*.jl
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set expandtab |
	\ set shiftwidth=2

syntax on
set laststatus=2
set statusline=[%n]\ %<%f%h%m
