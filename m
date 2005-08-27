Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVH0Dp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVH0Dp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVH0Dp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:45:57 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:14500 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030290AbVH0Dp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:45:56 -0400
Date: Fri, 26 Aug 2005 23:45:49 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050827034548.GA3101@masoud.ir>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
It crashes for me right off the bat: 
Here is the kernel output:
---
 Filesystem type is ext2fs, partition type 0x83
kernel  /boot/vmlinuz-2.6.13-rc7-git1 root=/dev/hda3 ro console=ttyS0,115200n8 
CONSOLE=/dev/ttyS0
   [Linux-bzImage, setup=0x1200, size=0x1fe4fa]
savedefault
boot
Linux version 2.6.13-rc7-git1 (root@dual) (gcc version 3.3.5 (Debian 1:3.3.5-8ubuntu2)) #1 SMP Fri Aug 26 15:18:21 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000f5fd0
DMI 2.2 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro console=ttyS0,115200n8 CONSOLE=/dev/ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 868.668 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774032k/786368k available (2926k kernel code, 11824k reserved, 1174k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1739.92 BogoMIPS (lpj=8699649)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.36 BogoMIPS (lpj=8686805)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3477.29 BogoMIPS).
ENABLING IO-APIC IRQs
.TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: d0000000-d3ffffff
  PREFETCH window: d4000000-d5ffffff
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1125070419.160:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 3Dfx Interactive, Inc. Voodoo Banshee
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD por<1ai vxl0d0o6e anq:1000S [i1l
8S5P 1
50oduies linkedsio:: .C0 :    o
sE P:    00i0:[<c1abl2e6>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc7-git1) 
EIP is at 0xc160e2e6
eax: efc4b800   ebx: c0537300   ecx: efc4b874   edx: efc4b874
esi: effa1f90   edi: ffffe000   ebp: effa0000   esp: effa1f8c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=effa0000 task=effd2520)
Stack: 00000000 c160e2e0 c160e2e0 ffffe000 effa0000 c0537380 c0537300 c0100e10 
       00000002 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0100e10>] cpu_idle+0x70/0x80
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e6 8c <ff> ff 00 00 00 00 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
---
2.6.13-rc6 boots, but has the bug 5099 (at bugzilla.kernel.org).

cheers,

Masoud Sharbiani  
