Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTKLAIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTKLAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:08:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5314 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263832AbTKLAGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:06:37 -0500
Subject: 2.6.0-test9-mjb2 oops
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2003 00:06:31 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1AJiWm-0005oa-5D@www.linux.org.uk>
From: Bryce as root <root@www.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from -mjb2 which basically tweaks some bits around numa et al
however,.. it mihgt be of intrest to somebody  (Waves to mbligh)

HW: HP 8way box

Thoughts anyone?
flames and dribble to /dev/no_one_cares

Phil
=--=

<NON working kernel bootlog>


Linux version 2.6.0-test9-mjb2 (root@ca-test16-RHEL3) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #4 SMP Tue Nov 11 14:16:12 PST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
 BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000080ffff000 (usable)
Warning only 896MB will be used.
Use a PAE enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f4fd0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 HP                                        ) @ 0x000f4f70
ACPI: RSDT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0000
ACPI: FADT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0040
ACPI: MADT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0100
ACPI: SRAT (v001 HP     P47      0x00000003  0x00000000) @ 0xefff01e0
ACPI: SPCR (v001 HP     SPCRRBSU 0x00000001  0x00000000) @ 0xefff0450
ACPI: DSDT (v001 HP     P47      0x00000001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
Processor #4 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x08] enabled)
Processor #8 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x0a] enabled)
Processor #10 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x0c] enabled)
Processor #12 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x0e] enabled)
Processor #14 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x09] disabled)
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0b] disabled)
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0d] disabled)
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] polarity[0x0] trigger[0x0] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Enabling APIC mode:  Summit.  Using 3 I/O APICs
Processors: 8
Building zonelist for node : 0
Kernel command line: ro root=/dev/cciss/c0d0p5 console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2000.595 MHz processor.
Console: colour VGA+ 80x25
Memory: 901740k/917504k available (2133k kernel code, 14996k reserved, 911k data, 156k init, 0k highmem)
Calibrating delay loop... 3923.96 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2184k freed
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 1462.76 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Calibrating delay loop... 3989.50 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 2/4 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Calibrating delay loop... 3989.50 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 3/6 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Calibrating delay loop... 3989.50 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 4/8 eip 2000
Initializing CPU#4
------------[ cut here ]------------
kernel BUG at /usr/src/linux-2.6.0-test9/include/asm-i386/mach-summit/mach_apic.h:63!
invalid operand: 0000 [#1]
CPU:    4
EIP:    0060:[<c040647a>]    Not tainted
EFLAGS: 00010002
EIP is at setup_local_APIC+0x190/0x19d
eax: 00000000   ebx: 00000004   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000014   ebp: f7f93f98   esp: f7f93f80
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f92000 task=f7dce080)
Stack: c0377000 00000018 00000004 00000004 00000000 00000000 f7f93fb4 c04048fa 
       f7dce3c0 c03f0000 0801080c 00000000 0801080c f7f93fc0 c0404990 00000000 
       f7f93fbc c1937f50 c0120ccd 0000000a 00000400 c032bba8 c1937f60 00000000 
Call Trace:
 [<c04048fa>] smp_callin+0x73/0xf4
 [<c0404990>] start_secondary+0x15/0x95
 [<c0120ccd>] printk+0x162/0x195
 [<c04011cd>] print_cpu_info+0x8d/0xda

Code: 0f 0b 3f 00 60 a0 32 c0 e9 df fe ff ff 55 89 e5 e8 21 d2 de 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #8 not responding - cannot use it.
Booting processor 4/10 eip 2000
Initializing CPU#4
------------[ cut here ]------------
kernel BUG at /usr/src/linux-2.6.0-test9/include/asm-i386/mach-summit/mach_apic.h:63!
invalid operand: 0000 [#2]
CPU:    4
EIP:    0060:[<c040647a>]    Not tainted
EFLAGS: 00010002
EIP is at setup_local_APIC+0x190/0x19d
eax: 00000000   ebx: 00000004   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000014   ebp: f7f8ff98   esp: f7f8ff80
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f8e000 task=f7f91980)
Stack: c0377000 00000018 00000004 00000004 00000000 00000000 f7f8ffb4 c04048fa 
       f7f91cc0 c03f0000 0a01080c 00000000 0a01080c f7f8ffc0 c0404990 00000000 
       f7f8ffbc c1937f54 c0120a33 0000213c 0000213c ffffffff ffffffff 00000000 
