Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRAXVfO>; Wed, 24 Jan 2001 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRAXVfF>; Wed, 24 Jan 2001 16:35:05 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:49881 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129847AbRAXVes>; Wed, 24 Jan 2001 16:34:48 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel,e-steel.mailing-lists.linux.linux-sound
Subject: oops with ac97 sound card
Date: 24 Jan 2001 16:34:34 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3g0i863dh.fsf@shookay.e-steel.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980371982 11516 192.168.3.43 (24 Jan 2001 21:33:02 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 24 Jan 2001 21:33:02 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi everyone!

I have a Dell computer with this marvelous builtin sound chipset. It's an
AC97 compatable and it plays only sounds at 48 kHz, nothing more. I just
got an oops this afternoon. I decoded it and got many errors with acpi, I
don't know if it's normal or not but here is the ouput:

(I'm using kernel 2.4.0).

If you have questions, whatever...

ksymoops 2.3.4 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (specified)

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
Jan 24 16:15:06 shookay kernel: Unable to handle kernel paging request at virtual address 6559d250
Jan 24 16:15:06 shookay kernel: d082ceea
Jan 24 16:15:06 shookay kernel: *pde = 00000000
Jan 24 16:15:06 shookay kernel: Oops: 0002
Jan 24 16:15:06 shookay kernel: CPU:    0
Jan 24 16:15:06 shookay kernel: EIP:    0010:[i810_audio:__insmod_i810_audio_S.text_L9922+7818/10144]
Jan 24 16:15:06 shookay kernel: EFLAGS: 00010286
Jan 24 16:15:06 shookay kernel: eax: c14b2f50   ebx: cf5d02a0   ecx: 2903a8c0   edx: a40ea300
Jan 24 16:15:06 shookay kernel: esi: c876cba0   edi: cf5d02a8   ebp: cf5d02d0   esp: c9d8df60
Jan 24 16:15:06 shookay kernel: ds: 0018   es: 0018   ss: 0018
Jan 24 16:15:06 shookay kernel: Process sox (pid: 8956, stackpage=c9d8d000)
Jan 24 16:15:06 shookay kernel: Stack: cf5d02a0 c876cba0 c14b3f20 cd5bc460 cd59e720 c0131530 cd5bc460 c876cba0 
Jan 24 16:15:06 shookay kernel:        c876cba0 00000000 00000000 bffffbf0 c01306fc c876cba0 cc5e6420 00000000 
Jan 24 16:15:06 shookay kernel:        c876cba0 00000000 c876cba0 080ae320 c0130747 c876cba0 cc5e6420 c9d8c000 
Jan 24 16:15:06 shookay kernel: Call Trace: [fput+56/208] [filp_close+92/100] [sys_close+67/84] [system_call+51/56] 
Jan 24 16:15:06 shookay kernel: Code: c7 04 02 00 00 00 00 83 c4 04 31 c0 5b 5e 5f 5d c3 90 83 ec 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c7 04 02 00 00 00 00      movl   $0x0,(%edx,%eax,1)
Code;  00000007 Before first symbol
   7:   83 c4 04                  add    $0x4,%esp
Code;  0000000a Before first symbol
   a:   31 c0                     xor    %eax,%eax
Code;  0000000c Before first symbol
   c:   5b                        pop    %ebx
Code;  0000000d Before first symbol
   d:   5e                        pop    %esi
Code;  0000000e Before first symbol
   e:   5f                        pop    %edi
Code;  0000000f Before first symbol
   f:   5d                        pop    %ebp
Code;  00000010 Before first symbol
  10:   c3                        ret    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   83 ec 00                  sub    $0x0,%esp


45 warnings issued.  Results may not be reliable.


-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
