Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUAGQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUAGQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:27:24 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:4746 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266247AbUAGQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:27:19 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Wed, 7 Jan 2004 08:27:16 -0800 (PST)
From: Neo Wee Teck <weeteck@linux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 ACPI errors (already programmed)
Reply-To: weeteck@linux.net
X-Originating-Ip: [202.156.2.210]
Message-Id: <20040107162716.7F3B33939@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some errors reported when booted with CONFIG_ACPI=y

Wondering if this is serious?

-- dmesg --

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
 BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000f5190
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 65264
zone(0): 4096 pages.
zone(1): 61168 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6c20
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef69c0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
ACPI BALANCE SET
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=/dev/hda6
Initializing CPU#0
Detected 1269.583 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2536.24 BogoMIPS
Memory: 255372k/261056k available (1443k kernel code, 5300k reserved, 275k data, 276k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1269.5619 MHz.
..... host bus clock speed is 133.6380 MHz.
cpu: 0, clocks: 1336380, slice: 668190
CPU0<T0:1336368,T1:668176,D:2,S:668190,C:1336380>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:01[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:01[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:01[C] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:01[D] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1f[C] -> 2-23 -> IRQ 23
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:01:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:01:08[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:01:08[C] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
Pin 2-18 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-16 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-22 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-21 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................


_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