Call Trace:
 [<c04048fa>] smp_callin+0x73/0xf4
 [<c0404990>] start_secondary+0x15/0x95
 [<c0120a33>] call_console_drivers+0x77/0x13c

Code: 0f 0b 3f 00 60 a0 32 c0 e9 df fe ff ff 55 89 e5 e8 21 d2 de 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #10 not responding - cannot use it.
Booting processor 4/12 eip 2000
Initializing CPU#4
------------[ cut here ]------------
kernel BUG at /usr/src/linux-2.6.0-test9/include/asm-i386/mach-summit/mach_apic.h:63!
invalid operand: 0000 [#3]
CPU:    4
EIP:    0060:[<c040647a>]    Not tainted
EFLAGS: 00010002
EIP is at setup_local_APIC+0x190/0x19d
eax: 00000000   ebx: 00000004   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000014   ebp: f7f8df98   esp: f7f8df80
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f8c000 task=f7f91340)
Stack: c0377000 00000018 00000004 00000004 00000000 00000000 f7f8dfb4 c04048fa 
       f7f91680 c03f0000 0c01080c 00000000 0c01080c f7f8dfc0 c0404990 00000000 
       f7f8dfbc c1937f54 c0120a33 000025ce 000025ce ffffffff ffffffff 00000000 
Call Trace:
 [<c04048fa>] smp_callin+0x73/0xf4
 [<c0404990>] start_secondary+0x15/0x95
 [<c0120a33>] call_console_drivers+0x77/0x13c

Code: 0f 0b 3f 00 60 a0 32 c0 e9 df fe ff ff 55 89 e5 e8 21 d2 de 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #12 not responding - cannot use it.
Booting processor 4/14 eip 2000
Initializing CPU#4
------------[ cut here ]------------
kernel BUG at /usr/src/linux-2.6.0-test9/include/asm-i386/mach-summit/mach_apic.h:63!
invalid operand: 0000 [#4]
CPU:    4
EIP:    0060:[<c040647a>]    Not tainted
EFLAGS: 00010002
EIP is at setup_local_APIC+0x190/0x19d
eax: 00000000   ebx: 00000004   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000014   ebp: f7f8bf98   esp: f7f8bf80
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f8a000 task=f7f90d00)
Stack: c0377000 00000018 00000004 00000004 00000000 00000000 f7f8bfb4 c04048fa 
       f7f91040 c03f0000 0e01080c 00000000 0e01080c f7f8bfc0 c0404990 00000000 
       f7f8bfbc c1937f54 c0120a33 00002a60 00002a60 ffffffff ffffffff 00000000 
Call Trace:
 [<c04048fa>] smp_callin+0x73/0xf4
 [<c0404990>] start_secondary+0x15/0x95
 [<c0120a33>] call_console_drivers+0x77/0x13c

