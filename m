Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUA3GOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 01:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUA3GOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 01:14:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8674 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263697AbUA3GN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 01:13:58 -0500
Subject: Re: CPU lockup during halt for Shuttle SB61G2 p4 with
	hyperthreading 2.4.24 (untained kernel)
From: Tom Epperly <tomepperly@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: Burton Windle <bwindle@fint.org>
In-Reply-To: <012920041811.27663.702d@comcast.net>
References: <012920041811.27663.702d@comcast.net>
Content-Type: text/plain
Message-Id: <1075443236.1112.4.camel@faerun>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 22:13:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another oops. This one doesn't have the nvidia module loaded.
The hardware is identical to my original post.

ksymoops 2.4.9 on i686 2.4.24-cryptosmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-cryptosmp/ (default)
     -m /boot/System.map-2.4.24-cryptosmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
acpi_acquire_global_lock_R__ver_acpi_acquire_global_lock not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_generate_event_R__ver_acpi_bus_generate_event not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_get_device_R__ver_acpi_bus_get_device not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_get_power_R__ver_acpi_bus_get_power not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_get_status_R__ver_acpi_bus_get_status not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_receive_event_R__ver_acpi_bus_receive_event not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_register_driver_R__ver_acpi_bus_register_driver not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_scan_R__ver_acpi_bus_scan not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_set_power_R__ver_acpi_bus_set_power not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_bus_unregister_driver_R__ver_acpi_bus_unregister_driver not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_clear_event_R__ver_acpi_clear_event not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_disable_event_R__ver_acpi_disable_event not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_enable_event_R__ver_acpi_enable_event not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_enter_sleep_state_R__ver_acpi_enter_sleep_state not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_enter_sleep_state_s4bios_R__ver_acpi_enter_sleep_state_s4bios not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_evaluate_integer_R__ver_acpi_evaluate_integer not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_evaluate_object_R__ver_acpi_evaluate_object not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_evaluate_reference_R__ver_acpi_evaluate_reference not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_extract_package_R__ver_acpi_extract_package not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_current_resources_R__ver_acpi_get_current_resources not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_devices_R__ver_acpi_get_devices not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_firmware_table_R__ver_acpi_get_firmware_table not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_handle_R__ver_acpi_get_handle not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_name_R__ver_acpi_get_name not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_next_object_R__ver_acpi_get_next_object not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_object_info_R__ver_acpi_get_object_info not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_parent_R__ver_acpi_get_parent not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_possible_resources_R__ver_acpi_get_possible_resources not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_register_R__ver_acpi_get_register not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_sleep_type_data_R__ver_acpi_get_sleep_type_data not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_system_info_R__ver_acpi_get_system_info not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_table_R__ver_acpi_get_table not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_timer_R__ver_acpi_get_timer not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_timer_duration_R__ver_acpi_get_timer_duration not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_get_type_R__ver_acpi_get_type not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_init_R__ver_acpi_init not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_install_address_space_handler_R__ver_acpi_install_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_install_fixed_event_handler_R__ver_acpi_install_fixed_event_handler
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_install_gpe_block_R__ver_acpi_install_gpe_block not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_install_gpe_handler_R__ver_acpi_install_gpe_handler not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_install_notify_handler_R__ver_acpi_install_notify_handler not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_create_semaphore_R__ver_acpi_os_create_semaphore not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_delete_semaphore_R__ver_acpi_os_delete_semaphore not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_free_R__ver_acpi_os_free not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_printf_R__ver_acpi_os_printf not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_queue_for_execution_R__ver_acpi_os_queue_for_execution not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_read_pci_configuration_R__ver_acpi_os_read_pci_configuration not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_signal_R__ver_acpi_os_signal not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_signal_semaphore_R__ver_acpi_os_signal_semaphore not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_sleep_R__ver_acpi_os_sleep not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_stall_R__ver_acpi_os_stall not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_os_wait_semaphore_R__ver_acpi_os_wait_semaphore not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_pci_irq_enable_R__ver_acpi_pci_irq_enable not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_pci_irq_lookup_R__ver_acpi_pci_irq_lookup not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_pci_register_driver_R__ver_acpi_pci_register_driver not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_pci_unregister_driver_R__ver_acpi_pci_unregister_driver not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_release_global_lock_R__ver_acpi_release_global_lock not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_remove_address_space_handler_R__ver_acpi_remove_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_remove_fixed_event_handler_R__ver_acpi_remove_fixed_event_handler
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_remove_gpe_block_R__ver_acpi_remove_gpe_block not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_remove_gpe_handler_R__ver_acpi_remove_gpe_handler not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_remove_notify_handler_R__ver_acpi_remove_notify_handler not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_root_dir_R__ver_acpi_root_dir not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_set_current_resources_R__ver_acpi_set_current_resources not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_set_register_R__ver_acpi_set_register not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_walk_namespace_R__ver_acpi_walk_namespace not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
acpi_walk_resources_R__ver_acpi_walk_resources not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
create_bounce_R__ver_create_bounce not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
default_idle_R__ver_default_idle not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol ec_read_R__ver_ec_read not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ec_write_R__ver_ec_write not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
highmem_start_page_R__ver_highmem_start_page not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
ip_ct_attach_R__ver_ip_ct_attach not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
ip_route_me_harder_R__ver_ip_route_me_harder not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kmap_high_R__ver_kmap_high not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kmap_prot_R__ver_kmap_prot not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kmap_pte_R__ver_kmap_pte not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kunmap_high_R__ver_kunmap_high
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
machine_real_restart_R__ver_machine_real_restart not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_getsockopt_R__ver_nf_getsockopt not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_hook_slow_R__ver_nf_hook_slow not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_hooks_R__ver_nf_hooks not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_hook_R__ver_nf_register_hook not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_queue_handler_R__ver_nf_register_queue_handler not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_sockopt_R__ver_nf_register_sockopt not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_reinject_R__ver_nf_reinject
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_setsockopt_R__ver_nf_setsockopt not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_hook_R__ver_nf_unregister_hook not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_queue_handler_R__ver_nf_unregister_queue_handler not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_sockopt_R__ver_nf_unregister_sockopt not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
sk_chk_filter_R__ver_sk_chk_filter not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
sk_run_filter_R__ver_sk_run_filter not found in System.map.  Ignoring
ksyms_base entry
NMI Watchdog detected LOCKUP on CPU1, eip c01a51f7, registers:
CPU: 1
EIP: 0010: [<c01a51f7>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0000046
eax: 00000011 ebx: f7cabe48 ecx: f7cabe48 edx: 00000400
esi: 00000010 edi: 00000000 ebp: bffffcc8 esp: f7cabe08
ds: 0018 es: 0018 ss: 0018
Process halt (pid: 1218, stackpage=f7cab000)
Stack: 00000000 c01b146b 00000400 f7cabe48 00000010 00002001 c02e3b98
00000000
       00002001 c01b1177 00000010 f7cabe48 c1c32114 00002001 002e3b98
00000000
       00000000 c01b0f59 00000000 00000001 f7cabe68 00002001 c02e3bc0
c02e3bc8
Call Trace: [<c01b146b>] [<c01b1177>] [<c01b0f59>] [<c01b17fe>]
[<c01bfe34>]
  [<c0105523>] [<c012331d>] [<c012182a>] [<c01218b1>] [<c0121ba6>]
[<c0122445>]
  [<c0140304>] [<c0147fed>] [<c0106f27>]
Code: 66 89 01 eb 11 8d 74 26 00 ed 89 01 eb 08 0f 0b 4f 01 2c df


>>EIP; c01a51f7 <acpi_os_read_port+37/54>   <=====

>>ebx; f7cabe48 <_end+3792ffe4/385d11fc>
>>ecx; f7cabe48 <_end+3792ffe4/385d11fc>
>>esp; f7cabe08 <_end+3792ffa4/385d11fc>

Trace; c01b146b <acpi_hw_low_level_read+67/ac>
Trace; c01b1177 <acpi_hw_register_read+63/178>
Trace; c01b0f59 <acpi_get_register+51/88>
Trace; c01b17fe <acpi_enter_sleep_state+1a2/1bc>
Trace; c01bfe34 <acpi_power_off+34/44>
Trace; c0105523 <machine_power_off+b/c>
Trace; c012331d <sys_reboot+161/248>
Trace; c012182a <deliver_signal+7a/80>
Trace; c01218b1 <send_sig_info+81/98>
Trace; c0121ba6 <kill_something_info+146/158>
Trace; c0122445 <sys_kill+4d/58>
Trace; c0140304 <blkdev_ioctl+28/34>
Trace; c0147fed <sys_ioctl+2e1/2ea>
Trace; c0106f27 <system_call+33/38>

Code;  c01a51f7 <acpi_os_read_port+37/54>
00000000 <_EIP>:
Code;  c01a51f7 <acpi_os_read_port+37/54>   <=====
   0:   66 89 01                  mov    %ax,(%ecx)   <=====
Code;  c01a51fa <acpi_os_read_port+3a/54>
   3:   eb 11                     jmp    16 <_EIP+0x16>
Code;  c01a51fc <acpi_os_read_port+3c/54>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01a5200 <acpi_os_read_port+40/54>
   9:   ed                        in     (%dx),%eax
Code;  c01a5201 <acpi_os_read_port+41/54>
   a:   89 01                     mov    %eax,(%ecx)
Code;  c01a5203 <acpi_os_read_port+43/54>
   c:   eb 08                     jmp    16 <_EIP+0x16>
Code;  c01a5205 <acpi_os_read_port+45/54>
   e:   0f 0b                     ud2a   
Code;  c01a5207 <acpi_os_read_port+47/54>
  10:   4f                        dec    %edi
Code;  c01a5208 <acpi_os_read_port+48/54>
  11:   01 2c df                  add    %ebp,(%edi,%ebx,8)


94 warnings issued.  Results may not be reliable.
faerun:~# cat /proc/version
Linux version 2.4.24-cryptosmp (root@faerun) (gcc version 2.95.4
20011002 (Debian prerelease)) #5 SMP Tue Jan 27 21:22:52 PST 2004
faerun:~# cat /proc/modules
joydev                  7104   0 (unused)
mousedev                3864   0 (unused)
hid                    13864   0 (unused)
input                   3456   0 [joydev mousedev hid]
binfmt_misc             5896   1
uhci                   24752   0 (unused)
ide-scsi                8976   0
scsi_mod               87496   1 [ide-scsi]
v_midi                  4996   0 (unused)
sound                  56428   0 [v_midi]
i810_audio             24312   0 (unused)
ehci-hcd               15880   0 (unused)
faerun:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0500-051f : Intel Corp. 82801EB SMBus Controller
0cf8-0cff : PCI conf1
9000-90ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  9000-90ff : 8139too
9400-947f : VIA Technologies, Inc. IEEE 1394 Host Controller
a000-a01f : Intel Corp. 82801EB USB
  a000-a01f : usb-uhci
a400-a41f : Intel Corp. 82801EB USB
  a400-a41f : usb-uhci
a800-a81f : Intel Corp. 82801EB USB
  a800-a81f : usb-uhci
ac00-ac1f : Intel Corp. 82801EB USB
  ac00-ac1f : usb-uhci
b400-b4ff : Intel Corp. 82801EB AC'97 Audio Controller
  b400-b4ff : Intel ICH5
b800-b83f : Intel Corp. 82801EB AC'97 Audio Controller
  b800-b83f : Intel ICH5
f000-f00f : Intel Corp. 82801EB Ultra ATA Storage Controller
  f000-f007 : ide0
  f008-f00f : ide1
faerun:~# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0027f955 : Kernel code
  0027f956-0031c5bf : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : PCI device 10de:0322 (nVidia Corporation)
f0000000-f3ffffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
f4000000-f5ffffff : PCI Bus #01
  f4000000-f4ffffff : PCI device 10de:0322 (nVidia Corporation)
f7000000-f70000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  f7000000-f70000ff : 8139too
f7001000-f70017ff : VIA Technologies, Inc. IEEE 1394 Host Controller
f8000000-f80003ff : Intel Corp. 82801EB USB2
  f8000000-f80003ff : ehci_hcd
f8001000-f80011ff : Intel Corp. 82801EB AC'97 Audio Controller
  f8001000-f80011ff : ich_audio MMBAR
f8002000-f80020ff : Intel Corp. 82801EB AC'97 Audio Controller
  f8002000-f80020ff : ich_audio MBBAR
fec00000-ffffffff : reserved
faerun:~# 


On Thu, 2004-01-29 at 10:11, tomepperly@comcast.net wrote:
> [1.] CPU lockup during halt for Shuttle SB61G2 p4 with hyperthreading
> 
> [2.] Full description
> I've got a Shuttle SB61G2 purchased 12/31/03 with a 2.6GHz P4 with
> hyperthreading. Sometimes when shutting down, I get the "Power down."
> message, but it doesn't actually power down the system. It just sits
> there indefinitely. I tried enabling nmi_watchdog=1, and I
> intermittently get kernel oopses. I only started having problems when I
> compiled the kernel with SMP enabled. A non-SMP kernel never locks up.
> 
> I transcribed the oops message from my screen and ran ksymoops on it. I
> am running a vanilla 2.4.24 downloaded from kernel.org compiled with
> gcc-2.95.
> 
> Please Cc me on replies as I am not subscribed to linux-kernel.
> 
> [3.] Keywords: Lockup SMP
> [4.] Linux version 2.4.24-vanilla (root@faerun) (gcc version 2.95.4
> 20011002 (Debian prerelease)) #3 SMP Fri Jan 16 07:30:34 PST 2004
> [5.] 
> I had to write this on paper and then type it in by hand. I was very
> careful, but transcription errors are always a possibility:
> ksymoops 2.4.9 on i686 2.4.24-vanilla.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.24-vanilla/ (default)
>      -m /boot/System.map-2.4.24-vanilla (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Error (regular_file): read_system_map stat
> /boot/System.map-2.4.24-vanilla failed
> ksymoops: No such file or directory
> Warning (compare_maps): mismatch on symbol _nv000173rm  , nvidia says
> f8e4bb20, /lib/modules/2.4.24-vanilla/kernel/drivers/video/nvidia.o says
> f8e4b900.  Ignoring
> /lib/modules/2.4.24-vanilla/kernel/drivers/video/nvidia.o entry
> NMI Watchdog detected LOCKUP on CPU1, eip c01a6757, registers:
> EIP: 0010: [<c01a6757>] Tainted: P
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00000046
> eax: 00000011 ebx: f7cc9e48 ecx: f7cc9e48 edx: 00000400
> esi: 00000010 edi: 00000000 ebp: bffffbc8 esp: f7cc9e08
> ds: 0018 es: 0018 ss: 0018
> Process halt (pid: 1220, stackpage=f7cc9000)
> Stack: 00000018 c01b29cb 00000400 f7cc9e48 00000010 00002001 c02e5e18
> 00000011
>        c02e5e18 c01b26d7 00000010 f7cc9e48 c1c32114 00002001 00000000
> 00000000
>        00000000 c01b24b9 00000000 00000001 f7cc9e68 00002001 c02e5e40
> c02e5e40
> Call Trace: [<c01b29cb>] [<c01b26d7>] [<c01b24b9>] [<c01b2d5e>]
> [<c01c1394>]
>  [<c0105523>] [<c012487d>] [<c0122d8a>] [<c0122e11>] [<c01231067>]
> [<c01239a5>]
>  [<c0141864>] [<c014954d>] [<c0106f27>]
> Code: 66 89 01 eb 11 eb 11 8d 74 26 00 ed 89 01 eb 08 0f 0b 4f 01 ec ff
> 
> 
> >>EIP; c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>   <=====
> 
> >>ebx; f7cc9e48 <_end+3794bfe4/385cf1fc>
> >>ecx; f7cc9e48 <_end+3794bfe4/385cf1fc>
> >>esp; f7cc9e08 <_end+3794bfa4/385cf1fc>
> 
> Trace; c01b29cb <acpi_set_register_R__ver_acpi_set_register+4db/6cc>
> Trace; c01b26d7 <acpi_set_register_R__ver_acpi_set_register+1e7/6cc>
> Trace; c01b24b9 <acpi_get_register_R__ver_acpi_get_register+51/88>
> Trace; c01b2d5e
> <acpi_enter_sleep_state_R__ver_acpi_enter_sleep_state+1a2/1bc>
> Trace; c01c1394
> <acpi_pci_irq_enable_R__ver_acpi_pci_irq_enable+bb4/2868>
> Trace; c0105523 <machine_power_off+b/314>
> Trace; c012487d <unregister_reboot_notifier+365/11a4>
> Trace; c0122d8a <dequeue_signal+432/438>
> Trace; c0122e11 <send_sig_info+81/98>
> Trace; c01231067 <END_OF_CODE+b083c2710/????>
> Trace; c01239a5 <notify_parent+685/edc>
> Trace; c0141864 <blkdev_put+148/154>
> Trace; c014954d <kill_fasync+4f5/528>
> Trace; c0106f27 <__read_lock_failed+115f/1520>
> 
> Code;  c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>
> 00000000 <_EIP>:
> Code;  c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>   <=====
>    0:   66 89 01                  mov    %ax,(%ecx)   <=====
> Code;  c01a675a <acpi_os_stall_R__ver_acpi_os_stall+6a/17c>
>    3:   eb 11                     jmp    16 <_EIP+0x16>
> Code;  c01a675c <acpi_os_stall_R__ver_acpi_os_stall+6c/17c>
>    5:   eb 11                     jmp    18 <_EIP+0x18>
> Code;  c01a675e <acpi_os_stall_R__ver_acpi_os_stall+6e/17c>
>    7:   8d 74 26 00               lea    0x0(%esi,1),%esi
> Code;  c01a6762 <acpi_os_stall_R__ver_acpi_os_stall+72/17c>
>    b:   ed                        in     (%dx),%eax
> Code;  c01a6763 <acpi_os_stall_R__ver_acpi_os_stall+73/17c>
>    c:   89 01                     mov    %eax,(%ecx)
> Code;  c01a6765 <acpi_os_stall_R__ver_acpi_os_stall+75/17c>
>    e:   eb 08                     jmp    18 <_EIP+0x18>
> Code;  c01a6767 <acpi_os_stall_R__ver_acpi_os_stall+77/17c>
>   10:   0f 0b                     ud2a   
> Code;  c01a6769 <acpi_os_stall_R__ver_acpi_os_stall+79/17c>
>   12:   4f                        dec    %edi
> Code;  c01a676a <acpi_os_stall_R__ver_acpi_os_stall+7a/17c>
>   13:   01 ec                     add    %ebp,%esp
> Code;  c01a676c <acpi_os_stall_R__ver_acpi_os_stall+7c/17c>
>   15:   ff 00                     incl   (%eax)
> 
> 
> 2 warnings and 1 error issued.  Results may not be reliable.
> 
> [6.]
> I booted my machine. gdm (X11) fires up using nVidia drivers. Choose
> shutdown from gdm menu. Oops. It happens every once in a while when I
> shutdown.
> [7.]
> [7.1]
> faerun:/usr/src/linux-2.4.24# sh scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>   
> Linux faerun 2.4.24-vanilla #3 SMP Fri Jan 16 07:30:34 PST 2004 i686
> GNU/Linux
>   
> Gnu C                  3.3.3
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> modutils               2.4.26
> e2fsprogs              1.35-WIP
> PPP                    2.4.2
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.1.15
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.0.91
> Modules Loaded         nvidia joydev mousedev hid input binfmt_misc uhci
> ide-scsi scsi_mod it87 i2c-proc i2c-isa i2c-core v_midi sound i810_audio
> ehci-hcd
> 
> I used "make CC=gcc-2.95 HOSTCC=gcc-2.95" when compiling the kernel and
> its modules.
> 
> faerun:/usr/src/linux-2.4.24#
> [7.2.]
> faerun:/usr/src/linux-2.4.24# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
> stepping        : 9
> cpu MHz         : 2605.987
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5203.55
>  
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
> stepping        : 9
> cpu MHz         : 2605.987
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5203.55
> 
> Intel 865G chipset
> faerun:/usr/src/linux-2.4.24#
> [7.3.]
> faerun:/usr/src/linux-2.4.24# cat /proc/modules
> nvidia               1969376  14 (autoclean)
> joydev                  7104   0 (unused)
> mousedev                3864   1
> hid                    13864   0 (unused)
> input                   3456   0 [joydev mousedev hid]
> binfmt_misc             5896   1
> uhci                   24752   0 (unused)
> ide-scsi                8976   0
> scsi_mod               87496   1 [ide-scsi]
> it87                    9768   0 (unused)
> i2c-proc                5972   0 [it87]
> i2c-isa                  788   0 (unused)
> i2c-core               14788   0 [it87 i2c-proc i2c-isa]
> v_midi                  4996   0 (unused)
> sound                  56428   0 [v_midi]
> i810_audio             24312   1
> ehci-hcd               15880   0 (unused)
> faerun:/usr/src/linux-2.4.24#
> [7.4.]
> faerun:/usr/src/linux-2.4.24# cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0290-0297 : it87
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(set)
> 0500-051f : Intel Corp. 82801EB SMBus Controller
> 0cf8-0cff : PCI conf1
> 9000-90ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
>   9000-90ff : 8139too
> 9400-947f : VIA Technologies, Inc. IEEE 1394 Host Controller
> a000-a01f : Intel Corp. 82801EB USB
>   a000-a01f : usb-uhci
> a400-a41f : Intel Corp. 82801EB USB
>   a400-a41f : usb-uhci
> a800-a81f : Intel Corp. 82801EB USB
>   a800-a81f : usb-uhci
> ac00-ac1f : Intel Corp. 82801EB USB
>   ac00-ac1f : usb-uhci
> b400-b4ff : Intel Corp. 82801EB AC'97 Audio Controller
>   b400-b4ff : Intel ICH5
> b800-b83f : Intel Corp. 82801EB AC'97 Audio Controller
>   b800-b83f : Intel ICH5
> f000-f00f : Intel Corp. 82801EB Ultra ATA Storage Controller
>   f000-f007 : ide0
>   f008-f00f : ide1
> faerun:/usr/src/linux-2.4.24# cat /proc/iomem
> 00000000-0009f7ff : System RAM
> 0009f800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-3ffeffff : System RAM
>   00100000-00281001 : Kernel code
>   00281002-0031e83f : Kernel data
> 3fff0000-3fff2fff : ACPI Non-volatile Storage
> 3fff3000-3fffffff : ACPI Tables
> 40000000-400003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
> e8000000-efffffff : PCI Bus #01
>   e8000000-efffffff : PCI device 10de:0322 (nVidia Corporation)
> f0000000-f3ffffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
> f4000000-f5ffffff : PCI Bus #01
>   f4000000-f4ffffff : PCI device 10de:0322 (nVidia Corporation)
> f7000000-f70000ff : Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+
>   f7000000-f70000ff : 8139too
> f7001000-f70017ff : VIA Technologies, Inc. IEEE 1394 Host Controller
> f8000000-f80003ff : Intel Corp. 82801EB USB2
>   f8000000-f80003ff : ehci_hcd
> f8001000-f80011ff : Intel Corp. 82801EB AC'97 Audio Controller
>   f8001000-f80011ff : ich_audio MMBAR
> f8002000-f80020ff : Intel Corp. 82801EB AC'97 Audio Controller
>   f8002000-f80020ff : ich_audio MBBAR
> fec00000-ffffffff : reserved
> faerun:/usr/src/linux-2.4.24#
> [7.5.]
> faerun:/usr/src/linux-2.4.24# lspci -vvv
> 00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller
> (rev 02)
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [e4] #09 [0106]
>         Capabilities: [a0] AGP version 3.0
>                 Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                 Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW-
> Rate=x8 
> 00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller
> (rev 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: f4000000-f5ffffff
>         Prefetchable memory behind bridge: e8000000-efffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>  
> 00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
> [UHCI])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 16
>         Region 4: I/O ports at ac00 [size=32]
>  
> 00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
> [UHCI])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 19
>         Region 4: I/O ports at a000 [size=32]
>  
> 00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
> [UHCI])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 18
>         Region 4: I/O ports at a400 [size=32]
>  
> 00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
> [UHCI])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 16
>         Region 4: I/O ports at a800 [size=32]
>  
> 00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20
> [EHCI])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 23
>         Region 0: Memory at f8000000 (32-bit, non-prefetchable)
> [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
> (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: f6000000-f7ffffff
>         Prefetchable memory behind bridge: fff00000-000fffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>  
> 00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev
> 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>  
> 00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
> (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 18
>         Region 0: I/O ports at <unassigned>
>         Region 1: I/O ports at <unassigned>
>         Region 2: I/O ports at <unassigned>
>         Region 3: I/O ports at <unassigned>
>         Region 4: I/O ports at f000 [size=16]
>         Region 5: Memory at 40000000 (32-bit, non-prefetchable)
> [size=1K]
>  
> 00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device fb61
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 17
>         Region 4: I/O ports at 0500 [size=32]
>  
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
> Controller (rev 02)
>         Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
> device c09d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 17
>         Region 0: I/O ports at b400 [size=256]
>         Region 1: I/O ports at b800 [size=64]
>         Region 2: Memory at f8001000 (32-bit, non-prefetchable)
> [size=512]
>         Region 3: Memory at f8002000 (32-bit, non-prefetchable)
> [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX
> 5200] (rev a1) (prog-if 00 [VGA])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (1250ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at f4000000 (32-bit, non-prefetchable)
> [size=16M]
>         Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 3.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
> FW- Rate=x8
>  
> 02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 18
>         Region 0: I/O ports at 9000 [size=256]
>         Region 1: Memory at f7000000 (32-bit, non-prefetchable)
> [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 02:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 80) (prog-if 10 [OHCI])
>         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 20
>         Region 0: Memory at f7001000 (32-bit, non-prefetchable)
> [size=2K]
>         Region 1: I/O ports at 9400 [size=128]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> faerun:/usr/src/linux-2.4.24#
> [7.6.]
> faerun:/usr/src/linux-2.4.24# cat /proc/scsi/scsi
> Attached devices: none
> [7.7.]
> faerun:/usr/src/linux-2.4.24# cat /proc/acpi/info
> version:                 20031002
> states:                  S0 S1 S4 S5
> faerun:/usr/src/linux-2.4.24# cat /proc/acpi/alarm
> 2004-01-27 11:00:10

