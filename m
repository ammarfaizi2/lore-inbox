Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUDURZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUDURZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUDURZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:25:49 -0400
Received: from p15112047.pureserver.info ([217.160.169.118]:22921 "EHLO
	mail.wim-media.de") by vger.kernel.org with ESMTP id S263551AbUDURYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:24:23 -0400
From: Roessner Christian <info@roessner-net.com>
Organization: Roessner Network Solutions
To: linux-kernel@vger.kernel.org
Subject: APIC probs with kernel 2.6.6-rc1-bk2 and usb, bttv
Date: Wed, 21 Apr 2004 19:26:05 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t6qhAV4auQXAfr6"
Message-Id: <200404211926.05479.info@roessner-net.com>
X-Sagator-Scanner: clamd()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_t6qhAV4auQXAfr6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have searched inside the archives for posted problems with apic and usb or 
apic and bttv. Maybe the following was posted once before, but I could not 
find good answers.

When I boot my machine using apic, usb is broken (plugging in the mouse or 
something else does not seem to do anything). I guess someone told about this 
bug earlier.

The second thing is: I tried to use my MIRO PCTV with apic enabled. When 
starting an application such as tvtime or xawtv, the current channel appears 
and everything seems to be ok until I wait some moments or trying to change 
the channel. In this moment, the machine freezes. I found this bug first, 
when using the 2.4.x kernels, but this has not changed in 2.6.x, as I 
recognized.

I hope, someone is reading this and may send me some patches, if he/she likes 
me to test it.

Regards

Christian

N.B.: Logs are attached in a single file.

--Boundary-00=_t6qhAV4auQXAfr6
Content-Type: text/plain;
  charset="us-ascii";
  name="logfile.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="logfile.txt"

dmesg (right after booting):

errupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22)
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:1)
00:00:01[A] -> 2-23 -> IRQ 23
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:1)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:1)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:1)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:1)
00:01:06[D] -> 2-17 -> IRQ 17
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    D9
 11 001 01  1    1    0   1   0    1    1    E1
 12 001 01  1    1    0   1   0    1    1    C9
 13 001 01  1    1    0   1   0    1    1    D1
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   1   0    1    1    A9
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xe8000000, mapped to 0xffffff000004e000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
ikconfig 0.7 with /proc/config*
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
bootsplash 3.1.4-2004/02/19: looking for picture.... silentjpeg size 21830 bytes, found (1024x768, 16923 bytes, v3).
Console: switching to colour frame buffer device 122x40
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3: IDE controller at PCI slot 0000:00:08.0
NFORCE3: chipset revision 165
NFORCE3: not 100% native mode: will probe irqs later
NFORCE3: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6E040L0, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Uhhuh. NMI received for unknown reason 2d.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI Floppy, ATAPI FLOPPY drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Couldn't find valid RAM disk image starting at 0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding 1028152k swap on /dev/hdb2.  Priority:-1 extents:1
EXT3 FS on hdb3, internal journal
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xffffff0001051000, 00:e0:4c:39:30:fb, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8139C'
r8169 Gigabit Ethernet driver 1.2 loaded
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffff0001053000, 00:0d:61:51:4a:fe, IRQ 19
eth1: Auto-negotiation Enabled.
eth1: 100Mbps Full-duplex operation.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-5332  Fri Jan  9 12:42:32 PST 2004
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: JLMS      Model: XJ-HD165H         Rev: CH0Z
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49525 usecs
intel8x0: clocking to 47386
Linux video capture interface: v1.00
bttv: driver version 0.9.14 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 0000:01:08.0, irq: 16, latency: 32, mmio: 0xf0000000
bttv0: using: MIRO PCTV [card=1,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ff07ff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=1 tuner=0 radio=no stereo=no
bttv0: using tuner=0
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 0 (Temic PAL (4002 FH5)) by bt848 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 20, pci mem ffffff00010e7000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 22, pci mem ffffff00010e9000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem ffffff00010eb000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

usb 2-1: new low speed USB device using address 2
Disabled Privacy Extensions on device ffffffff80433320(lo)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
usb 2-1: control timeout on ep0out
ohci_hcd 0000:00:02.1: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 432 bytes per conntrack
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1024x768, 16923 bytes, v3).
bootsplash: status on console 0 changed to on
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 8x mode
eth1: no IPv6 routers present
eth0: no IPv6 routers present
(scsi1:A:4): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: TEAC      Model: CD-W512SB         Rev: 1.0B
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 4, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 4, lun 0,  type 5
CAPI Subsystem Rev 1.1.2.8
b1: revision 1.1.2.2
b1dma: revision 1.1.2.3
b1pci: PCI BIOS reports AVM-B1 at i/o 0x9c00, irq 18
kcapi: Controller 1: b1pci-9c00 attached
b1pci: AVM B1 PCI at i/o 0x9c00, irq 18, revision 2
b1pci: revision 1.1.2.2
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xFFFFFF00021F9080 ctl 0xFFFFFF00021F908A bmdma 0xFFFFFF00021F9000 irq 17
ata2: SATA max UDMA/100 cmd 0xFFFFFF00021F90C0 ctl 0xFFFFFF00021F90CA bmdma 0xFFFFFF00021F9008 irq 17
ata1: no device found (phy stat 00000000)
scsi2 : sata_sil
ata1: thread exiting
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
ata2: thread exiting
USB Universal Host Controller Interface driver v2.2


