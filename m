Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269706AbUJAFnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbUJAFnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269708AbUJAFnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:43:10 -0400
Received: from smtpout2.uol.com.br ([200.221.11.55]:60604 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S269706AbUJAFmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:42:47 -0400
Date: Fri, 1 Oct 2004 02:42:34 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux1394-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Problems with new Firewire/IEEE1394 card
Message-ID: <20041001054233.GA5010@ime.usp.br>
Mail-Followup-To: linux1394-user@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear developers,

I just bought myself a Firewire/IEEE1394 PCI card for my old desktop so
that I more easily share files with an IDE drive that I have in an
enclosure.

Unfortunately, I get loads of errors in my dmesg logs when I boot with
kernel 2.6.9-rc3 and I don't see the drive getting recognized.

In fact, the hotplug scripts don't even load the sbp2 module and loading it
manually has no effect at all (i.e., the drive is still not present in the
SCSI layer, it seems).

I'm attaching a dmesg log with this message. The card is a VIA card (I
forgot the model). My computer is a Duron 600MHz with an Asus A7V
motherboard (KT133 chipset) and 386MB of RAM. The drive that I have is an
IDE drive in an ADS Tech "Dual-Link Drive Kit" enclosure which works well
when I plug it on an iBook 2 running Linux (and MacOS X also).

I'm running Debian testing with the latest updates.

BTW, I also tried to plug an iPod (2nd generation) and the results I got
were the same: the drive was not detected (even if I manually loaded the
sbp2 module) and the iPod visor showed the message that it could be
disconnected (and the fact that it was charging the battery).

Is there anything that I could do to further debug/solve the problem?


Thanks in advance for any help, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.9-rc3-2 (root@dumont) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)) #1 Thu Sep 30 10:27:31 BRT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98284
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94188 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux root=303
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 605.616 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 386504k/393136k available (1668k kernel code, 6104k reserved, 592k data, 124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1191.93 BogoMIPS (lpj=595968)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps:        0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
Machine check exception polling timer started.
gx-suspmod: error: no MediaGX/Geode processor found!
speedstep-smi: No Intel CPU detected.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 32M @ 0xe6000000
[drm] Initialized mga 3.1.0 20021029 on minor 0: 
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 52 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:11.0
ttyS14 at I/O 0x9800 (irq = 10) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:0d.0
8139too: 0000:00:09.0: unknown chip version, assuming RTL-8139
8139too: 0000:00:09.0: TxConfig = 0xffffffff
eth0: RealTek RTL8139 at 0xd880e000, ff:ff:ff:ff:ff:ff, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139'
PCI: Found IRQ 9 for device 0000:00:0d.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
eth1: RealTek RTL8139 at 0xd8810000, 00:e0:7d:96:28:8f, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CX13.0A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: Found IRQ 10 for device 0000:00:11.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
es1371: version v0.32 time 10:23:28 Sep 30 2004
PCI: Found IRQ 5 for device 0000:00:0a.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xa000 irq 5 joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Processor cpuid 630 not supported
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 9 for device 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 9, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: irq 9, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using address 2
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 0000:00:0c.0
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[11]  MMIO=[e1800000-e18007ff]  Max Packet=[65536]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Losing some ticks... checking if CPU frequency changed.
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to setting max_packet_size to 512 bytes
usb 2-2: new full speed USB device using address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
eth0: link up, 100Mbps, full-duplex, lpa 0xFFFF
eth1: link up, 10Mbps, half-duplex, lpa 0x0000

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lspci-v.txt"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, medium devsel, latency 8
	Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e2800000-e3dfffff
	Prefetchable memory behind bridge: e3f00000-e5ffffff
	Capabilities: [80] Power Management version 2

0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, stepping, medium devsel, latency 0

0000:00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at a400 [size=256]
	Memory at c2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
	Flags: bus master, slow devsel, latency 32, IRQ 5
	I/O ports at a000 [size=64]
	Capabilities: [dc] Power Management version 1

0000:00:0b.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: 5610 56K FaxModem USR 56k Internal Voice Modem (Model 2976)
	Flags: medium devsel, IRQ 10
	I/O ports at 9800 [size=8]
	Capabilities: [dc] Power Management version 2

0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at e1800000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at 9400 [size=128]
	Capabilities: [50] Power Management version 2

0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9000 [size=256]
	Memory at e1000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:00:11.0 Unknown mass storage controller: Promise Technology, Inc. PDC20265 (FastTrak100 Lite/Ultra100) (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 8800 [size=8]
	I/O ports at 8400 [size=4]
	I/O ports at 8000 [size=8]
	I/O ports at 7800 [size=4]
	I/O ports at 7400 [size=64]
	Memory at e0800000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [58] Power Management version 1

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e2800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e3ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0


--u3/rZRmxL6MmkK24--
