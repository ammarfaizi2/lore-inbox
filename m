Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSK0RqV>; Wed, 27 Nov 2002 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264659AbSK0RqV>; Wed, 27 Nov 2002 12:46:21 -0500
Received: from ip67-93-141-186.z141-93-67.customer.algx.net ([67.93.141.186]:48825
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id <S264653AbSK0RqT>; Wed, 27 Nov 2002 12:46:19 -0500
Date: Wed, 27 Nov 2002 12:53:49 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: p4dpe-g2 intel e7500 dual xeon board boots oddly
Message-ID: <20021127175349.GA14724@ducksong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a new board that seems to have some trouble booting.. I was
wondering what the state-of-the chipset seems to be right now.

it's a p4dpe-g2 board with a intel e7500 chipset and 2 xeons.

this kernel is 2.4.20-rc2-ac3..

Total of 2 processors activated (9581.36 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 8-0, 8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8, 8-9, 8-10, 8-11, 8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22, 8-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
number of IO-APIC #5 registers: 24.
number of IO-APIC #8 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02008000
.......    : physical APIC id: 02
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00

[....]

mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd875, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Discovered primary peer bus 10 [IRQ]
PCI: Discovered primary peer bus 11 [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B2,I1,P0) -> 48
PCI->APIC IRQ transform: (B2,I1,P1) -> 49
PCI->APIC IRQ transform: (B3,I2,P0) -> 28
PCI->APIC IRQ transform: (B3,I2,P1) -> 29

[..]

PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably buggy MP table.