/proc/cmdline:

hdc=ide-scsi vga=0x317 video=mtrr,vesa=1024x768 root=/dev/hdb3 acpi=force apic console=tty0


lsmod:

Module                  Size  Used by
uhci_hcd               29408  0 
sata_sil                6532  0 
libata                 36864  1 sata_sil,[permanent]
b1pci                   7936  0 
b1dma                  15620  1 b1pci
b1                     22464  2 b1pci,b1dma
kernelcapi             48992  3 b1pci,b1dma,b1
ppp_synctty             8704  0 
ppp_async              11072  1 
ipt_TOS                 2432  20 
iptable_mangle          2752  1 
ipt_REJECT              5824  2 
ipt_MASQUERADE          3520  1 
iptable_nat            22860  2 ipt_MASQUERADE
ipt_state               1984  110 
ip_conntrack           33756  3 ipt_MASQUERADE,iptable_nat,ipt_state
ipt_limit               2496  16 
iptable_filter          2752  1 
ip_tables              17024  8 ipt_TOS,iptable_mangle,ipt_REJECT,ipt_MASQUERADE,iptable_nat,ipt_state,ipt_limit,iptable_filter
parport_pc             32832  1 
lp                     10096  0 
aic7xxx               177592  1 
ehci_hcd               26116  0 
ohci_hcd               18372  0 
usbcore               102768  5 uhci_hcd,ehci_hcd,ohci_hcd
v4l1_compat            12100  0 
tuner                  18444  0 
tvaudio                22028  0 
bttv                  165068  0 
video_buf              18500  1 bttv
i2c_algo_bit            8712  1 bttv
v4l2_common             6720  1 bttv
btcx_risc               4360  1 bttv
i2c_core               20676  4 tuner,tvaudio,bttv,i2c_algo_bit
videodev                9728  1 bttv
snd_pcm_oss            52644  0 
snd_mixer_oss          17728  1 snd_pcm_oss
snd_intel8x0           32036  0 
snd_ac97_codec         65156  1 snd_intel8x0
snd_pcm                94284  2 snd_pcm_oss,snd_intel8x0
snd_timer              23368  1 snd_pcm
snd_page_alloc          9992  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6912  1 snd_intel8x0
snd_rawmidi            22176  1 snd_mpu401_uart
snd_seq_device          7244  1 snd_rawmidi
snd                    48936  9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
ide_scsi               15172  1 
ppp_generic            30752  6 ppp_synctty,ppp_async
slhc                    6720  1 ppp_generic
nvidia               2565236  0 
r8169                  16260  0 
8139too                22144  0 
parport                39564  2 parport_pc,lp
sr_mod                 15012  0 


lspci -vvxxx:

