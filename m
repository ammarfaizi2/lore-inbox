Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTFRDlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 23:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFRDlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 23:41:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45722 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265055AbTFRDlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 23:41:13 -0400
Date: Tue, 17 Jun 2003 20:53:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 823] New: 2.5.67 > panics on boot with latest thinkpad bios 2.04 
Message-ID: <3970000.1055908428@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: 2.5.67 > panics on boot with latest thinkpad bios 2.04
    Kernel Version: 2.5.72
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: phillim2@comcast.net


Distribution: Debian sid
Hardware Environment: Thinkpad T30 P4-M 1.8Ghz
Software Environment: 
Problem Description: Panic on boot

Steps to reproduce: Press on button :

Two logs, without #define ACPI_DEBUG_OUTPUT and with #define ACPI_DEBUG_OUPUT

No ACPI_DEBUG_OUTPUT: 

€Linux version 2.5.72 (root@debian-t30) (gcc version 3.3 (Debian)) #2 Tue Jun 17
21:04:31 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7e000 (ACPI data)
 BIOS-e820: 000000001ff7e000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7010
ACPI: XSDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff73216
ACPI: FADT (v001 IBM    TP-1I    00000.08256) @ 0x1ff73300
ACPI: SSDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff733b4
ACPI: ECDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff7de73
ACPI: TCPA (v001 IBM    TP-1I    00000.08256) @ 0x1ff7dec5
ACPI: BOOT (v001 IBM    TP-1I    00000.08256) @ 0x1ff7dfd8
ACPI: DSDT (v001 IBM    TP-1I    00000.08256) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 ro hdc=idesci console=ttyS0 
ide_setup: hdc=idesci -- BAD OPTION
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1798.765 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3555.32 BogoMIPS
Memory: 512692k/523712k available (3581k kernel code, 10280k reserved, 1071k
data, 180k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: Embedded Controller [EC] (gpe 28)
drivers/acpi/ec.c:162: spin_is_locked on uninitialized spinlock dfdfec28.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0263f69
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0263f69>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2fc/0x43b
eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
esi: c05bd581   edi: 00000000   ebp: dff0ba94   esp: dff0ba5c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff0a000 task=dff0f480)
Stack: c05bd572 c05bd95f 000000a2 00000000 0000000a ffffffff 00000002 00000002 
       ffffffff ffffffff c05bd95f c05bd560 00000046 dff0bb10 dff0bae4 c0123009 
       c05bd560 00000400 c0492ef2 dff0bafc 00000400 c0492e57 dff0bb08 dff0bad4 