Code: 0f 0b 3f 00 60 a0 32 c0 e9 df fe ff ff 55 89 e5 e8 21 d2 de 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #14 not responding - cannot use it.
Total of 4 processors activated (15892.48 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-3, 8-5, 8-7, 8-11, 9-0, 10-0, 10-1, 10-2, 10-8, 10-9, 10-10 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 52.
number of IO-APIC #8 registers: 16.
number of IO-APIC #9 registers: 16.
number of IO-APIC #10 registers: 16.
testing the IO APIC.......................
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    0    39
 02 0FF 0F  0    0    0   0   0    1    0    31
 03 000 00  1    0    0   0   0    0    0    00
 04 0FF 0F  0    0    0   0   0    1    0    41
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  0    0    0   0   0    1    0    49
 07 000 00  1    0    0   0   0    0    0    00
 08 0FF 0F  0    0    0   0   0    1    0    51
 09 0FF 0F  1    1    0   1   0    1    0    59
 0a 0FF 0F  1    1    0   1   0    1    0    61
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    0    69
 0d 0FF 0F  1    1    0   1   0    1    0    71
 0e 0FF 0F  0    0    0   0   0    1    0    79
 0f 0FF 0F  0    0    0   0   0    1    0    81
IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  1    1    0   1   0    1    0    89
 02 0FF 0F  1    1    0   1   0    1    0    91
 03 0FF 0F  1    1    0   1   0    1    0    99
 04 0FF 0F  1    1    0   1   0    1    0    A1
 05 0FF 0F  1    1    0   1   0    1    0    A9
 06 0FF 0F  1    1    0   1   0    1    0    B1
 07 0FF 0F  1    1    0   1   0    1    0    B9
 08 0FF 0F  1    1    0   1   0    1    0    C1
 09 0FF 0F  1    1    0   1   0    1    0    C9
 0a 0FF 0F  1    1    0   1   0    1    0    61
 0b 0FF 0F  1    1    0   1   0    1    0    D1
 0c 0FF 0F  1    1    0   1   0    1    0    D9
 0d 0FF 0F  1    1    0   1   0    1    0    E1
 0e 0FF 0F  1    1    0   1   0    1    0    E9
 0f 0FF 0F  1    1    0   1   0    1    0    32
IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0A000000
.......     : arbitration: 0A
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 0FF 0F  1    1    0   1   0    1    0    3A
 04 0FF 0F  1    1    0   1   0    1    0    42
 05 0FF 0F  1    1    0   1   0    1    0    4A
 06 0FF 0F  1    1    0   1   0    1    0    52
 07 0FF 0F  1    1    0   1   0    1    0    5A
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 0FF 0F  1    1    0   1   0    1    0    62
 0c 0FF 0F  1    1    0   1   0    1    0    6A
 0d 0FF 0F  1    1    0   1   0    1    0    72
 0e 0FF 0F  1    1    0   1   0    1    0    7A
 0f 0FF 0F  1    1    0   1   0    1    0    82
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 0:10-> 1:10
IRQ27 -> 1:11
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
IRQ31 -> 1:15
IRQ35 -> 2:3
IRQ36 -> 2:4
IRQ37 -> 2:5
IRQ38 -> 2:6
IRQ39 -> 2:7
IRQ43 -> 2:11
IRQ44 -> 2:12
IRQ45 -> 2:13
IRQ46 -> 2:14
IRQ47 -> 2:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1998.0852 MHz.
..... host bus clock speed is 99.0942 MHz.
checking TSC synchronization across 4 CPUs: 
BIOS BUG: CPU#3 improperly initialized, has 2 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
CPUS done 8
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1186, last bus=14
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
PCI: Discovered peer bus 01
PCI: Discovered peer bus 02
PCI: Discovered peer bus 03
PCI: Discovered peer bus 07
PCI: Discovered peer bus 0b
PCI->APIC IRQ transform: (B0,I3,P0) -> 45
PCI->APIC IRQ transform: (B0,I12,P0) -> 47
PCI->APIC IRQ transform: (B0,I12,P1) -> 46
PCI->APIC IRQ transform: (B0,I15,P0) -> 26
PCI->APIC IRQ transform: (B0,I16,P0) -> 39
PCI->APIC IRQ transform: (B0,I16,P1) -> 38
PCI->APIC IRQ transform: (B0,I16,P2) -> 37
PCI->APIC IRQ transform: (B1,I4,P0) -> 44
PCI->APIC IRQ transform: (B1,I5,P0) -> 43
PCI->APIC IRQ transform: (B2,I14,P0) -> 19
PCI->APIC IRQ transform: (B3,I1,P0) -> 23
PCI->APIC IRQ transform: (B3,I2,P0) -> 21
PCI->APIC IRQ transform: (B3,I30,P0) -> 18
PCI->APIC IRQ transform: (B7,I2,P0) -> 29
PCI->APIC IRQ transform: (B7,I2,P1) -> 28
PCI->APIC IRQ transform: (B7,I30,P0) -> 17
PCI->APIC IRQ transform: (B11,I1,P0) -> 27
PCI->APIC IRQ transform: (B11,I2,P0) -> 25
PCI->APIC IRQ transform: (B11,I30,P0) -> 17
PCI: Device 00:78 not found by BIOS
PCI: Device 00:7b not found by BIOS
PCI: Device 00:88 not found by BIOS
PCI: Device 00:89 not found by BIOS
PCI: Device 00:90 not found by BIOS
PCI: Device 00:91 not found by BIOS
PCI: Device 00:98 not found by BIOS
PCI: Device 00:99 not found by BIOS
PCI: Device 00:a0 not found by BIOS
PCI: Device 00:a1 not found by BIOS
PCI: Device 00:a8 not found by BIOS
PCI: Device 00:a9 not found by BIOS
PCI: Device 00:b0 not found by BIOS
PCI: Device 00:b1 not found by BIOS
PCI: Device 00:b8 not found by BIOS
PCI: Device 00:c0 not found by BIOS
PCI: Device 00:c2 not found by BIOS
PCI: Device 00:c4 not found by BIOS
PCI: Device 00:c6 not found by BIOS
PCI: Device 00:c8 not found by BIOS
PCI: Device 00:ca not found by BIOS
Machine check exception polling timer started.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
reset set in interrupt, calling c0241ec8
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x2820-0x2827, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x2828-0x282f, BIOS settings: hdc:pio, hdd:pio
hda: Compaq DVD-ROM DV28EB 01, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
usb.c: registered new driver usblp
usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb.c: registered new driver hid
hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Cannot open root device "cciss/c0d0p5" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
 Linux version 2.6.0-test9-mjb2 (root@ca-test16-RHEL3) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #4 SMP Tue Nov 11 14:16:12 PST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
 BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000080ffff000 (usable)
Warning only 896MB will be used.
Use a PAE enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f4fd0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 HP                                        ) @ 0x000f4f70
ACPI: RSDT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0000
ACPI: FADT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0040
ACPI: MADT (v001 HP     P47      0x00000001  0x00000000) @ 0xefff0100
ACPI: SRAT (v001 HP     P47      0x00000003  0x00000000) @ 0xefff01e0
ACPI: SPCR (v001 HP     SPCRRBSU 0x00000001  0x00000000) @ 0xefff0450
ACPI: DSDT (v001 HP     P47      0x00000001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
Processor #4 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x08] enabled)
Processor #8 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x0a] enabled)
Processor #10 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x0c] enabled)
Processor #12 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x0e] enabled)
Processor #14 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x09] disabled)
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0b] disabled)
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0d] disabled)
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] polarity[0x0] trigger[0x0] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Enabling APIC mode:  Summit.  Using 3 I/O APICs
Processors: 8
Building zonelist for node : 0
Kernel command line: ro root=/dev/cciss/c0d0p5 console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2000.139 MHz processor.
Console: colour VGA+ 80x25
Memory: 901740k/917504k available (2133k kernel code, 14996k reserved, 911k data, 156k init, 0k highmem)
Calibrating delay loop... 3923.96 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2184k freed
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 1462.76 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Calibrating delay loop... 3981.31 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 2/4 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Calibrating delay loop... 3989.50 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 3/6 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Calibrating delay loop... 3989.50 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 4/8 eip 2000
Initializing CPU#4
------------[ cut here ]------------
kernel BUG at /usr/src/linux-2.6.0-test9/include/asm-i386/mach-summit/mach_apic.h:63!
invalid operand: 0000 [#1]
CPU:    4
EIP:    0060:[<c040647a>]    Not tainted
EFLAGS: 00010002
EIP is at setup_local_APIC+0x190/0x19d
eax: 00000000   ebx: 00000004   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000014   ebp: f7f93f98   esp: f7f93f80
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f92000 task=f7dce080)
Stack: c0377000 00000018 00000004 00000004 00000000 00000000 f7f93fb4 c04048fa 
       f7dce3c0 c03f0000 0801080c 00000000 0801080c f7f93fc0 c0404990 00000000 
       f7f93fbc c1937f50 c0120ccd 0000000a 00000400 c032bba8 c1937f60 00000000 
