Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVANXUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVANXUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVANXUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:20:46 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:47541 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261916AbVANXQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:16:43 -0500
Date: Fri, 14 Jan 2005 21:16:41 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: dmesg log shows errors with USB printer
Message-ID: <20050114231641.GA5660@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi, all.

I have an USB printer (an HP Deskjet 840C) and, for a long time, I've been
getting some error messages in my dmesg logs whenever I turn the printer on
or turn the printer off.

They've appeared here for ages (that is, for many, many 2.6 kernels), but
only now I got some time to sit and grab all he necessary information.

The message is the following:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

and, depending on the work I am doing, it appears quite a lot in my logs,
besides looking scary. And I would like to know if I am doing something
wrong or not.

I'm attaching my whole dmesg log and the output of lspci on this message.


Thanks for any help, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.10-ac5-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #1 Fri Jan 7 01:45:59 BRST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61420 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux root=303
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01204000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 605.691 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255608k/262064k available (2237k kernel code, 5912k reserved, 725k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1191.93 BogoMIPS (lpj=595968)
Security Framework v1.0.0 initialized
Capability LSM initialized
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
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 32M @ 0xe6000000
[drm] Initialized mga 3.1.0 20021029 on minor 0: 
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 0000:00:0a.0
ttyS14 at I/O 0xa000 (irq = 5) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:0d.0
eth0: RealTek RTL8139 at 0xd080e000, 00:e0:7d:96:28:8f, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Found IRQ 9 for device 0000:00:0d.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
eth1: RealTek RTL8139 at 0xd0810000, 00:e0:7d:95:c9:9c, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CX13.0A, ATA DISK drive
hdb: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QUANTUM FIREBALLlct15 30, ATA DISK drive
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
hda: max request size: 128KiB
hda: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
hdc: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1
hdb: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
PCI: Found IRQ 11 for device 0000:00:0c.0
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0x9400, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 9 for device 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 9, io base 0xd400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: irq 9, io base 0xd000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
usb 2-2: new full speed USB device using uhci_hcd and address 3
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:11.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e1800000-e18007ff]  Max Packet=[2048]
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 1-1.1: new full speed USB device using uhci_hcd and address 3
input: USB HID v1.00 Keyboard [Silitek  Silitek USB Keyboard] on usb-0000:00:04.2-1.1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011066645555ead]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
drivers/usb/input/hid-input.c: event field not found
Unable to identify CD-ROM format.
Unable to identify CD-ROM format.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 336 bytes per conntrack
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
drivers/usb/class/usblp.c: usblp0: error -115 writing to printer
usb 2-1: USB disconnect, address 2
drivers/usb/class/usblp.c: usblp0: removed
usb 2-1: new full speed USB device using uhci_hcd and address 4
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 4 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lspci-vvvxx.txt"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 03 06 00 10 22 02 00 00 06 00 08 00 00
10: 08 00 00 e6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e2800000-e3dfffff
	Prefetchable memory behind bridge: e3f00000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 00
20: 80 e2 d0 e3 f0 e3 f0 e5 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 10 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 10 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

0000:00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 57 30 00 00 90 02 30 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 a4 00 00 00 00 00 e2 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 20 40

0000:00:0a.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: 5610 56K FaxModem USR 56k Internal Voice Modem (Model 2976)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a000 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b9 12 08 10 01 00 10 02 01 02 00 07 00 00 00 00
10: 01 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 12 aa 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 00 00

0000:00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e1800000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 9800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 97 00 10 02 46 10 00 0c 08 20 00 00
10: 00 00 80 e1 01 98 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 44 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 20

0000:00:0c.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 74 12 80 58 05 00 10 24 02 00 01 04 00 20 00 00
10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 03 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0c 80

0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 90 00 00 00 00 00 e1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 20 40

0000:00:11.0 Unknown mass storage controller: Promise Technology, Inc. PDC20265 (FastTrak100 Lite/Ultra100) (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 8800 [size=8]
	Region 1: I/O ports at 8400 [size=4]
	Region 2: I/O ports at 8000 [size=8]
	Region 3: I/O ports at 7800 [size=4]
	Region 4: I/O ports at 7400 [size=64]
	Region 5: Memory at e0800000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 30 0d 07 00 10 02 02 00 80 01 00 20 00 00
10: 01 88 00 00 01 84 00 00 01 80 00 00 01 78 00 00
20: 01 74 00 00 00 00 80 e0 00 00 00 00 5a 10 33 4d
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e2800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e3ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 2b 10 25 05 07 00 90 02 04 00 00 03 08 40 00 00
10: 08 00 00 e4 00 00 00 e3 00 00 80 e2 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 d8 19
30: 00 00 ff e3 dc 00 00 00 00 00 00 00 0b 01 10 20


--6TrnltStXW4iwmi0--