0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [44] #08 [0180]
	Capabilities: [c0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
00: de 10 d1 00 06 01 b0 00 a4 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 08 c0 80 01 22 00 01 01 d0 00 00 00
50: 23 04 1f 00 03 00 00 00 00 00 00 00 00 00 00 00
60: 32 31 03 00 66 45 04 00 66 06 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 30 30 00 00 13 66 66 00
80: 13 66 66 00 c8 00 00 00 70 00 00 00 1f 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 02 00 30 00 1b 42 00 1f 12 03 00 00 ff ff ff ff
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: de 10 d0 00 0f 00 a0 00 a6 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 11 0c
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 58 14 11 0c 00 f0 ff fe fa 3e ff 00 fa 3e ff 00
50: fa 3e ff 00 7f b1 29 04 00 00 00 01 00 00 ff ff
60: 01 10 00 00 01 14 00 00 01 18 00 00 00 00 f9 ff
70: 10 00 ff ff 03 00 00 00 00 00 40 00 18 d2 08 00
80: 09 d2 00 20 28 08 d2 88 3f 00 00 00 00 00 00 00
90: 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 10 00 00 00 00 00 00 80 24 40 20 71 33 14 00
f0: 00 ff 5f bf 00 00 00 00 10 ff ff ff 00 00 30 07

0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 1c00 [size=64]
	Region 5: I/O ports at 2000 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 d4 00 01 00 b0 00 a4 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 1c 00 00 01 20 00 00 00 00 00 00 58 14 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 58 14 11 0c 01 00 02 c0 00 00 00 00 00 00 00 00
50: 01 1c 00 00 01 20 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f5002000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 d7 00 07 00 b0 00 a5 10 03 0c 00 00 80 00
10: 00 20 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 04 50
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01
40: 58 14 04 50 01 00 02 fe 00 00 00 00 02 00 00 00
50: 00 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 ff ff ff 04 0b 30 07

0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at f5003000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 d7 00 07 00 b8 00 a5 10 03 0c 00 00 80 00
10: 00 30 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 04 50
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 03 01
40: 58 14 04 50 01 00 02 fe 00 00 00 00 03 00 00 00
50: 0c 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 ff ff ff 04 0a 30 07

0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at f5004000 (32-bit, non-prefetchable)
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 d8 00 06 00 b0 00 a2 20 03 0c 00 00 80 00
10: 00 40 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 04 50
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 03 03 01
40: 58 14 04 50 0a 80 80 20 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 01 00 00 60 98 81 c3 13 00 00 00 00 00 00
70: 00 00 00 05 00 10 30 80 89 3d 84 22 77 25 04 80
80: 01 00 02 fe 00 00 00 00 00 00 00 00 15 16 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 0c e0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 ff ff ff 00 00 30 07

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
	Subsystem: Giga-byte Technology: Unknown device a002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at d800
	Region 1: I/O ports at dc00 [size=128]
	Region 2: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 da 00 07 00 b0 00 a2 00 01 04 00 00 00 00
10: 01 d8 00 00 01 dc 00 00 00 00 00 f5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 02 a0
30: 00 00 00 00 44 00 00 00 00 00 00 00 09 01 02 05
40: 58 14 02 a0 01 00 02 06 00 00 00 00 06 01 00 01
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 ff ff ff 04 06 30 07

0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology: Unknown device 5002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 d5 00 05 00 b0 00 a5 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 58 14 02 50
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 58 14 02 50 01 00 02 00 00 00 00 00 00 09 00 00
50: 03 f0 00 00 00 00 00 00 77 20 20 20 01 00 22 20
60: 03 c4 c7 c7 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 30 74 19 00 00 1a 34 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 12 ff ff ff 05 0f 30 07

0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
	I/O behind bridge: 00009000-0000cfff
	Memory behind bridge: f3000000-f4ffffff
	Prefetchable memory behind bridge: f0000000-f0ffffff
	Expansion ROM at 00009000 [disabled] [size=16K]
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00: de 10 dd 00 07 01 a0 00 a2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 80 90 c0 80 a2
20: 00 f3 f0 f4 00 f0 f0 f0 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00
40: 00 00 03 00 01 00 02 00 01 00 00 00 00 00 44 00
50: 00 00 fe 1f 00 00 00 00 ff 1f 00 00 03 00 80 00
60: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=10
	Memory behind bridge: f1000000-f2ffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: de 10 d2 00 07 01 20 02 a4 00 04 06 00 10 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 0a f0 00 20 22
20: 00 f1 f0 f2 00 e8 f0 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 00
40: 01 00 00 00 00 00 f0 1f 20 00 00 00 00 00 00 00
50: 00 00 00 e0 00 f0 ff e7 ff ff ff ff ff ff ff ff
60: ff 40 ff 40 00 00 00 20 00 00 00 20 ff ff ff ff
70: ff ff ff ff 00 00 00 00 00 00 00 00 ff ff ff ff
80: ff ff ff ff 00 80 00 00 ed 01 00 00 ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 1b 42 00 1f 00 00 00 00 0c 00 00 00 00 00 00 00
b0: 04 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 20 00 00 80 7c ff 32 07 00 06 30 07
d0: 00 00 00 00 00 00 00 00 08 00 00 e0 ff ff ff e7
e0: b0 b5 f7 ef 90 7f af bf 70 d5 7e df f0 fe ef b9
f0: b0 f6 57 ff e0 ff ef bf d0 3e ef ff 70 f5 f7 ef

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 00 0f 0c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 10 22 04 75 80 02 00 00 00
90: 56 04 51 02 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 1f 00 00 00 20 00 01 00 00 00
50: 00 00 20 00 02 00 00 00 00 00 20 00 03 00 00 00
60: 00 00 20 00 04 00 00 00 00 00 20 00 05 00 00 00
70: 00 00 20 00 06 00 00 00 00 00 20 00 07 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 03 0a 00 00 00 0b 00 00 03 00 20 00 00 70 ff 00
c0: 00 00 00 00 00 00 00 00 13 10 00 00 00 f0 0f 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 00 00 01 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 fe e0 00 00 fe e0 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 00 00 00 00 00 00 00 45 34 83 13 31 0b 00 00
90: 00 8c 0c 08 07 07 7b 06 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: d0 e9 db 2f 6d 00 00 00 7b f7 01 25 a1 3b c6 f1
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 14 be c1 af 6c 2a 9d f8 c9 32 49 fe 2f b8 b1 a7
e0: 0d bf f9 af a8 6a d5 96 5a b5 60 3e 31 66 49 74
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: 68 20 e0 bc f0 00 00 00 00 00 00 00 00 09 20 00
60: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 05 00 00 00 70 00 00 00 00 c4 1f 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 00 00 00
e0: 00 00 00 00 20 0e 5c 00 08 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9000
	Region 1: Memory at f4004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 90 00 00 00 40 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:08.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable)
