Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTIXQUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbTIXQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:20:35 -0400
Received: from aac.uc.pt ([193.137.213.1]:64177 "EHLO mail.aac.uc.pt")
	by vger.kernel.org with ESMTP id S261464AbTIXQUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:20:24 -0400
Date: Wed, 24 Sep 2003 17:20:01 +0100 (WEST)
From: Joao Seabra <seabra@aac.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: ACPI: Unexpected IO-APIC
In-Reply-To: <20030924160948.31778.qmail@web12606.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0309241713430.28299@aac.uc.pt>
References: <20030924160948.31778.qmail@web12606.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting 2.4.22 kernel reported unexpected IO-APIC:

zone(1): 192506 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6410
ACPI: RSDT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x2fffa000
ACPI: FADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x2fffa0b6
ACPI: BOOT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x2fffa030
ACPI: MADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x2fffa058
ACPI: DSDT (v001   ASUS L5C      0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x1])
Using ACPI (MADT) for SMP configuration information
Kernel command line: hda=ide-scsi vga=0x317 video=vesa:ywrap,mtrr
ide_setup: hda=ide-scsi
Initializing CPU#0
Detected 2800.120 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 5583.66 BogoMIPS
Memory: 775224k/786408k available (1352k kernel code, 10796k reserved,
518k data, 116k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
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
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
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
..... CPU clock speed is 2800.0770 MHz.
..... host bus clock speed is 133.3369 MHz.
cpu: 0, clocks: 1333369, slice: 666684
CPU0<T0:1333360,T1:652144,D:14532,S:666684,C:1333369>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xf1670, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:.............................................................................................................................................................................................................
Table [DSDT](id F004) - 580 Objects with 58 Devices 205 Methods 26 Regions
ACPI Namespace successfully loaded at root c030933c
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
APIC error on CPU0: 00(40)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at
000000000000E430 on int 9
Completing Region/Field/Buffer/Package
initialization:..........................................................................
Initialized 26/26 Regions 0/0 Fields 21/21 Buffers 27/27 Packages (588
nodes)
Executing all Device _STA and_INI
methods:...........................................................
59 Devices found containing: 59 _STA, 3 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 11 15, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (off)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:02[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:00:03[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded

 [...]

 Kind Regards,

 Joao Seabra