Call Trace:
 [<c04048fa>] smp_callin+0x73/0xf4
 [<c0404990>] start_secondary+0x15/0x95
 [<c0120ccd>] printk+0x162/0x195
 [<c04011cd>] print_cpu_info+0x8d/0xda

Code: 0f 0b 3f 00 60 a0 32 c0 e9 df fe ff ff 55 89 e5 e8 21 d2 de 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #8 not responding - cannot use it.
Booting processor 4/10 eip 2000














<A working kernel bootlog>



Linux version 2.4.21-3.ELhugemem (bhcompile@porky.devel.redhat.com) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #1 SMP Fri Sep 19 13:57:07 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
 BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000080ffff000 (usable)
29087MB HIGHMEM available.
3936MB LOWMEM available.
found SMP MP-table at 000f4fd0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
On node 0 totalpages: 8454143
zone(0): 4096 pages.
zone(1): 1003520 pages.
zone(2): 7446527 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address 020f4f70
RSD PTR  v0 [HP    ]
__va_range(0xefff0000, 0x68): idx=33 mapped at fffdd000
ACPI table found: RSDT v1 [HP     P47      0.1]
__va_range(0xefff0040, 0x24): idx=33 mapped at fffdd000
__va_range(0xefff0040, 0x74): idx=33 mapped at fffdd000
ACPI table found: FACP v1 [HP     P47      0.1]
__va_range(0xefff0100, 0x24): idx=33 mapped at fffdd000
__va_range(0xefff0100, 0xe0): idx=33 mapped at fffdd000
ACPI table found: APIC v1 [HP     P47      0.1]
__va_range(0xefff0100, 0xe0): idx=33 mapped at fffdd000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
CPU 1 (0x0200) enabledProcessor #2 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0003] id[0x4] enabled[1])
CPU 2 (0x0400) enabledProcessor #4 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0004] id[0x6] enabled[1])
CPU 3 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0005] id[0x8] enabled[1])
CPU 4 (0x0800) enabledProcessor #8 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0006] id[0xa] enabled[1])
CPU 5 (0x0a00) enabledProcessor #10 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0007] id[0xc] enabled[1])
CPU 6 (0x0c00) enabledProcessor #12 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0008] id[0xe] enabled[1])
CPU 7 (0x0e00) enabledProcessor #14 Pentium 4(tm) XEON(tm) APIC version 20

