Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318197AbSGWTxh>; Tue, 23 Jul 2002 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318201AbSGWTxh>; Tue, 23 Jul 2002 15:53:37 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:51207 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318197AbSGWTxf>; Tue, 23 Jul 2002 15:53:35 -0400
Date: Tue, 23 Jul 2002 21:56:12 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac3
Message-ID: <20020723195612.GA609@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200207231529.g6NFTSm08737@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207231529.g6NFTSm08737@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@redhat.com>
Date: Tue, Jul 23, 2002 at 11:29:28AM -0400
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19rc3-ac3
> o	Hopefully fix the smp boot/apic problem		(James Cleverdon)

As a datapoint: my VP6 boots with it:

-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003fff0000 (usable)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=power-off mem=1048512K
ide_setup: hdc=scsi
Initializing CPU#0
Detected 703.183 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1402.47 BogoMIPS
Memory: 1030952k/1048512k available (1408k kernel code, 17172k reserved, 449k data, 288k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 16384 (order: 5, 131072 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=128869 max_file_pages=0 max_inodes=0 max_dentries=128869
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 730.87 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1405.74 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2808.21 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 002 02  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 703.1629 MHz.
..... host bus clock speed is 100.4516 MHz.
cpu: 0, clocks: 1004516, slice: 334838
CPU0<T0:1004512,T1:669664,D:10,S:334838,C:1004516>
cpu: 1, clocks: 1004516, slice: 334838
CPU1<T0:1004512,T1:334832,D:4,S:334838,C:1004516>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs

Good luck,
Jurriaan
-- 
Life is like a puzzle
Best to choose the edges first
	Pat Benatar - In these times
GNU/Linux 2.4.19-rc3 SMP/ReiserFS 2x1402 bogomips load av: 0.06 0.10 0.07
