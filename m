Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTKCMHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 07:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTKCMHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 07:07:48 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:59562 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261326AbTKCMHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 07:07:39 -0500
Message-ID: <1067861256.3fa6450807073@imp1-a.free.fr>
Date: Mon,  3 Nov 2003 13:07:36 +0100
From: jfontain@free.fr
To: linux-kernel@vger.kernel.org
Subject: success report: 2.4.23-pre9 on a recent bi-Xeon server
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to the list: please write me directly for any questions.

A short test show that the Apache/MySQL web server works as expected.

# dmesg

536k/1310656k available (1378k kernel code, 17712k reserved, 326k data, 268k
init, 393152k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1462.89 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
Total of 2 processors activated (9555.14 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22, 8-23, 9-0,
9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15,
9-16, 9-17, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23, 10-0, 10-1, 10-2, 10-3, 10-4,
10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15, 10-16,
10-17, 10-18, 10-19, 10-20, 10-21, 10-22, 10-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
number of IO-APIC #10 registers: 24.
testing the IO APIC.......................
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 09000000
.......     : arbitration: 09
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
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
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2392.3256 MHz.
..... host bus clock speed is 132.9068 MHz.
cpu: 0, clocks: 1329068, slice: 443022
CPU0<T0:1329056,T1:886032,D:2,S:443022,C:1329068>
cpu: 1, clocks: 1329068, slice: 443022
CPU1<T0:1329056,T1:443008,D:4,S:443022,C:1329068>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfdb75, last bus=4
PCI: Using configuration type 1
    ACPI-0560: *** Warning: Type override - [DEB_] had invalid type (Integer)
for Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [MLIB] had invalid type (Integer)
for Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [DATA] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [SIO_] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [LEDP] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [GPEN] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [GPST] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [WUES] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [WUSE] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [SBID] had invalid type (String) for
Scope operator, changed to (Scope)
    ACPI-0560: *** Warning: Type override - [SWCE] had invalid type (String) for
Scope operator, changed to (Scope)
IOAPIC[0]: Set PCI routing entry (8-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 8)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5.P5P6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5.P5P7._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (8-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:1d[A] -> 8-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (8-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 8-19 -> IRQ 19
Pin 8-16 already programmed
IOAPIC[0]: Set PCI routing entry (8-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 8-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (8-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:1f[C] -> 8-18 -> IRQ 18
Pin 8-19 already programmed
Pin 8-17 already programmed
Pin 8-18 already programmed
Pin 8-17 already programmed
Pin 8-19 already programmed
IOAPIC[1]: Set PCI routing entry (9-0 -> 0xc9 -> IRQ 24 Mode:1 Active:1)
00:03:08[A] -> 9-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (9-3 -> 0xd1 -> IRQ 27 Mode:1 Active:1)
00:03:08[B] -> 9-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (9-1 -> 0xd9 -> IRQ 25 Mode:1 Active:1)
00:03:08[C] -> 9-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (9-2 -> 0xe1 -> IRQ 26 Mode:1 Active:1)
00:03:08[D] -> 9-2 -> IRQ 26
Pin 9-3 already programmed
IOAPIC[1]: Set PCI routing entry (9-4 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:03:09[B] -> 9-4 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (9-5 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:03:09[C] -> 9-5 -> IRQ 29
Pin 9-0 already programmed
Pin 9-4 already programmed
Pin 9-5 already programmed
Pin 9-0 already programmed
Pin 9-3 already programmed
IOAPIC[1]: Set PCI routing entry (9-6 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:03:07[A] -> 9-6 -> IRQ 30
IOAPIC[1]: Set PCI routing entry (9-7 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:03:07[B] -> 9-7 -> IRQ 31
IOAPIC[2]: Set PCI routing entry (10-0 -> 0x4a -> IRQ 48 Mode:1 Active:1)
00:04:08[A] -> 10-0 -> IRQ 48
IOAPIC[2]: Set PCI routing entry (10-3 -> 0x52 -> IRQ 51 Mode:1 Active:1)
00:04:08[B] -> 10-3 -> IRQ 51
IOAPIC[2]: Set PCI routing entry (10-1 -> 0x5a -> IRQ 49 Mode:1 Active:1)
00:04:08[C] -> 10-1 -> IRQ 49
IOAPIC[2]: Set PCI routing entry (10-2 -> 0x62 -> IRQ 50 Mode:1 Active:1)
00:04:08[D] -> 10-2 -> IRQ 50
Pin 10-3 already programmed
IOAPIC[2]: Set PCI routing entry (10-4 -> 0x6a -> IRQ 52 Mode:1 Active:1)
00:04:09[B] -> 10-4 -> IRQ 52
IOAPIC[2]: Set PCI routing entry (10-5 -> 0x72 -> IRQ 53 Mode:1 Active:1)
00:04:09[C] -> 10-5 -> IRQ 53
Pin 10-0 already programmed
Pin 10-4 already programmed
Pin 10-5 already programmed
Pin 10-0 already programmed
Pin 10-3 already programmed
Pin 10-2 already programmed
Pin 10-1 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Intel(R) PRO/1000 Network Driver - version 5.2.16-k2
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eth1: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: SR244W, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

blk: queue f7c9cc18, I/O limit 4095Mb (mask 0xffffffff)
(scsi1:A:0): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|QAS, 16bit)
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7c52c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: ESG-SHV   Model: SCA HSBP M16      Rev: 0.05
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f7c52018, I/O limit 4095Mb (mask 0xffffffff)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
Partition check:
 sda: sda1 sda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Real Time Clock Driver v1.10e
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
Adding Swap: 11462368k swap-space (priority -1)
e1000: eth0 NIC Link is Up 10 Mbps Half Duplex


-- 