LAPIC (acpi_id[0x0009] id[0x1] enabled[0])
CPU 8 (0x0100) disabled
LAPIC (acpi_id[0x000a] id[0x3] enabled[0])
CPU 9 (0x0300) disabled
LAPIC (acpi_id[0x000b] id[0x5] enabled[0])
CPU 10 (0x0500) disabled
LAPIC (acpi_id[0x000c] id[0x7] enabled[0])
CPU 11 (0x0700) disabled
LAPIC (acpi_id[0x000d] id[0x9] enabled[0])
CPU 12 (0x0900) disabled
LAPIC (acpi_id[0x000e] id[0xb] enabled[0])
CPU 13 (0x0b00) disabled
LAPIC (acpi_id[0x000f] id[0xd] enabled[0])
CPU 14 (0x0d00) disabled
LAPIC (acpi_id[0x0010] id[0xf] enabled[0])
CPU 15 (0x0f00) disabled
IOAPIC (id[0x8] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x9] address[0xfec01000] global_irq_base[0x10])
IOAPIC (id[0xa] address[0xfec02000] global_irq_base[0x20])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
LAPIC_NMI (acpi_id[0x00ff] polarity[0x0] trigger[0x0] lint[0x1])
16 CPUs total
Local APIC address fee00000
__va_range(0xefff01e0, 0x24): idx=33 mapped at fffdd000
__va_range(0xefff01e0, 0x270): idx=33 mapped at fffdd000
ACPI table found: SRAT v1 [HP     P47      0.3]
__va_range(0xefff0450, 0x24): idx=33 mapped at fffdd000
__va_range(0xefff0450, 0x50): idx=33 mapped at fffdd000
ACPI table found: SPCR v1 [HP     SPCRRBSU 0.1]
__va_range(0xefff8000, 0x24): idx=33 mapped at fffdd000
__va_range(0xefff8000, 0x4fae): idx=33 mapped at fffdd000
ACPI table found: SSDT v1 [HP     P47      0.2]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Processors: 8
xAPIC support is present
Enabling APIC mode: Flat.	Using 3 I/O APICs
Kernel command line: ro root=/dev/cciss/c0d0p5 console=ttyS0,115200 console=tty0
mapped 4G/4G trampoline to fffd7000.
Initializing CPU#0
Detected 1999.332 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 33047436k/33816572k available (1676k kernel code, 502316k reserved, 1306k data, 224k init, 29622268k highmem)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Page-cache hash table entries: 1048576 (order: 10, 4194304 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 1462.74 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 2/4 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#2.
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 3/6 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#3.
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 4/8 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#4.
CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 5/10 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#5.
CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 6/12 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#6.
CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 7/14 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#7.
CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Total of 8 processors activated (31968.46 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
Setting 9 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 9 ... ok.
Setting 10 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 10 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.3996 MHz.
..... host bus clock speed is 99.9697 MHz.
cpu: 0, clocks: 999697, slice: 111077
CPU0<T0:999696,T1:888608,D:11,S:111077,C:999697>
cpu: 1, clocks: 999697, slice: 111077
cpu: 2, clocks: 999697, slice: 111077
cpu: 3, clocks: 999697, slice: 111077
cpu: 4, clocks: 999697, slice: 111077
cpu: 5, clocks: 999697, slice: 111077
cpu: 6, clocks: 999697, slice: 111077
cpu: 7, clocks: 999697, slice: 111077
CPU2<T0:999696,T1:666464,D:1,S:111077,C:999697>
CPU3<T0:999696,T1:555376,D:12,S:111077,C:999697>
CPU4<T0:999696,T1:444304,D:7,S:111077,C:999697>
CPU1<T0:999696,T1:777536,D:6,S:111077,C:999697>
CPU5<T0:999696,T1:333232,D:2,S:111077,C:999697>
CPU7<T0:999696,T1:111072,D:8,S:111077,C:999697>
CPU6<T0:999696,T1:222144,D:13,S:111077,C:999697>
zapping low mappings.
Process timing init...done.
Starting migration thread for cpu 0
Starting migration thread for cpu 1
Starting migration thread for cpu 2
Starting migration thread for cpu 3
Starting migration thread for cpu 4
Starting migration thread for cpu 5
Starting migration thread for cpu 6
Starting migration thread for cpu 7
PCI: PCI BIOS revision 2.10 entry at 0xf1186, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Discovered primary peer bus 03 [IRQ]
PCI: Discovered primary peer bus 07 [IRQ]
PCI: Discovered primary peer bus 0b [IRQ]
PCI->APIC IRQ transform: (B0,I3,P0) -> 45
PCI->APIC IRQ transform: (B0,I12,P0) -> 47
PCI->APIC IRQ transform: (B0,I12,P1) -> 46
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B0,I16,P0) -> 39
PCI->APIC IRQ transform: (B0,I16,P1) -> 38
PCI->APIC IRQ transform: (B0,I16,P2) -> 37
PCI->APIC IRQ transform: (B1,I4,P0) -> 44
PCI->APIC IRQ transform: (B1,I5,P0) -> 43
PCI->APIC IRQ transform: (B2,I14,P0) -> 19
PCI->APIC IRQ transform: (B3,I1,P0) -> 23
PCI->APIC IRQ transform: (B3,I2,P0) -> 21
PCI->APIC IRQ transform: (B3,I30,P0) -> 18
PCI->APIC IRQ transform: (B7,I2,P0) -> 29
PCI->APIC IRQ transform: (B7,I2,P1) -> 28
PCI->APIC IRQ transform: (B7,I30,P0) -> 17
PCI->APIC IRQ transform: (B11,I1,P0) -> 27
PCI->APIC IRQ transform: (B11,I2,P0) -> 25
PCI->APIC IRQ transform: (B11,I30,P0) -> 17
PCI: Device 00:78 not found by BIOS
PCI: Device 00:7b not found by BIOS
PCI: Device 00:88 not found by BIOS
PCI: Device 00:89 not found by BIOS
PCI: Device 00:90 not found by BIOS
PCI: Device 00:91 not found by BIOS
PCI: Device 00:98 not found by BIOS
PCI: Device 00:99 not found by BIOS
PCI: Device 00:a0 not found by BIOS
PCI: Device 00:a1 not found by BIOS
PCI: Device 00:a8 not found by BIOS
PCI: Device 00:a9 not found by BIOS
PCI: Device 00:b0 not found by BIOS
PCI: Device 00:b1 not found by BIOS
PCI: Device 00:b8 not found by BIOS
PCI: Device 00:c0 not found by BIOS
PCI: Device 00:c2 not found by BIOS
PCI: Device 00:c4 not found by BIOS
PCI: Device 00:c6 not found by BIOS
PCI: Device 00:c8 not found by BIOS
PCI: Device 00:ca not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Total HugeTLB memory allocated, 0
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 2113535
aio_setup: sizeof(struct page) = 60
Hugetlbfs mounted.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 256 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x2820-0x2827, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x2828-0x282f, BIOS settings: hdc:pio, hdd:pio
hda: Compaq DVD-ROM DV28EB 01, ATAPI CD/DVD-ROM drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 524288 buckets, 4096Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 391k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
qla2x00_set_info starts at address = f8834060
qla2x00: Found  VID=1077 DID=2312 SSVID=e11 SSDID=101
scsi(0): Found a QLA2312  @ bus 7, device 0x2, irq 29, iobase 0xf887c000
scsi(0): Allocated 4096 SRB(s).
scsi(0): Configure NVRAM parameters...
scsi(0): 64 Bit PCI Addressing Enabled.
scsi(0): Scatter/Gather entries= 3584
qla2x00_nvram_config ZIO enabled:intr_timer_delay=3
scsi(0): Verifying loaded RISC code...
scsi(0): Verifying chip...
scsi(0): LIP reset occurred.
scsi(0): Waiting for LIP to complete...
scsi(0): LOOP UP detected.
scsi(0): Port database changed.
scsi(0): Topology - (F_Port), Host Loop address 0xffff
scsi(0) qla2x00_isr MBA_PORT_UPDATE ignored
qla2x00: Found  VID=1077 DID=2312 SSVID=e11 SSDID=101
scsi(1): Found a QLA2312  @ bus 7, device 0x2, irq 28, iobase 0xf887e000
scsi(1): Allocated 4096 SRB(s).
scsi(1): Configure NVRAM parameters...
scsi(1): 64 Bit PCI Addressing Enabled.
scsi(1): Scatter/Gather entries= 3584
qla2x00_nvram_config ZIO enabled:intr_timer_delay=3
scsi(1): Verifying loaded RISC code...
scsi(1): Verifying chip...
scsi(1): Waiting for LIP to complete...
scsi(0) qla2x00_isr MBA_PORT_UPDATE ignored
scsi(1): Cable is unplugged...
scsi0 : QLogic QLA2312 PCI to Fibre Channel Host Adapter: bus 7 device 2 irq 29
        Firmware version:  3.02.13, Driver version 6.06.00b11

scsi1 : QLogic QLA2312 PCI to Fibre Channel Host Adapter: bus 7 device 2 irq 28
        Firmware version:  3.02.13, Driver version 6.06.00b11

initializing plug timer for queue 2772f218
Starting timer : 1 1
blk: queue 2772f218, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
scsi: unknown type 12
  Vendor: COMPAQ    Model: MSA1000           Rev: 4.14
  Type:   Unknown                            ANSI SCSI revision: 04
initializing plug timer for queue 2772f018
Starting timer : 1 1
blk: queue 2772f018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.14
  Type:   Direct-Access                      ANSI SCSI revision: 04
initializing plug timer for queue eff19e18
Starting timer : 1 1
blk: queue eff19e18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.14
  Type:   Direct-Access                      ANSI SCSI revision: 04
initializing plug timer for queue eff19c18
Starting timer : 1 1
blk: queue eff19c18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
scsi(0:0:0:0): Enabled tagged queuing, queue depth 64.
scsi(0:0:0:1): Enabled tagged queuing, queue depth 64.
scsi(0:0:0:2): Enabled tagged queuing, queue depth 64.
initializing plug timer for queue eff19c18
Starting timer : 1 1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 1
Attached scsi disk sdb at scsi0, channel 0, id 0, lun 2
resize_dma_pool: unknown device type 12
SCSI device sda: 511999200 512-byte hdwr sectors (262144 MB)
Partition check:
 sda: sda1
SCSI device sdb: 634985190 512-byte hdwr sectors (325112 MB)
 sdb: sdb1 sdb2 sdb3
HP CISS Driver (v 2.4.47.RH1)
      blocks= 71122560 block_size= 512
      heads= 255, sectors= 32, cylinders= 8716 RAID 1(0+1)

      blocks= 71122560 block_size= 512
      heads= 255, sectors= 32, cylinders= 8716 RAID 0

blk: queue 024f39a0, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
 cciss/c0d0: p1 p2 p3 p4 < p5 p6 >
 cciss/c0d1: unknown partition table
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 224k freed

Red Hat Enterprise Linux AS release 3 (Taroon)
Kernel 2.4.21-3.ELhugemem on