Call Trace:
 [<c0123009>] printk+0x17a/0x3f2
 [<c0287589>] acpi_ut_release_mutex+0x69/0x72
 [<c028aa7f>] acpi_ec_read+0xc3/0x1be
 [<c028b19a>] acpi_ec_space_handler+0x55/0xa9
 [<c028b145>] acpi_ec_space_handler+0x0/0xa9
 [<c02770a3>] acpi_ev_address_space_dispatch+0xcf/0x128
 [<c027a710>] acpi_ex_access_region+0x45/0x50
 [<c027a85a>] acpi_ex_field_datum_io+0x103/0x174
 [<c027aad3>] acpi_ex_extract_from_field+0x80/0x235
 [<c0279550>] acpi_ex_read_data_from_field+0x128/0x15a
 [<c027dbde>] acpi_ex_resolve_node_to_value+0xaa/0xd8
 [<c0279cbc>] acpi_ex_resolve_to_value+0x3c/0x4b
 [<c027bccf>] acpi_ex_resolve_operands+0x194/0x2d5
 [<c027507c>] acpi_ds_exec_end_op+0x96/0x23a
 [<c0282036>] acpi_ps_parse_loop+0x578/0x8c7
 [<c0287589>] acpi_ut_release_mutex+0x69/0x72
 [<c027396a>] acpi_os_wait_semaphore+0x89/0xf1
 [<c0287589>] acpi_ut_release_mutex+0x69/0x72
 [<c0286685>] acpi_ut_acquire_from_cache+0x50/0xb1
 [<c0287624>] acpi_ut_create_generic_state+0xa/0x14
 [<c02823dc>] acpi_ps_parse_aml+0x57/0x193
 [<c0282d0c>] acpi_psx_execute+0x158/0x1a4
 [<c027ff01>] acpi_ns_execute_control_method+0x42/0x52
 [<c027fe98>] acpi_ns_evaluate_by_handle+0x6f/0x96
 [<c027fd8f>] acpi_ns_evaluate_relative+0x97/0xad
 [<c0287506>] acpi_ut_acquire_mutex+0x5e/0x78
 [<c027f68e>] acpi_evaluate_object+0x103/0x1a5
 [<c0273d64>] acpi_evaluate_integer+0x32/0x52
 [<c027f716>] acpi_evaluate_object+0x18b/0x1a5
 [<c028ca9a>] acpi_power_get_state+0x2a/0x4b
 [<c028d04c>] acpi_power_add+0xce/0x14b
 [<c029059e>] acpi_bus_driver_init+0x2d/0x8f
 [<c0290e6e>] acpi_bus_find_driver+0x16f/0x2b8
 [<c0291426>] acpi_bus_add+0x127/0x155
 [<c0291551>] acpi_bus_scan+0xfd/0x148
 [<c059af17>] acpi_scan_init+0x51/0x6e
 [<c058e779>] do_initcalls+0x2a/0x96
 [<c0137965>] init_workqueues+0x12/0x29
 [<c010519c>] init+0x9f/0x2fb
 [<c01050fd>] init+0x0/0x2fb
 [<c01050fd>] init+0x0/0x2fb
 [<c0107411>] kernel_thread_helper+0x5/0xb

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 
 <0>Kernel panic: Attempted to kill init!
 
With ACPI_DEBUG_OUPUT defined: 

€Linux version 2.5.72 (root@debian-t30) (gcc version 3.3 (Debian)) #2 Tue Jun 17
21:04:31 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7e000 (ACPI data)
 BIOS-e820: 000000001ff7e000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7010
ACPI: XSDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff73216
ACPI: FADT (v001 IBM    TP-1I    00000.08256) @ 0x1ff73300
ACPI: SSDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff733b4
ACPI: ECDT (v001 IBM    TP-1I    00000.08256) @ 0x1ff7de73
ACPI: TCPA (v001 IBM    TP-1I    00000.08256) @ 0x1ff7dec5
ACPI: BOOT (v001 IBM    TP-1I    00000.08256) @ 0x1ff7dfd8
ACPI: DSDT (v001 IBM    TP-1I    00000.08256) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 ro hdc=idesci console=ttyS0 
ide_setup: hdc=idesci -- BAD OPTION
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1798.871 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3555.32 BogoMIPS
Memory: 512548k/523712k available (3664k kernel code, 10424k reserved, 1128k
data, 180k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:.....................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 1241 Objects with 62 Devices 373 Methods 19 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c05f5a3c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0743 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
0000000000001028 on int 9
evgpeblk-0743 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at
000000000000102C on int 9
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L18 as GPE
number 0x18
ACPI: Found ECDT
Completing Region/Field/Buffer/Package
initialization:..................................................................................................................................................................................................................................................
Initialized 18/19 Regions 123/123 Fields 67/67 Buffers 34/34 Packages (1250 nodes)
Executing all Device _STA and_INI
methods:.........................................................
57 Devices found containing: 57 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: Embedded Controller [EC] (gpe 28)
Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c0294f99
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0294f99>]    Not tainted
EFLAGS: 00010202
EIP is at acpi_ut_remove_allocation+0xb5/0x126
eax: 6b6b6b6b   ebx: dfdbc1f4   ecx: 00000000   edx: 6b6b6b6b
esi: 00000000   edi: 00000000   ebp: dff0b8cc   esp: dff0b8b0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff0a000 task=dff0f480)
Stack: 00000001 c04c4e33 c04c4d91 00200000 dfdbc1f4 dff0b8e8 dfdbc21c dff0b904 
       c0294d15 00000000 dfdbc1f4 00000004 c04c1720 00000131 00000001 c04c4ddb 
       c04c4d91 c04c25fe 00000000 00000000 dfdbc1b8 dff0b948 c027a391 dfdbc21c 
