Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUAJSbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUAJSbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:31:37 -0500
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:55946 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265359AbUAJSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:31:27 -0500
Date: Sat, 10 Jan 2004 19:31:16 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: [2.6.1] atkbd.c: Unknown key released
Message-ID: <20040110183116.GA8319@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

This line shows up twice in dmesg when starting up X.

atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

Tried with 2.6.1, 2.6.1-mm1. It does not happen in 2.6.0, IIRC. I don't seem to
be able to reproduce the message by pressing any combination on keyboard.

Full dmesg output is atteched.

Rudo.

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=dmesg-output

Linux version 2.6.1 (rudo@rudo.kolej.mff.cuni.cz) (gcc version 3.3.2 20031201 (Gentoo Linux 3.3.2-r4, propolice)) #2 Fri Jan 9 11:22:41 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65532
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61436 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5c10
ACPI: RSDT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x0fffc000
ACPI: FADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x0fffc0b2
ACPI: BOOT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x0fffc030
ACPI: MADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x0fffc058
ACPI: DSDT (v001   ASUS A7V333   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-2.6 rw root=302 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1535.887 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 256500k/262128k available (1504k kernel code, 4908k reserved, 481k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3022.84 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1800+ stepping 02
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
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178002
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0002
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
 09 001 01  1    1    0   1   0    1    1    71
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
..... CPU clock speed is 1535.0001 MHz.
..... host bus clock speed is 266.0956 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf17e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:05[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:05[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:06[A] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
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
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:11[D] -> 2-21 -> IRQ 21
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:09.0, from 5 to 3
PCI: Via IRQ fixup for 0000:00:09.1, from 11 to 0
PCI: Via IRQ fixup for 0000:00:11.2, from 9 to 5
PCI: Via IRQ fixup for 0000:00:11.3, from 9 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6E040L0, ATA DISK drive
hdb: WDC WD136BA, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 26712000 sectors (13676 MB) w/1961KiB Cache, CHS=26500/16/63, UDMA(33)
 /dev/ide/host0/bus0/target1/lun0: p1 p2
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 148k freed
Adding 530136k swap on /dev/hda3.  Priority:-1 extents:1
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
inserting floppy driver for 2.6.1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xd091b000, 00:0a:cd:03:b6:03, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Creative EMU10K1 PCI Audio Driver, version 0.20a, 11:16:48 Jan  9 2004
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xb400-0xb41f, IRQ 19
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
cmpci: version $Revision: 5.64 $ time 11:16:32 Jan  9 2004
cmpci: found CM8738 adapter at io 0xd800 irq 17
cmpci: chip version = 055
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:09.0: UHCI Host Controller
uhci_hcd 0000:00:09.0: irq 19, io base 0000d400
uhci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:09.1: UHCI Host Controller
uhci_hcd 0000:00:09.1: irq 16, io base 0000d000
uhci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 21, io base 0000a400
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 21, io base 0000a000
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ehci_hcd 0000:00:09.2: EHCI Host Controller
ehci_hcd 0000:00:09.2: irq 17, pci mem d091d000
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
registering 0-002d
registering 0-0049
registering 0-0048
hub 3-0:1.0: new USB device on port 2, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:11.2-2
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
blk: queue c13d1600, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c13d1200, I/O limit 4095Mb (mask 0xffffffff)
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

--8t9RHnE3ZwKMSgU+--
