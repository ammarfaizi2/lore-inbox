Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSJWGbj>; Wed, 23 Oct 2002 02:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSJWGbi>; Wed, 23 Oct 2002 02:31:38 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:18350 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262882AbSJWGbg>; Wed, 23 Oct 2002 02:31:36 -0400
Date: Wed, 23 Oct 2002 02:37:41 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac1 ACPI & IO APIC problem
Message-ID: <20021023063741.GA1830@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz
1G PC2700 RAM
Single CPU
APIC & IO APIC & ACPI enabled

These options do NOT give an error in 2.5.44
2.5.44-ac1 eth0 times out on waiting for dhcp
booting ACPI=off  eth0 gets IP and works

dmesg:
l machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178000
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0000
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
 14 001 01  1    1    0   1   0    1    1    71
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
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.0832 MHz.
..... host bus clock speed is 99.0991 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xf15b0, last bus=1
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
ACPI: Subsystem revision 20021002
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:....................................................................................................................
Table [DSDT] - 311 Objects with 45 Devices 116 Methods 8 Regions
ACPI Namespace successfully loaded at root c049481c
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.............................................
45 Devices found containing: 45 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:....................................
Initialized 4/8 Regions 0/0 Fields 21/21 Buffers 11/11 Packages (311 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:02.06 not present in PCI namespace
PnPBIOS: Found PnP BIOS installation structure at 0xc00fa840
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa870, dseg 0xf0000
pnp: 00:12: ioport range 0xe600-0xe61f has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23)
00:00:02[A] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb1 -> IRQ 22)
00:00:02[B] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xb9 -> IRQ 21)
00:00:02[C] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc1 -> IRQ 20)
00:00:02[D] -> 2-20 -> IRQ 20
Pin 2-22 already programmed
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16)
00:00:08[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xd1 -> IRQ 17)
00:00:08[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xd9 -> IRQ 18)
00:00:08[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xe1 -> IRQ 19)
00:00:08[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Registering system device pic0
Registering system device rtc0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd


No other errors except the eth0 timeout:

eth0: Media Link On 100mbps full-duplex 
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000249 

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

