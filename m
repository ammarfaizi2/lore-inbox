Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTJRSAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJRSAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:00:12 -0400
Received: from 49.144-200-80.adsl.skynet.be ([80.200.144.49]:27909 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S261754AbTJRR7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:59:25 -0400
Message-ID: <3F917EFC.7020102@trollprod.org>
Date: Sat, 18 Oct 2003 19:57:16 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031009
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test8: panic on boot
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040401020107010106050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401020107010106050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Distribution: Suse 8.2
Hardware Environment: Compaq Armada E500
Software Environment:
Problem Description: Panic on boot



Linux version 2.6.0-test8 (root@bia) (gcc version 3.3 (SuSE Linux)) #3 
Sat Oct 18 19:00:41 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
  BIOS-e820: 0000000007ff0000 - 0000000007ff3800 (reserved)
  BIOS-e820: 0000000007ff3800 - 0000000008000000 (ACPI NVS)
127MB LOWMEM available.
On node 0 totalpages: 32752
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 28656 pages, LIFO batch:6
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ RSDTBL   0x00000001 CPQ  0x00000001) @ 0x07ff4800
ACPI: FADT (v001 COMPAQ CPQB151  0x20020315 CPQ  0x00000001) @ 0x07ff4828
ACPI: DSDT (v001 COMPAQ ARMADAE7 0x00010000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: splash=silent root=/dev/hda6 console=ttyS0,57600n8 
console=tty0
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 597.007 MHz processor.
Console: colour VGA+ 80x25
Memory: 126084k/131008k available (2029k kernel code, 4388k reserved, 
774k data, 132k init, 0k highmem)
Calibrating delay loop... 1179.64 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0478, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
Parsing all Control 
Methods:.............................................................................................................................................................................
Table [DSDT](id F004) - 614 Objects with 75 Devices 173 Methods 25 Regions
ACPI Namespace successfully loaded at root c03effdc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
000000000000500C on int 9
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: C16A 
(name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: C135 
(name not of form _Lnn or _Enn)
Completing Region/Field/Buffer/Package 
initialization:.............................................................................
Initialized 25/25 Regions 0/0 Fields 19/19 Buffers 33/33 Packages (622 
nodes)
Executing all Device _STA and_INI 
methods:............................................................................
76 Devices found containing: 76 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
dsopcode-0526 [19] ds_init_buffer_field  : <1>Unable to handle kernel 
NULL pointer dereference at virtual address 00000004
  printing eip:
c01de05e
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01de05e>]    Not tainted
EFLAGS: 00010213
EIP is at vsnprintf+0x28e/0x4e0
eax: 00000004   ebx: 0000000a   ecx: 00000004   edx: 00000003
esi: c03efae7   edi: ffffffff   ebp: 00000000   esp: c114bac0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c114a000 task=c117b8c0)
Stack: c114bb08 ffffffff 000004a0 00000000 0000000a ffffffff 00000003 
00000002
        00000004 00000004 ffffffff 00000001 c114bb68 c7f02c48 c7f02ee8 
c01de307
        c03efac0 3fc10540 c03292ea c114bb60 c01e6579 c03efac0 c03292c0 
c114bb54
Call Trace:
  [<c01de307>] vsprintf+0x27/0x30
  [<c01e6579>] acpi_os_vprintf+0x12/0x2a
  [<c020992b>] acpi_ut_debug_print+0x97/0x9d
  [<c01e91d2>] acpi_ds_init_buffer_field+0x18d/0x20c
  [<c01e93ac>] acpi_ds_eval_buffer_field_operands+0x15b/0x17d
  [<c01e9f8f>] acpi_ds_exec_end_op+0x22c/0x409
  [<c0201a29>] acpi_ps_append_arg+0x1d/0x85
  [<c02013e5>] acpi_ps_parse_loop+0x6bf/0xa51
  [<c0209a87>] acpi_ut_status_exit+0x49/0x55
  [<c01ea923>] acpi_ds_call_control_method+0x231/0x261
  [<c01ecd52>] acpi_ds_get_current_walk_state+0x3f/0x4a
  [<c0201836>] acpi_ps_parse_aml+0xbf/0x241
  [<c020253e>] acpi_psx_execute+0x226/0x2b0
  [<c01fd9d4>] acpi_ns_execute_control_method+0xe5/0x104
  [<c01fd8ad>] acpi_ns_evaluate_by_handle+0xdf/0x121
  [<c01fd635>] acpi_ns_evaluate_relative+0x141/0x192
  [<c0209a87>] acpi_ut_status_exit+0x49/0x55
  [<c01fdce5>] acpi_ns_handle_to_pathname+0xbf/0xca
  [<c0209cc2>] acpi_ut_evaluate_object+0x42/0x195
  [<c0205f7c>] acpi_rs_get_crs_method_data+0x42/0x8b
  [<c020416f>] acpi_get_current_resources+0x78/0x93
  [<c0211853>] acpi_pci_evaluate_crs+0x4d/0xb2
  [<c0211a31>] acpi_pci_root_add+0x179/0x2b1
  [<c0211a78>] acpi_pci_root_add+0x1c0/0x2b1
  [<c02191f2>] acpi_bus_driver_init+0x85/0x12c
  [<c0219608>] acpi_bus_find_driver+0x8e/0xdf
  [<c0219b64>] acpi_bus_add+0x193/0x1db
  [<c0219cf5>] acpi_bus_scan+0x149/0x1b3
  [<c03cdba3>] acpi_scan_init+0x87/0xc4
  [<c03c0782>] do_initcalls+0x22/0xa0
  [<c012cb3f>] init_workqueues+0xf/0x30
  [<c01050cd>] init+0x2d/0x140
  [<c01050a0>] init+0x0/0x140
  [<c0107269>] kernel_thread_helper+0x5/0xc

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e5 10 89 c3 75
  <0>Kernel panic: Attempted to kill init!



--------------040401020107010106050603
Content-Type: application/x-gunzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
H/Qo/vGp/wf8tFxHfk0AAA==
--------------040401020107010106050603--

