Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQL2B0k>; Thu, 28 Dec 2000 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQL2B0a>; Thu, 28 Dec 2000 20:26:30 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:22280 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129228AbQL2B0X>; Thu, 28 Dec 2000 20:26:23 -0500
Message-ID: <3A4BE117.3F58333B@Hell.WH8.TU-Dresden.De>
Date: Fri, 29 Dec 2000 01:55:51 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops when mounting cdrom
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

When mounting a 700 MB CD-RW in my Plextor CD-ROM, my machine
reliably oopses. Below is the first oops decoded.

Can someone explain to me what all those ksymoops warnings are
about?

-Udo.

ksymoops 2.3.5 on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /usr/src/linux/System.map (specified)

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
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
*pde = 00000000
OOPS: 0000
CPU: 0
EIP: 0010:[<c01be6df>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: 00000000     ecx: 00000000       edx: c1467a10
esi: 00000001   edi: c03022c0     ebp: c0302280       esp: cf30dd54
ds: 0018        es: 0018       ss: 0018
Process mount (pid: 131, stackpage=cf30d000)
Stack: c03022c0 c01be764 c03022c0 00000000 c1467a10 c1467a50 00000001 c03022c0
       c0302280 00000003 c1467a00 00000000 00000000 cf30dd9c 00000000 00000001
       c027fc20 20000000 00003332 cf30ddb4 00000000 00000000 c027fc20 30002280
Call Trace: [<c01b3764>] [<c027fc20>] [<c027fc20>] [<c01b2805>] [<c01bebdd>]
            [<c01bfa27>] [<c01b40ef>] [<c01bf940>] [<c010a181>] [<c010a2fe>]
            [<c0108fd0>] [<c0130f0b>] [<c0136fce>] [<c01346c6>] [<c01357d2>]
            [<c01355fd>] [<c0135984>] [<c0108f27>]
Code: 83 78 0c 00 74 07 31 c0 eb 52 8d 76 00 8a 42 02 24 0f 25 ff

>>EIP; c01be6df <cdrom_log_sense+f/70>   <=====
Trace; c01b3764 <execute_drive_cmd+104/150>
Trace; c027fc20 <msstab+630e/65ae>
Trace; c027fc20 <msstab+630e/65ae>
Trace; c01b2805 <ide_set_handler+55/60>
Trace; c01bebdd <cdrom_end_request+3d/80>
Trace; c01bfa27 <cdrom_pc_intr+e7/1d0>
Trace; c01b40ef <ide_intr+ff/160>
Trace; c01bf940 <cdrom_pc_intr+0/1d0>
Trace; c010a181 <handle_IRQ_event+31/60>
Trace; c010a2fe <do_IRQ+6e/c0>
Trace; c0108fd0 <ret_from_intr+0/20>
Trace; c0130f0b <__invalidate_buffers+3b/e0>
Trace; c0136fce <blkdev_put+4e/b0>
Trace; c01346c6 <sync_supers+26/b0>
Trace; c01357d2 <do_mount+182/2b0>
Trace; c01355fd <copy_mount_options+4d/a0>
Trace; c0135984 <sys_mount+84/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c01be6df <cdrom_log_sense+f/70>
00000000 <_EIP>:
Code;  c01be6df <cdrom_log_sense+f/70>   <=====
   0:   83 78 0c 00               cmpl   $0x0,0xc(%eax)   <=====
Code;  c01be6e3 <cdrom_log_sense+13/70>
   4:   74 07                     je     d <_EIP+0xd> c01be6ec <cdrom_log_sense+1c/70>
Code;  c01be6e5 <cdrom_log_sense+15/70>
   6:   31 c0                     xorl   %eax,%eax
Code;  c01be6e7 <cdrom_log_sense+17/70>
   8:   eb 52                     jmp    5c <_EIP+0x5c> c01be73b <cdrom_log_sense+6b/70>
Code;  c01be6e9 <cdrom_log_sense+19/70>
   a:   8d 76 00                  leal   0x0(%esi),%esi
Code;  c01be6ec <cdrom_log_sense+1c/70>
   d:   8a 42 02                  movb   0x2(%edx),%al
Code;  c01be6ef <cdrom_log_sense+1f/70>
  10:   24 0f                     andb   $0xf,%al
Code;  c01be6f1 <cdrom_log_sense+21/70>
  12:   25 ff 00 00 00            andl   $0xff,%eax

Kernel panic: Aiee, Killing interrupt handler

45 warnings issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