Call Trace:
 [<c0294d15>] acpi_ut_free_and_track+0x7f/0xd3
 [<c027a391>] acpi_ev_address_space_dispatch+0x193/0x27f
 [<c027fd85>] acpi_ex_access_region+0xd6/0x168
 [<c027fda5>] acpi_ex_access_region+0xf6/0x168
 [<c027ffa9>] acpi_ex_field_datum_io+0x156/0x26c
 [<c0280421>] acpi_ex_extract_from_field+0xf1/0x2e7
 [<c028452e>] acpi_ex_acquire_global_lock+0x7f/0x89
 [<c027e13e>] acpi_ex_read_data_from_field+0x1be/0x210
 [<c027e150>] acpi_ex_read_data_from_field+0x1d0/0x210
 [<c0285b86>] acpi_ex_resolve_node_to_value+0x212/0x2cc
 [<c027ecb6>] acpi_ex_resolve_to_value+0x8a/0xcd
 [<c0281dd8>] acpi_ex_resolve_operands+0x393/0x66b
 [<c0276961>] acpi_ds_exec_end_op+0xe9/0x414
 [<c028d25a>] acpi_ps_parse_loop+0x736/0xb18
 [<c02948d4>] acpi_ut_acquire_from_cache+0x81/0xe4
 [<c029544e>] acpi_ut_exit+0x1e/0x26
 [<c027973b>] acpi_ds_push_walk_state+0x4a/0x52
 [<c028d6de>] acpi_ps_parse_aml+0xa2/0x250
 [<c028d6fc>] acpi_ps_parse_aml+0xc0/0x250
 [<c028e417>] acpi_psx_execute+0x213/0x290
 [<c0289901>] acpi_ns_execute_control_method+0xd4/0xf1
 [<c02897ef>] acpi_ns_evaluate_by_handle+0xcc/0x10a
 [<c0289598>] acpi_ns_evaluate_relative+0x12c/0x178
 [<c029549f>] acpi_ut_status_exit+0x49/0x59
 [<c02953a4>] acpi_ut_trace+0x29/0x2b
 [<c0288aa7>] acpi_evaluate_object+0x167/0x24f
 [<c02953a4>] acpi_ut_trace+0x29/0x2b
 [<c0274365>] acpi_evaluate_integer+0x7b/0x19d
 [<c029544e>] acpi_ut_exit+0x1e/0x26
 [<c029549f>] acpi_ut_status_exit+0x49/0x59
 [<c02953a4>] acpi_ut_trace+0x29/0x2b
 [<c029f494>] acpi_power_get_state+0x5e/0xc5
 [<c029ff13>] acpi_power_add+0x125/0x1c4
 [<c02a4f58>] acpi_bus_driver_init+0x82/0x131
 [<c02a59ab>] acpi_bus_find_driver+0x197/0x2f4
 [<c02a6010>] acpi_bus_add+0x188/0x1ca
 [<c02a6186>] acpi_bus_scan+0x134/0x192
 [<c05bf4ab>] acpi_scan_init+0x89/0xb9
 [<c05b2779>] do_initcalls+0x2a/0x96
 [<c0137965>] init_workqueues+0x12/0x29
 [<c010519c>] init+0x9f/0x2fb
 [<c01050fd>] init+0x0/0x2fb
 [<c01050fd>] init+0x0/0x2fb
 [<c0107411>] kernel_thread_helper+0x5/0xb