00: 9e 10 50 03 06 00 80 02 12 00 00 04 00 20 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 10 28
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9400 [disabled]
	Region 1: Memory at f4008000 (32-bit, non-prefetchable) [size=4K]
00: 04 90 78 81 06 00 80 02 00 00 00 01 08 20 00 00
10: 01 94 00 00 00 80 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 08
40: a0 15 00 80 a0 15 00 80 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:0a.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH B1 ISDN
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9800
	Region 1: I/O ports at 9c00 [size=32]
00: 44 12 00 07 07 00 00 00 00 00 80 02 00 20 00 00
10: 01 98 00 00 01 9c 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev 10)
	Subsystem: Giga-byte Technology: Unknown device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at a000
	Region 1: Memory at f4005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 69 81 07 00 b0 02 10 00 00 02 08 20 00 00
10: 01 a0 00 00 00 50 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 e0
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 f7
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:0c.0 RAID bus controller: Integrated Technology Express, Inc.: Unknown device 8212 (rev 11)
	Subsystem: Integrated Technology Express, Inc.: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at a410
	Region 1: I/O ports at a800 [size=4]
	Region 2: I/O ports at ac10 [size=8]
	Region 3: I/O ports at b000 [size=4]
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 83 12 12 82 07 00 30 02 11 00 04 01 00 00 00 00
10: 11 a4 00 00 01 a8 00 00 11 ac 00 00 01 b0 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 83 12 01 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 08 08
40: 00 a0 36 00 08 00 08 00 02 02 00 00 04 02 04 02
50: 01 20 00 00 a3 00 31 31 a3 00 31 31 00 1a 02 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:0d.0 RAID bus controller: CMD Technology Inc: Unknown device 3512 (rev 01)
	Subsystem: CMD Technology Inc: Unknown device 6512
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at b800
	Region 1: I/O ports at bc00 [size=4]
	Region 2: I/O ports at c000 [size=8]
	Region 3: I/O ports at c400 [size=4]
	Region 4: I/O ports at c800 [size=16]
	Region 5: Memory at f4006000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 12 35 07 00 b0 02 01 00 04 01 08 20 00 00
