Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319400AbSH2V5d>; Thu, 29 Aug 2002 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319423AbSH2V4d>; Thu, 29 Aug 2002 17:56:33 -0400
Received: from gate.in-addr.de ([212.8.193.158]:46340 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319400AbSH2Vz7>;
	Thu, 29 Aug 2002 17:55:59 -0400
Date: Fri, 30 Aug 2002 00:00:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-smp@vger.kernel.org
Subject: "WARNING: unexpected IO-APIC"
Message-ID: <20020829220044.GZ2449@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel asks me to send mail, I sure do ;-)

Everything seems to work fine though.

Linux version 2.4.19-lmb4-4GB (root@pandora) (gcc version 2.95.3 20010315 (SuSE)) #79 Thu Aug 29 23:29:10 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5690
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
Advanced speculative caching feature present
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
ABIT KX7-333[R] machine detected. Disabling APM.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux ro root=900 apic nmi_watchdog=1
Initializing CPU#0
Detected 1534.019 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 1031852k/1048512k available (1450k kernel code, 16276k reserved, 510k data, 132k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
Advanced speculative caching feature present
Disabling advanced speculative caching
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbf7 c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbf7 c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-12, 2-18, 2-20, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178002
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0002
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 001 01  1    1    0   1   0    1    1    79
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 001 01  1    1    0   1   0    1    1    99
 11 001 01  1    1    0   1   0    1    1    A1
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    B1
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ11 -> 0:11
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.9674 MHz.
..... host bus clock speed is 266.7769 MHz.
cpu: 0, clocks: 2667769, slice: 1333884
CPU0<T0:2667760,T1:1333872,D:4,S:1333884,C:2667769>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3099] at 00:00.0
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P0) -> 17
PCI->APIC IRQ transform: (B0,I16,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P0) -> 11
PCI->APIC IRQ transform: (B0,I17,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P3) -> 21
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:11.2, from 10 to 5
PCI: Via IRQ fixup for 00:11.3, from 10 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

