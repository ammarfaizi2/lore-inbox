Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTBIWTm>; Sun, 9 Feb 2003 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTBIWTl>; Sun, 9 Feb 2003 17:19:41 -0500
Received: from winch-as8-43.win.ORG ([204.184.51.43]:48512 "EHLO
	SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id <S267463AbTBIWTe>; Sun, 9 Feb 2003 17:19:34 -0500
Date: Sun, 9 Feb 2003 16:28:53 -0600
From: David Fries <dfries@mail.win.org>
To: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx 6.2.28, boot warnings
Message-ID: <20030209222853.GA24023@spacedout.fries.net>
References: <87730000.1043275833@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <87730000.1043275833@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I bought an Adaptec 2940UW card about a month ago and I've had three
kernel panics spaced more than a week apart (2.4.19).  After the 2nd
crash I hooked up a serial console and it registered  the following
messages,

Kernel panic: HOST_MSG_LOOP with invalid SCB 2

In interrupt handler - not syncing=20

the only messages before those two were bootup and ppp messages.
After reading some older kernel list e-mails about write combining
(this is a old VIA chipset) I installed
aic79xx-linux-2.4-20030122-tar.gz into a fresh 2.4.21-pre4 tree
compiled and rebooted I haven't had any problems, I'll just have to
wait a couple weeks and see what happens.  Now I'm getting some error
messages on bootup I didn't get previously and I would like to know if
I should ignore them or not.  I have one IDE harddrive, one IDE cdrom,
one SCSI harddrive, and one SCSI cdrom.

Current boot messages
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux version 2.4.21-pre4 (root@SpacedOut) (gcc version 2.95.4 20011002 (De=
bian prerelease)) #27 Sat Feb 8 23:16:01 CST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff0800 (ACPI NVS)
 BIOS-e820: 000000000fff0800 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3D2.4.21 ro root=3D302 console=3DttyS0=
,115200
Initializing CPU#0
Detected 300.689 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 599.65 BogoMIPS
Memory: 256760k/262080k available (1290k kernel code, 4936k reserved, 375k =
data, 220k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP LM15, ATA DISK drive
hda: DMA disabled
hdc: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area =3D> 1
hda: 29336832 sectors (15020 MB) w/1900KiB Cache, CHS=3D29104/16/63
Partition check:
 hda: hda1 hda2
SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 10 for device 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS09U           Rev: 0350
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:3:0): refuses WIDE negotiation.  Using 8bit transfers
scsi0:0:3:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7d
Card was paused
ACCUM =3D 0xf4, SINDEX =3D 0xb8, DINDEX =3D 0xa8, ARG_2 =3D 0x0
HCNT =3D 0xf4 SCBPTR =3D 0x0
SCSISIGI[0x44]:(BSYI|IOI) ERROR[0x0] SCSIBUSL[0x20]=20
LASTPHASE[0x40]:(IOI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI)=20
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE)=20
SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG)=20
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|EN=
SCSIRST|ENSELTIMO)=20
SXFRCTL0[0x80]:(DFON) DFCNTRL[0x78]:(HDMAEN|SDMAEN|SCSIEN|WIDEODD)=20
DFSTATUS[0x40]:(DFCACHETH)=20
STACK: 0x0 0x16c 0x19c 0x6f
SCB count =3D 4
Kernel NEXTQSCB =3D 3
Card NEXTQSCB =3D 3
QINFIFO entries:=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x37] SCB_LUN[0x0]=20
SCB_TAG[0x2]=20
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)=20
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]=20
Pending list:=20
  2 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x37] SCB_LUN[0x0]=20
