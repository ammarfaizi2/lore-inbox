Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTKOJKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKOJKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:10:54 -0500
Received: from real-outmail.cc.huji.ac.il ([132.64.1.18]:20679 "EHLO
	mail2.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261626AbTKOJKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:10:41 -0500
Message-ID: <3FB5DF3F.6090906@mscc.huji.ac.il>
Date: Sat, 15 Nov 2003 10:09:35 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031114
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq 21: no body cared! (this is what dmesg says)
References: <Pine.LNX.4.44.0311140317390.30308-200000@pluto.mscc.huji.ac.il>
In-Reply-To: <Pine.LNX.4.44.0311140317390.30308-200000@pluto.mscc.huji.ac.il>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No 1 knows what this could be?
It says:

irq 21: nobody cared!
Call Trace:
 [<c010b65a>] __report_bad_irq+0x2a/0x90
 [<c010b750>] note_interrupt+0x70/0xb0
 [<c010ba40>] do_IRQ+0x130/0x140
 [<c0106eb0>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x60
 [<c0109c78>] common_interrupt+0x18/0x20
 [<c0106eb0>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x60
 [<c0106ed4>] default_idle+0x24/0x30
 [<c0106f50>] cpu_idle+0x30/0x40
 [<c03e46dc>] start_kernel+0x14c/0x160
 [<c03e4440>] unknown_bootoption+0x0/0x110

handlers:
[<c02c9900>] (snd_intel8x0_interrupt+0x0/0x210)
Disabling IRQ #21

Strange.


Voicu Liviu wrote:

>Hi,
>I just got a new athlon-xp 2500+
>When I start the computer I get Call Trace and also it says "irq 21: no 
>body cared! disabling irq #21"
>My dmesg is attached, why I do get this? I run kernel 2.6.
>Best regards,
>
>  
>
>------------------------------------------------------------------------
>
>Linux version 2.6.0-test9 (root@starshooter) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r2, propolice)) #2 Fri Nov 14 09:58:13 IST 2003
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
> BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
> BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>511MB LOWMEM available.
>On node 0 totalpages: 131056
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 126960 pages, LIFO batch:16
>  HighMem zone: 0 pages, LIFO batch:1
>DMI 2.2 present.
>ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f74e0
>ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
>ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
>ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7e00
>ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 6:10 APIC version 16
>ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
>IOAPIC[0]: Assigned apic_id 2
>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Building zonelist for node : 0
>Kernel command line: root=/dev/hda2
>Initializing CPU#0
>PID hash table entries: 2048 (order 11: 16384 bytes)
>Detected 1840.472 MHz processor.
>Console: colour VGA+ 80x25
>Memory: 514812k/524224k available (2262k kernel code, 8664k reserved, 688k data, 340k init, 0k highmem)
>Calibrating delay loop... 3629.05 BogoMIPS
>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
>CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>CPU: L2 Cache: 512K (64 bytes/line)
>CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU: AMD Athlon(tm) XP 2500+ stepping 00
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>POSIX conformance testing by UNIFIX
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>ENABLING IO-APIC IRQs
>init IO_APIC IRQs
> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
>..TIMER: vector=0x31 pin1=2 pin2=-1
>..MP-BIOS bug: 8254 timer not connected to IO-APIC
>...trying to set up timer (IRQ0) through the 8259A ...  failed.
>...trying to set up timer as Virtual Wire IRQ... failed.
>...trying to set up timer as ExtINT IRQ... works.
>number of MP IRQ sources: 15.
>number of IO-APIC #2 registers: 24.
>testing the IO APIC.......................
>IO APIC #2......
>.... register #00: 02000000
>.......    : physical APIC id: 02
>.......    : Delivery Type: 0
>.......    : LTS          : 0
>.... register #01: 00170011
>.......     : max redirection entries: 0017
>.......     : PRQ implemented: 0
>.......     : IO APIC version: 0011
>.... register #02: 00000000
>.......     : arbitration: 00
>.... IRQ redirection table:
> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> 00 000 00  1    0    0   0   0    0    0    00
> 01 001 01  0    0    0   0   0    1    1    39
> 02 000 00  1    0    0   0   0    0    0    00
> 03 001 01  0    0    0   0   0    1    1    41
> 04 001 01  0    0    0   0   0    1    1    49
> 05 001 01  0    0    0   0   0    1    1    51
> 06 001 01  0    0    0   0   0    1    1    59
> 07 001 01  1    0    0   0   0    1    1    61
> 08 001 01  0    0    0   0   0    1    1    69
> 09 001 01  1    1    0   0   0    1    1    71
> 0a 001 01  0    0    0   0   0    1    1    79
> 0b 001 01  0    0    0   0   0    1    1    81
> 0c 001 01  0    0    0   0   0    1    1    89
> 0d 001 01  0    0    0   0   0    1    1    91
> 0e 001 01  0    0    0   0   0    1    1    99
> 0f 001 01  0    0    0   0   0    1    1    A1
> 10 000 00  1    0    0   0   0    0    0    00
> 11 000 00  1    0    0   0   0    0    0    00
> 12 000 00  1    0    0   0   0    0    0    00
> 13 000 00  1    0    0   0   0    0    0    00
> 14 000 00  1    0    0   0   0    0    0    00
> 15 000 00  1    0    0   0   0    0    0    00
> 16 000 00  1    0    0   0   0    0    0    00
> 17 000 00  1    0    0   0   0    0    0    00
>IRQ to pin mappings:
>IRQ0 -> 0:2
>IRQ1 -> 0:1
>IRQ3 -> 0:3
>IRQ4 -> 0:4
>IRQ5 -> 0:5
>IRQ6 -> 0:6
>IRQ7 -> 0:7
>IRQ8 -> 0:8
>IRQ9 -> 0:9
>IRQ10 -> 0:10
>IRQ11 -> 0:11
>IRQ12 -> 0:12
>IRQ13 -> 0:13
>IRQ14 -> 0:14
>IRQ15 -> 0:15
>.................................... done.
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 1840.0018 MHz.
>..... host bus clock speed is 334.0548 MHz.
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20031002
>IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [APC1] (IRQs 16)
>ACPI: PCI Interrupt Link [APC2] (IRQs *17)
>ACPI: PCI Interrupt Link [APC3] (IRQs 18)
>ACPI: PCI Interrupt Link [APC4] (IRQs *19)
>ACPI: PCI Interrupt Link [APC5] (IRQs 16)
>ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCS] (IRQs *23)
>ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
>ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
>Linux Plug and Play Support v0.97 (c) Adam Belay
>PnPBIOS: Scanning system for PnP BIOS support...
>PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
>PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
>SCSI subsystem initialized
>ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
>IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
>00:00:01[A] -> 2-23 -> IRQ 23
>Pin 2-23 already programmed
>ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
>IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
>00:00:02[A] -> 2-20 -> IRQ 20
>ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
>IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
>00:00:02[B] -> 2-22 -> IRQ 22
>ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
>IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
>00:00:02[C] -> 2-21 -> IRQ 21
>ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
>Pin 2-20 already programmed
>ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
>Pin 2-22 already programmed
>ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
>Pin 2-21 already programmed
>ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
>Pin 2-20 already programmed
>ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
>Pin 2-22 already programmed
>ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
>Pin 2-21 already programmed
>ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
>Pin 2-20 already programmed
>ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
>IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:0)
>00:01:06[A] -> 2-18 -> IRQ 18
>ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
>IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:0)
>00:01:06[B] -> 2-19 -> IRQ 19
>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:0)
>00:01:06[C] -> 2-16 -> IRQ 16
>ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
>IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:0)
>00:01:06[D] -> 2-17 -> IRQ 17
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-17 already programmed
>Pin 2-17 already programmed
>Pin 2-17 already programmed
>Pin 2-19 already programmed
>PCI: Using ACPI for IRQ routing
>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
>Machine check exception polling timer started.
>devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
>devfs: boot_options: 0x1
>ACPI: Power Button (FF) [PWRF]
>ACPI: Fan [FAN] (on)
>ACPI: Processor [CPU0] (supports C1)
>ACPI: Thermal Zone [THRM] (45 C)
>pty: 256 Unix98 ptys configured
>Real Time Clock Driver v1.12
>Non-volatile memory driver v1.2
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected NVIDIA nForce2 chipset
>agpgart: Maximum main memory to use for agp memory: 439M
>agpgart: AGP aperture is 128M @ 0xd0000000
>[drm] Initialized radeon 1.9.0 20020828 on minor 0
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>Using anticipatory io scheduler
>Floppy drive(s): fd0 is 1.44M
>FDC 0 is a post-1991 82077
>PPP generic driver version 2.4.2
>PPP Deflate Compression module registered
>PPP BSD Compression module registered
>NET: Registered protocol family 24
>8139too Fast Ethernet driver 0.9.26
>eth0: RealTek RTL8139 at 0xe0808000, 00:04:61:50:ba:85, IRQ 19
>eth0:  Identified 8139 chip type 'RTL-8101'
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>NFORCE2: IDE controller at PCI slot 0000:00:09.0
>NFORCE2: chipset revision 162
>NFORCE2: not 100% native mode: will probe irqs later
>AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>AMD_IDE: 0000:00:09.0 (rev a2) UDMA100 controller on pci0000:00:09.0
>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>hda: ST340016A, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hdc: TOSHIBA CD-ROM XM-6202S, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
>hdc: ATAPI 32X CD-ROM drive, 256kB Cache, DMA
>Uniform CD-ROM driver Revision: 3.12
>mice: PS/2 mouse device common for all mice
>input: PC Speaker
>input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
>serio: i8042 AUX port at 0x60,0x64 irq 12
>input: AT Translated Set 2 keyboard on isa0060/serio0
>serio: i8042 KBD port at 0x60,0x64 irq 1
>Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
>request_module: failed /sbin/modprobe -- snd-card-0. error = -16
>PCI: Setting latency timer of device 0000:00:06.0 to 64
>intel8x0: clocking to 47367
>ALSA device list:
>  #0: Dummy 1
>  #1: Virtual MIDI Card 1
>  #2: NVidia nForce2 at 0xe2001000, irq 21
>NET: Registered protocol family 2
>IP: routing cache hash table of 4096 buckets, 32Kbytes
>TCP: Hash tables configured (established 32768 bind 65536)
>NET: Registered protocol family 1
>NET: Registered protocol family 17
>found reiserfs format "3.6" with standard journal
>irq 21: nobody cared!
>Call Trace:
> [<c010b65a>] __report_bad_irq+0x2a/0x90
> [<c010b750>] note_interrupt+0x70/0xb0
> [<c010ba40>] do_IRQ+0x130/0x140
> [<c0106eb0>] default_idle+0x0/0x30
> [<c0105000>] _stext+0x0/0x60
> [<c0109c78>] common_interrupt+0x18/0x20
> [<c0106eb0>] default_idle+0x0/0x30
> [<c0105000>] _stext+0x0/0x60
> [<c0106ed4>] default_idle+0x24/0x30
> [<c0106f50>] cpu_idle+0x30/0x40
> [<c03e46dc>] start_kernel+0x14c/0x160
> [<c03e4440>] unknown_bootoption+0x0/0x110
>
>handlers:
>[<c02c9900>] (snd_intel8x0_interrupt+0x0/0x210)
>Disabling IRQ #21
>Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
>reiserfs: checking transaction log (hda2) for (hda2)
>Using r5 hash to sort names
>VFS: Mounted root (reiserfs filesystem) readonly.
>Mounted devfs on /dev
>Freeing unused kernel memory: 340k freed
>Adding 439480k swap on /dev/hda4.  Priority:-1 extents:1
>found reiserfs format "3.6" with standard journal
>Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
>reiserfs: checking transaction log (hda3) for (hda3)
>Using r5 hash to sort names
>blk: queue dfd6a600, I/O limit 4095Mb (mask 0xffffffff)
>eth0: link up, 10Mbps, half-duplex, lpa 0x0000
>  
>


