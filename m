Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUGUWfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUGUWfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266761AbUGUWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:35:46 -0400
Received: from web53804.mail.yahoo.com ([206.190.36.199]:33629 "HELO
	web53804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266633AbUGUWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:35:40 -0400
Message-ID: <20040721223540.16485.qmail@web53804.mail.yahoo.com>
Date: Wed, 21 Jul 2004 15:35:40 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: RE: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
To: "Moore, Robert" <robert.moore@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net
In-Reply-To: <37F890616C995246BE76B3E6B2DBE055017355C4@orsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Moore, Robert" <robert.moore@intel.com> wrote:
> These aren't nonexistent functions, they are part of the AML
> disassembler (which is not always configured into the kernel)

  With respect, I cannot find the functions listed below anywhere in
the kernel.org kernel.  Where are they?  Given that they are not present,
you should consider either contributing them to the mainline kernel source
tree, or removing their prototypes.

from include/acpi/acdisasm.h:

acpi_dm_address_space
acpi_dm_ascending_op
acpi_dm_bit_list
acpi_dm_block_type
acpi_dm_byte_list
acpi_dm_comma_if_field_member
acpi_dm_comma_if_list_member
acpi_dm_decode_attribute
acpi_dm_decode_internal_object
acpi_dm_decode_node
acpi_dm_descending_op
acpi_dm_disasm_byte_list
acpi_dm_disassemble
acpi_dm_disassemble_one_op
acpi_dm_display_arguments
acpi_dm_display_internal_object
acpi_dm_display_locals
acpi_dm_display_path
acpi_dm_dma_descriptor
acpi_dm_dump_name
acpi_dm_dword_descriptor
acpi_dm_eisa_id
acpi_dm_end_dependent_descriptor
acpi_dm_field_flags
acpi_dm_fixed_io_descriptor
acpi_dm_fixed_mem32_descriptor
acpi_dm_generic_register_descriptor
acpi_dm_indent
acpi_dm_interrupt_descriptor
acpi_dm_io_descriptor
acpi_dm_io_flags
acpi_dm_irq_descriptor
acpi_dm_is_resource_descriptor
acpi_dm_is_string_buffer
acpi_dm_is_unicode_buffer
acpi_dm_list_type
acpi_dm_match_keyword
acpi_dm_match_op
acpi_dm_memory24_descriptor
acpi_dm_memory32_descriptor
acpi_dm_memory_flags
acpi_dm_method_flags
acpi_dm_namestring
acpi_dm_qword_descriptor
acpi_dm_region_flags
acpi_dm_resource_descriptor
acpi_dm_start_dependent_descriptor
acpi_dm_unicode
acpi_dm_validate_name
acpi_dm_vendor_large_descriptor
acpi_dm_vendor_small_descriptor
acpi_dm_walk_parse_tree
acpi_dm_word_descriptor
acpi_is_eisa_id
acpi_ps_display_object_pathname


from include/acpi/acdebug.h:

acpi_db_add_to_history
acpi_db_check_integrity
acpi_db_classify_one_object
acpi_db_close_debug_file
acpi_db_command_dispatch
acpi_db_count_namespace_objects
acpi_db_create_execution_threads
acpi_db_decode_and_display_object
acpi_db_disassemble_aml
acpi_db_display_all_methods
acpi_db_display_arguments
acpi_db_display_calling_tree
acpi_db_display_gpes
acpi_db_display_help
acpi_db_display_history
acpi_db_display_locals
acpi_db_display_locks
acpi_db_display_method_info
acpi_db_display_object_type
acpi_db_display_objects
acpi_db_display_resources
acpi_db_display_results
acpi_db_display_statistics
acpi_db_display_table_info
acpi_db_dump_buffer
acpi_db_dump_namespace
acpi_db_dump_namespace_by_owner
acpi_db_dump_object
acpi_db_dump_parser_descriptor
acpi_db_enumerate_object
acpi_db_execute
acpi_db_execute_method
acpi_db_execute_setup
acpi_db_execute_thread
acpi_db_execution_walk
acpi_db_find_name_in_namespace
acpi_db_find_references
acpi_db_generate_gpe
acpi_db_generate_statistics
acpi_db_get_from_history
acpi_db_get_line
acpi_db_get_next_token
acpi_db_get_outstanding_allocations
acpi_db_get_pointer
acpi_db_get_table_from_file
acpi_db_integrity_walk
acpi_db_load_acpi_table
acpi_db_local_ns_lookup
acpi_db_match_argument
acpi_db_match_command
acpi_db_method_thread
acpi_db_open_debug_file
acpi_db_prep_namestring
acpi_db_read_table_from_file
acpi_db_second_pass_parse
acpi_db_send_notify
acpi_db_set_method_breakpoint
acpi_db_set_method_call_breakpoint
acpi_db_set_method_data
acpi_db_set_output_destination
acpi_db_set_scope
acpi_db_single_thread
acpi_db_start_command
acpi_db_unload_acpi_table
acpi_db_walk_and_match_name
acpi_db_walk_for_references
acpi_db_walk_for_specific_objects
ae_local_load_table