Kernel Free SCB list: 1 0=20
Untagged Q(3): 2=20
DevQ(0:0:0): 0 waiting
DevQ(0:3:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:3:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi0:0:3:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
(scsi0:A:3): 8.333MB/s transfers (8.333MHz, offset 15)
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 sda: sda1 sda2
Linux video capture interface: v1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
INIT: version 2.84 booting
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

previous 2.4.19 boot message
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Linux version 2.4.19 (root@SpacedOut) (gcc version 2.95.4 20011002 (Debian =
prerelease)) #24 Tue Oct 29 14:30:22 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff0800 (ACPI NVS)
 BIOS-e820: 000000000fff0800 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3D2.4.19 ro root=3D302 console=3DttyS0
Initializing CPU#0
Detected 300.688 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 599.65 BogoMIPS
Memory: 257060k/262080k available (1106k kernel code, 4636k reserved, 274k =
data, 208k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: detected chipset, but driver not compiled in!
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: QUANTUM FIREBALLP LM15, ATA DISK drive
hdc: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 29336832 sectors (15020 MB) w/1900KiB Cache, CHS=3D29104/16/63
Partition check:
 hda: hda1 hda2
Linux video capture interface: v1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,2): orphan cleanup on readonly fs
EXT3-fs: ide0(3,2): 25 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
INIT: version 2.84 booting
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS09U           Rev: 0350
  Type:   Direct-Access                      ANSI SCSI revision: 03
hub.c: USB new device connect on bus1/2, assigned device number 3
Manufacturer: Logitech
Product: USB Mouse
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
(scsi0:A:3): 8.333MB/s transfers (8.333MHz, offset 15)
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
sg sd_mod Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 sda: sda1 sda2
isofs sr_mod Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ide-scsi scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W4012A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SCSI AIC config options,
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
# CONFIG_SCSI_AIC79XX is not set

/proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=3D16. =20
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x A=
GP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] =
(rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (re=
v 6).
      Master Capable.  Latency=3D64. =20
      I/O at 0xe400 [0xe40f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 2).
      IRQ 9.
      Master Capable.  Latency=3D64. =20
      I/O at 0xe000 [0xe01f].
  Bus  0, device   7, function  3:
    PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
      IRQ 9.
  Bus  0, device   8, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 0).
      IRQ 10.
      Master Capable.  Latency=3D64.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xea000000 [0xea000fff].
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video Capture =
(rev 17).
      IRQ 12.
      Master Capable.  Latency=3D64.  Min Gnt=3D16.Max Lat=3D40.
      Prefetchable 32 bit memory at 0xea001000 [0xea001fff].
  Bus  0, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 1=
7).
      IRQ 12.
      Master Capable.  Latency=3D64.  Min Gnt=3D4.Max Lat=3D255.
      Prefetchable 32 bit memory at 0xea002000 [0xea002fff].
  Bus  0, device  10, function  0:
    Multimedia audio controller: Trident Microsystems 4DWave DX (rev 2).
      IRQ 7.
      Master Capable.  Latency=3D64.  Min Gnt=3D2.Max Lat=3D5.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xea003000 [0xea003fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 1).
      IRQ 10.
      Master Capable.  Latency=3D64.  Min Gnt=3D16.Max Lat=3D32.
      Prefetchable 32 bit memory at 0xe8000000 [0xe8ffffff].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4003fff].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe57fffff].

/proc/scsi/scsi
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DGHS09U          Rev: 0350
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4012A Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02

/proc/scsi/aic7xxx/0

Adaptec AIC7xxx driver version: 6.2.28
aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

Serial EEPROM:
0xc178 0xc178 0xc178 0xc158 0xc178 0xc178 0xc178 0xc378=20
0xc178 0xc178 0xc178 0xc178 0xc178 0xc178 0xc178 0xc178=20
0x18a6 0x001b 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff=20
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x5a2d=20

Channel A Target 0 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 17048
		Commands Active 0
		Command Openings 64
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 20.000MB/s transfers (20.000MHz, offset 255)
	Goal: 8.333MB/s transfers (8.333MHz, offset 15)
	Curr: 8.333MB/s transfers (8.333MHz, offset 15)
	Channel A Target 3 Lun 0 Settings
		Commands Queued 5
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)

--=20
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+RtYlAI852cse6PARAni0AKC5dJ0uyQJ95bZ1vrZ1yVTz2/3EzQCgmmRM
Lzg7fjNX5ooGzBIFFsUfPX8=
=Rew7
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
