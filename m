Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131399AbQKZVnk>; Sun, 26 Nov 2000 16:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132841AbQKZVn3>; Sun, 26 Nov 2000 16:43:29 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:11825 "EHLO
        mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
        id <S131399AbQKZVnP>; Sun, 26 Nov 2000 16:43:15 -0500
Date: Sun, 26 Nov 2000 21:14:01 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with ACPI on test11-ac4
Message-ID: <20001126211400.A32673@marcel.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Oops happens during startup immediately after:

ACPI: System description tables loaded

It's definitely using the correct System.map.

This is on RedHat 7.0, Athlon 800, Abit KA7-100 m/b

ksymoops 2.3.4 on i686 2.4.0-test11-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11-ac4/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memcpy_R__ver_acpi_cm_memcpy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memset_R__ver_acpi_cm_memset not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_strncmp_R__ver_acpi_cm_strncmp not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_layer_R__ver_acpi_dbg_layer not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_level_R__ver_acpi_dbg_level not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_disable_event_R__ver_acpi_disable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_enable_event_R__ver_acpi_enable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_evaluate_object_R__ver_acpi_evaluate_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_current_resources_R__ver_acpi_get_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_handle_R__ver_acpi_get_handle not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_name_R__ver_acpi_get_name not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_next_object_R__ver_acpi_get_next_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_object_info_R__ver_acpi_get_object_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_parent_R__ver_acpi_get_parent not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_possible_resources_R__ver_acpi_get_possible_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_cx_info_R__ver_acpi_get_processor_cx_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_info_R__ver_acpi_get_processor_throttling_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_state_R__ver_acpi_get_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_type_R__ver_acpi_get_type not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_address_space_handler_R__ver_acpi_install_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_gpe_handler_R__ver_acpi_install_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_notify_handler_R__ver_acpi_install_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_breakpoint_R__ver_acpi_os_breakpoint not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_callocate_R__ver_acpi_os_callocate not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_free_R__ver_acpi_os_free not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_in8_R__ver_acpi_os_in8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_out8_R__ver_acpi_os_out8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_printf_R__ver_acpi_os_printf not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_queue_for_execution_R__ver_acpi_os_queue_for_execution not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_R__ver_acpi_os_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_usec_R__ver_acpi_os_sleep_usec not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_processor_sleep_R__ver_acpi_processor_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_address_space_handler_R__ver_acpi_remove_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_gpe_handler_R__ver_acpi_remove_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_notify_handler_R__ver_acpi_remove_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_current_resources_R__ver_acpi_set_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_sleep_state_R__ver_acpi_set_processor_sleep_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_throttling_state_R__ver_acpi_set_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_prefix_R__ver_debug_print_prefix not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_raw_R__ver_debug_print_raw not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_exit_R__ver_function_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_status_exit_R__ver_function_status_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_trace_R__ver_function_trace not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_value_exit_R__ver_function_value_exit not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000016
c01f9cb4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f9cb4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: 4b41575f   edx: 00000006
esi: 00000000   edi: 00000065   ebp: 00000000   esp: c14f7f68
ds: 0018   es: 0018   ss: 0018
Process kacpid (pid: 7, stackpage=c14f7000)
Stack: c01f9e19 00000000 c01f06e0 ffffffff c14f6239 c14f6000 08010626 c01fa4b5 
       00000008 cff18200 ffffffff 00000001 c01f06e0 00000000 00000000 00000008 
       00000000 00000000 c01f0790 00000008 cff18200 ffffffff c01f06e0 00000000 
Call Trace: [<c01f9e19>] [<c01f06e0>] [<c01fa4b5>] [<c01f06e0>] [<c01f0790>] [<c01f06e0>] [<c01f026a>] 
       [<c01ed542>] [<c020092a>] [<c0105000>] [<c01094b3>] 
Code: f6 40 16 02 75 0f 8d b6 00 00 00 00 8b 40 10 f6 40 16 02 74 

>>EIP; c01f9cb4 <acpi_ns_get_parent_object+4/20>   <=====
Trace; c01f9e19 <acpi_ns_walk_namespace+e9/100>
Trace; c01f06e0 <acpi_ev_save_method_info+0/80>
Trace; c01fa4b5 <acpi_walk_namespace+45/60>
Trace; c01f06e0 <acpi_ev_save_method_info+0/80>
Trace; c01f0790 <acpi_ev_init_gpe_control_methods+30/40>
Trace; c01f06e0 <acpi_ev_save_method_info+0/80>
Trace; c01f026a <acpi_ev_initialize+4a/70>
Trace; c01ed542 <acpi_enable_subsystem+42/70>
Trace; c020092a <acpi_thread+8a/1c0>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01094b3 <kernel_thread+23/30>
Code;  c01f9cb4 <acpi_ns_get_parent_object+4/20>
00000000 <_EIP>:
Code;  c01f9cb4 <acpi_ns_get_parent_object+4/20>   <=====
   0:   f6 40 16 02               testb  $0x2,0x16(%eax)   <=====
Code;  c01f9cb8 <acpi_ns_get_parent_object+8/20>
   4:   75 0f                     jne    15 <_EIP+0x15> c01f9cc9 <acpi_ns_get_parent_object+19/20>
Code;  c01f9cba <acpi_ns_get_parent_object+a/20>
   6:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c01f9cc0 <acpi_ns_get_parent_object+10/20>
   c:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c01f9cc3 <acpi_ns_get_parent_object+13/20>
   f:   f6 40 16 02               testb  $0x2,0x16(%eax)
Code;  c01f9cc7 <acpi_ns_get_parent_object+17/20>
  13:   74 00                     je     15 <_EIP+0x15> c01f9cc9 <acpi_ns_get_parent_object+19/20>


45 warnings issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
