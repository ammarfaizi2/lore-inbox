Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTFETWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbTFETWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:22:22 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:33920 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264913AbTFETVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:21:46 -0400
Date: Thu, 5 Jun 2003 20:35:14 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andre@linux-ide.org, alan@redhat.com
Subject: SiI3112 (Adaptec 1210SA): no devices
Message-ID: <20030605193514.GB1542@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	andre@linux-ide.org, alan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
the kernel driver doesn't seem to notice this device on boot --
nothing at all appears relating to this device in the boot messages.
Can you help me?

   I'm not a kernel hacker, I'm afraid, but I can apply patches and
test stuff for this card+drive as much as you like...

   (The card is configured in its on-board BIOS with a single disk as
JBOD).

   Thanks,
   Hugo.


Kernel version: 2.4.21-rc7-ac1

vlad:~# dmesg
Linux version 2.4.21-rc7-ac1 (root@vlad) (gcc version 3.3 (Debian)) #1 Thu Jun 5 14:12:04 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ffc000 (usable)
 BIOS-e820: 0000000013ffc000 - 0000000013fff000 (ACPI data)
 BIOS-e820: 0000000013fff000 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81916
zone(0): 4096 pages.
zone(1): 77820 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=816
Initializing CPU#0
Detected 501.149 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 999.42 BogoMIPS
Memory: 321400k/327664k available (1438k kernel code, 5868k reserved, 554k data, 84k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Enabling new style K6 write allocation for 319 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xf06c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: 3c5x9 at 0x300, 10baseT port, address  00 20 af 93 e3 69, IRQ 5.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Detected Ali M1541 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 90648D3, ATA DISK drive
blk: queue c0331dc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-120S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 12656448 sectors (6480 MB) w/512KiB Cache, CHS=787/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAJ3182M SUN18G   Rev: 0503
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:9): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: IBM       Model: DRVS18D           Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:10): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
  Vendor: FUJITSU   Model: MAN3184MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:11): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
scsi0:A:9:0: Tagged Queuing enabled.  Depth 253
scsi0:A:10:0: Tagged Queuing enabled.  Depth 253
scsi0:A:11:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 9, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 10, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 11, lun 0
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
 /dev/scsi/host0/bus0/target9/lun0: p1 < p5 p6 p7 p8 >
SCSI device sdb: 35879135 512-byte hdwr sectors (18370 MB)
 /dev/scsi/host0/bus0/target10/lun0: p1 < p5 p6 p7 p8 p9 >
SCSI device sdc: 35566478 512-byte hdwr sectors (18210 MB)
 /dev/scsi/host0/bus0/target11/lun0: p1 < p5 p6 p7 p8 p9 >
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   713.200 MB/sec
   32regs    :   357.200 MB/sec
   pII_mmx   :   831.200 MB/sec
   p5_mmx    :   850.400 MB/sec
raid5: using function: p5_mmx (850.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
device-mapper: 1.0.3-ioctl-bk (2002-08-5) initialised: lvm-devel@lists.sistina.com
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (2559 buckets, 20472 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 08:16) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 84k freed
Adding Swap: 248968k swap-space (priority 0)
Adding Swap: 248968k swap-space (priority 0)
Adding Swap: 248968k swap-space (priority 0)
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
 [events: 0000004d]
 [events: 0000004d]
 [events: 0000004d]
md: autorun ...
md: considering scsi/host0/bus0/target11/lun0/part5 ...
md:  adding scsi/host0/bus0/target11/lun0/part5 ...
md:  adding scsi/host0/bus0/target10/lun0/part5 ...
md:  adding scsi/host0/bus0/target9/lun0/part5 ...
md: created md0

[loads of md messages snipped]

md: scsi/host0/bus0/target11/lun0/part9 [events: 00001edb]<6>(write) scsi/host0/bus0/target11/lun0/part9's sb offset: 15309824
md: ... autorun DONE.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device fe:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device fe:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device fe:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device fe:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting 3c5x9/3c5x9B half-duplex mode if_port: 0, sw_info: 0431
eth0: Setting Rx mode to 1 addresses.
PCI: Found IRQ 9 for device 00:02.0
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xd4c4a000, IRQ 9
usb-ohci.c: usb-00:02.0, ALi Corporation USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1

[loads of USB messages snipped]

hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
[drm] AGP 0.99 Aperture @ 0xd8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0



vlad:~# lspci -vvv
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
        Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=29 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=29 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7800000-d7ffffff
        Prefetchable memory behind bridge: dff00000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d7000000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: ALi Corporation ALI M7101 Power Management Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 06)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 1005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at d6800000 (32-bit, non-prefetchable) [size=512]

00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)
        Subsystem: Adaptec: Unknown device 0240
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b000 [size=8]
        Region 1: I/O ports at a800 [size=4]
        Region 2: I/O ports at a400 [size=8]
        Region 3: I/O ports at a000 [size=4]
        Region 4: I/O ports at 9800 [size=16]
        Region 5: Memory at d6000000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 9400 [disabled] [size=256]
        Region 1: Memory at d5800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 9000 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at d7800000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at dffe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=29 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



vlad:~# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: ALi Corporation M1541 (rev 4).
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 4).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: ALi Corporation USB 1.1 Controller (rev 3).
      IRQ 9.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd7000fff].
  Bus  0, device   3, function  0:
    Bridge: ALi Corporation M7101 PMU (rev 0).
  Bus  0, device   7, function  0:
    ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev 195).
  Bus  0, device   9, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 6).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xb800 [0xb81f].
  Bus  0, device   9, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb407].
  Bus  0, device  10, function  0:
    Multimedia controller: Philips Semiconductors SAA7146 (rev 1).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=15.Max Lat=38.
      Non-prefetchable 32 bit memory at 0xd6800000 [0xd68001ff].
  Bus  0, device  11, function  0:
    RAID bus controller: CMD Technology Inc Adaptec AAR-1210SA SATA HostRAID Controller (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb007].
      I/O at 0xa800 [0xa803].
      I/O at 0xa400 [0xa407].
      I/O at 0xa000 [0xa003].
      I/O at 0x9800 [0x980f].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd60001ff].
  Bus  0, device  12, function  0:
    SCSI storage controller: Adaptec AIC-7892A U160/m (rev 2).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 64 bit memory at 0xd5800000 [0xd5800fff].
  Bus  0, device  15, function  0:
    IDE interface: ALi Corporation M5229 IDE (rev 193).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0x9000 [0x900f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xd7800000 [0xd787ffff].


vlad:~# tree /dev/ide
/dev/ide
`-- host0
    |-- bus0
    |   `-- target0
    |       `-- lun0
    |           |-- disc
    |           `-- part1
    `-- bus1
        `-- target0
            `-- lun0
                `-- cd

   The tree above is the onboard controller, not the SATA board.



vlad:~# grep ^CONFIG /boot/config-2.4.21-rc7-ac1 
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_LVM=y
CONFIG_BLK_DEV_DM=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_NVIDIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_QUOTA=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_EXT2_FS=y
CONFIG_INTERMEZZO_FS=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="utf8"
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
CONFIG_SOUND_TVMIXER=m
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_MOUSE=m
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_MAGIC_SYSRQ=y


-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
        --- Great oxymorons of the world, no. 2: Common Sense ---        

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+35tyssJ7whwzWGARAj2WAJ4wEgdMAHpEwnCsytP9EmUcNSo23gCeKLq/
4Nqb+v+wsXObbZIO+v2z+ig=
=HRsr
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
