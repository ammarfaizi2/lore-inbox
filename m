Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbTCJQ6d>; Mon, 10 Mar 2003 11:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCJQ6c>; Mon, 10 Mar 2003 11:58:32 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:9874 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261208AbTCJQ63>; Mon, 10 Mar 2003 11:58:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 10 Mar 2003 09:08:13 -0800
Message-Id: <200303101708.JAA04892@adam.yggdrasil.com>
To: wli@holomorphy.com
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Cc: gone@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, William Lee Irwin III wrote:
>It might help if we could get bootlogs or backtraces from you.

	This is 2.5.64bk4 with CONFIG_X86_PC + CONFIG_HIGHMEM4G.

	I do not use CONFIG_HIGHMEM64G because, when last I checked,
that generated kernel crash when used with a ramdisk that was ~1MB
compressed and ~3MB uncompressed, although I have not checked that in
at least a month.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


Linux version 2.5.64-bk4 (root@baldur) (gcc version 3.2) #7 SMP Mon Mar 10 08:55:37 PST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002dff0000 (usable)
 BIOS-e820: 000000002dff0000 - 000000002dff8000 (ACPI data)
 BIOS-e820: 000000002dff8000 - 000000002e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
NUMA - single node, flat memory mode
Reserving total of 0 pages for numa KVA remap
0MB HIGHMEM available.
735MB LOWMEM available.
min_low_pfn = 822, max_low_pfn = 188400, highstart_pfn = 188400
Low memory ends at vaddr edff0000
node 0 will remap to vaddr edff0000 - edff0000
High memory starts at vaddr edff0000
On node 0 totalpages: 188400
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184304 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fa3e0
ACPI: RSDT (v001 AMIINT VIA_P6   00000.00016) @ 0x2dff0000
ACPI: FADT (v001 AMIINT VIA_P6   00000.00017) @ 0x2dff0030
ACPI: DSDT (v001    VIA APOLLO-P 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux ro root=302 ramdisk=5000 root=/dev/ram0 ro console=ttyS0,38400 console=tty0 vga=6
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2399.878 MHz processor.
Console: colour VGA+ 80x25
Linux version 2.5.64-bk4 (root@baldur) (gcc version 3.2) #7 SMP Mon Mar 10 08:55:37 PST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002dff0000 (usable)
 BIOS-e820: 000000002dff0000 - 000000002dff8000 (ACPI data)
 BIOS-e820: 000000002dff8000 - 000000002e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
NUMA - single node, flat memory mode
Reserving total of 0 pages for numa KVA remap
0MB HIGHMEM available.
735MB LOWMEM available.
min_low_pfn = 822, max_low_pfn = 188400, highstart_pfn = 188400
Low memory ends at vaddr edff0000
node 0 will remap to vaddr edff0000 - edff0000
High memory starts at vaddr edff0000
On node 0 totalpages: 188400
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184304 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fa3e0
ACPI: RSDT (v001 AMIINT VIA_P6   00000.00016) @ 0x2dff0000
ACPI: FADT (v001 AMIINT VIA_P6   00000.00017) @ 0x2dff0030
ACPI: DSDT (v001    VIA APOLLO-P 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux ro root=302 ramdisk=5000 root=/dev/ram0 ro console=ttyS0,38400 console=tty0 vga=6
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2399.878 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4718.59 BogoMIPS
AJR mem_init() called.
AJR discontig.c: highmem_start_page set to 00000000.
Initializing highpages for node 0
Memory: 741756k/753600k available (1189k kernel code, 11108k reserved, 714k data, 112k init, 0k highmem)
AJR mem_init done.
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.99 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Mapping cpu 0 to node 0
Starting migration thread for cpu 0
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 16Kb (64 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
AJR __change_page_attr: page c1000000 >= highmem_start_page 00000000.
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:99!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011ebea>]    Not tainted
EFLAGS: 00010246
EIP is at __change_page_attr+0x25e/0x270
eax: 00000046   ebx: c1000000   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 00000000   ebp: edf8fe58   esp: edf8fe34
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=edf8e000 task=edf8c030)
Stack: c0238460 c1000000 00000000 c01a32ac c0264924 c011a094 c1000000 00000000 
       00000000 edf8fe7c c011ec3c c1000000 00000163 edf8fe6c 00000000 ee800000 
       edfe18e8 edf8feb0 edf8fe98 c011e738 c1000000 00000002 00000163 00000000 
Call Trace:
 [<c01a32ac>] __down_write+0x80/0x124
 [<c011a094>] on_each_cpu+0x28/0x48
 [<c011ec3c>] change_page_attr+0x40/0xb8
 [<c011e738>] iounmap+0x94/0xb0
 [<c01cad60>] acpi_tb_find_rsdp+0x11a/0x1ce
 [<c01cb9ff>] acpi_ut_trace+0x29/0x2c
 [<c01cab0f>] acpi_find_root_pointer+0x3d/0x9e
 [<c01cbae5>] acpi_ut_status_exit+0x33/0x5a
 [<c01a9210>] acpi_os_get_root_pointer+0xe/0x2a
 [<c01c9331>] acpi_load_tables+0x35/0x182
 [<c0105094>] init+0x5c/0x188
 [<c0105038>] init+0x0/0x188
 [<c01091fd>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 63 00 ed 80 23 c0 83 c4 0c e9 a9 fd ff ff 89 f6 55 89 
 <0>Kernel panic: Attempted to kill init!
