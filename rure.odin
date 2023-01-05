/*
 * Copyright 2023 XXIV
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package rure

import c "core:c"

when ODIN_OS == .Linux {
    when #config(shared, true) {
        foreign import lib "librure.so" 
    } else {
        foreign import lib "librure.a"
    }
} else when ODIN_OS == .Windows  {
    when #config(shared, true) {
        foreign import lib "librure.dll" 
    } else {
        foreign import lib "librure.lib"
    }
} else when ODIN_OS == .Darwin {
    when #config(shared, true) {
        foreign import lib "librure.dylib" 
    } else {
        foreign import lib "librure.a"
    }
} else {
	foreign import lib "system:rure"
}

RURE_FLAG_CASEI :: 1;
RURE_FLAG_MULTI :: 2;
RURE_FLAG_DOTNL :: 4;
RURE_FLAG_SWAP_GREED :: 8;
RURE_FLAG_SPACE :: 16;
RURE_FLAG_UNICODE :: 32;
RURE_DEFAULT_FLAGS :: RURE_FLAG_UNICODE;


rure :: struct {};

rure_set :: struct {};

rure_options :: struct {};

rure_captures :: struct {};

rure_iter :: struct {};

rure_iter_capture_names :: struct {};

rure_error :: struct {};

rure_match :: struct {
    start : c.size_t,
    end : c.size_t,
};

@(default_calling_convention="c")
foreign lib {

    
    rure_compile_must :: proc(pattern : cstring) -> ^rure ---;

    
    rure_compile :: proc(pattern : ^u8,
			 length : c.size_t,
			 flags : u32,
			 options : ^rure_options,
			 error : ^rure_error) -> ^rure ---;

    
    rure_free :: proc(re : ^rure) ---;

    
    rure_is_match :: proc(re : ^rure,
			  haystack : ^u8,
			  length : c.size_t,
			  start : c.size_t) -> bool ---;

    
    rure_find :: proc(re : ^rure,
		      haystack : ^u8,
		      length : c.size_t,
		      start : c.size_t,
		      match : ^rure_match) -> bool ---;

    
    rure_find_captures :: proc(re : ^rure,
			       haystack : ^u8,
			       length : c.size_t,
			       start : c.size_t,
			       captures : ^rure_captures) -> bool ---;

    
    rure_shortest_match :: proc(re : ^rure,
				haystack : ^u8,
				length : c.size_t,
				start : c.size_t,
				end : ^c.size_t) -> bool ---;

    
    rure_capture_name_index :: proc(re : ^rure,
				    name : cstring) -> i32 ---;

    
    rure_iter_capture_names_new :: proc(re : ^rure) -> ^rure_iter_capture_names ---;

    
    rure_iter_capture_names_free :: proc(it : ^rure_iter_capture_names) ---;

    
    rure_iter_capture_names_next :: proc(it : ^rure_iter_capture_names,
					 name : ^cstring) -> bool ---;

    
    rure_iter_new :: proc(re : ^rure) -> ^rure_iter ---;

    
    rure_iter_free :: proc(it : ^rure_iter) ---;

    
    rure_iter_next :: proc(it : ^rure_iter,
			   haystack : ^u8,
			   length : c.size_t,
			   match : ^rure_match) -> bool ---;

    
    rure_iter_next_captures :: proc(it : ^rure_iter,
				    haystack : ^u8,
				    length : c.size_t,
				    captures : ^rure_captures) -> bool ---;

    
    rure_captures_new :: proc(re : ^rure) -> ^rure_captures ---;

    
    rure_captures_free :: proc(captures : ^rure_captures) ---;

    
    rure_captures_at :: proc(captures : ^rure_captures,
			     i : c.size_t,
			     match : ^rure_match) -> bool ---;

    
    rure_captures_len :: proc(captures : ^rure_captures) -> c.size_t ---;

    
    rure_options_new :: proc() -> ^rure_options ---;

    
    rure_options_free :: proc(options : ^rure_options) ---;

    
    rure_options_size_limit :: proc(options : ^rure_options,
				    limit : c.size_t) ---;

    
    rure_options_dfa_size_limit :: proc(options : ^rure_options,
					limit : c.size_t) ---;

    
    rure_compile_set :: proc(patterns : ^^u8,
			     patterns_lengths : ^c.size_t,
			     patterns_count : c.size_t,
			     flags : u32,
			     options : ^rure_options,
			     error : ^rure_error) -> ^rure_set ---;

    
    rure_set_free :: proc(re : ^rure_set) ---;

    
    rure_set_is_match :: proc(re : ^rure_set,
			      haystack : ^u8,
			      length : c.size_t,
			      start : c.size_t) -> bool ---;

    
    rure_set_matches :: proc(re : ^rure_set,
			     haystack : ^u8,
			     length : c.size_t,
			     start : c.size_t,
			     matches : ^bool) -> bool ---;

    
    rure_set_len :: proc(re : ^rure_set) -> c.size_t ---;

    
    rure_error_new :: proc() -> ^rure_error ---;

    
    rure_error_free :: proc(err : ^rure_error) ---;

    
    rure_error_message :: proc(err : ^rure_error) -> cstring ---;

    
    rure_escape_must :: proc(pattern : cstring) -> cstring ---;

    
    rure_cstring_free :: proc(s : cstring) ---;

}