10: 01 b8 00 00 01 bc 00 00 01 c0 00 00 01 c4 00 00
20: 01 c8 00 00 00 60 00 f4 00 00 00 00 95 10 12 65
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 02 a0 20 80 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 22 00 00 00 22 00 00 00 00 00 00 00 ff ff ef a6
90: 00 00 00 08 ff ff 00 00 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 1000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4007000 (32-bit, non-prefetchable)
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 24 80 06 00 10 02 00 10 00 0c 08 20 00 00
10: 00 70 00 f4 00 00 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 09 01 02 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00
f0: 10 00 00 00 82 10 00 00 58 14 00 10 00 00 00 00

0000:02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8063
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f1000000 (32-bit, non-prefetchable)
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
00: de 10 81 01 07 00 b0 02 a2 00 00 03 00 f8 00 00
10: 00 00 00 f1 08 00 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 63 80
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
40: 43 10 63 80 02 00 30 00 1b 0e 00 1f 12 43 00 1f
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


lsusb:

Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  


gcc --version:

gcc (GCC) 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)


uname -a:

Linux amd64 2.6.6-rc1 #3 Wed Apr 21 10:00:56 CEST 2004 x86_64 4  GNU/Linux


emerge -s hotplug:

*  sys-apps/hotplug
      Latest version available: 20040401
      Latest version installed: 20040401

*  sys-apps/hotplug-base
      Latest version available: 20040401
      Latest version installed: 20040401


/proc/interrupts:

           CPU0       
  0:     345800          XT-PIC  timer
  1:       1452    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         50    IO-APIC-edge  i8042
 14:       6155    IO-APIC-edge  ide0
 15:         42    IO-APIC-edge  ide1
 16:        678   IO-APIC-level  bttv0, nvidia
 17:        147   IO-APIC-level  aic7xxx, libata
 18:        227   IO-APIC-level  eth0, b1pci-9c00
 19:          7   IO-APIC-level  eth1
 20:          0   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  ehci_hcd
 22:       1806   IO-APIC-level  NVidia nForce3, ohci_hcd
NMI:          1 
LOC:     345596 
ERR:          0
MIS:          0


/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1c00-1c3f : 0000:00:01.1
2000-203f : 0000:00:01.1
9000-cfff : PCI Bus #01
  9000-90ff : 0000:01:06.0
    9000-90ff : 8139too
  9400-94ff : 0000:01:09.0
  9800-983f : 0000:01:0a.0
  9c00-9c1f : 0000:01:0a.0
    9c00-9c1e : b1pci-9c00
  a000-a0ff : 0000:01:0b.0
    a000-a0ff : eth1
  a410-a417 : 0000:01:0c.0
  a800-a803 : 0000:01:0c.0
  ac10-ac17 : 0000:01:0c.0
  b000-b003 : 0000:01:0c.0
  b400-b40f : 0000:01:0c.0
  b800-b807 : 0000:01:0d.0
    b800-b807 : sata_sil
  bc00-bc03 : 0000:01:0d.0
    bc00-bc03 : sata_sil
  c000-c007 : 0000:01:0d.0
    c000-c007 : sata_sil
  c400-c403 : 0000:01:0d.0
    c400-c403 : sata_sil
  c800-c80f : 0000:01:0d.0
    c800-c80f : sata_sil
d800-d8ff : 0000:00:06.0
dc00-dc7f : 0000:00:06.0
  dc00-dc3f : NVidia nForce3 - Controller
f000-f00f : 0000:00:08.0
  f000-f007 : ide0
  f008-f00f : ide1


/proc/cpuinfo:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 4
model name	: AMD Athlon(tm) 64 Processor 3200+
stepping	: 8
cpu MHz		: 2009.152
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 3981.31
TLB size	: 1088 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


--Boundary-00=_t6qhAV4auQXAfr6--
