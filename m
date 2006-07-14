Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945901AbWGNXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901AbWGNXII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945902AbWGNXII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:08:08 -0400
Received: from mail.gmx.net ([213.165.64.21]:941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945901AbWGNXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:08:05 -0400
X-Authenticated: #2308221
Date: Sat, 15 Jul 2006 01:08:01 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: FYI: strange libata EH lines in dmesg once after every bootup
Message-ID: <20060714230801.GA6645@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

the following happens every time after bootup, tested with freshly built
2.6.18-rc1-mm2:=20


DMA write timed out
ata1: EH complete
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata2: EH complete
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back


Both disks are SAMSUNG SV1203N on a Promise 20269. What remained of
dmesg, hdparm -I and lspci attached.

Kind regards,
Chris

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:0c.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
00:0c.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
00:0c.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63)
00:0d.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0f.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:10.0 SCSI storage controller: Adaptec AHA-2940UW Pro / AIC-788x (rev 01)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=sda
Content-Transfer-Encoding: quoted-printable


/dev/sda:

ATA device, with non-removable media
	Model Number:       SAMSUNG SV1203N                        =20
	Serial Number:      S01CJ10Y410901     =20
	Firmware Revision:  TQ100-30
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0=20
	Supported: 7 6 5 4=20
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  234493056
	LBA48  user addressable sectors:  234493056
	device size with M =3D 1024*1024:      114498 MBytes
	device size with M =3D 1000*1000:      120060 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Recommended acoustic management value: 254, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D240ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	    	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	56min for SECURITY ERASE UNIT. 56min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
	CBLID- above Vih
	Device num =3D 0 determined by the jumper
Checksum: correct

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=sdb
Content-Transfer-Encoding: quoted-printable


/dev/sdb:

ATA device, with non-removable media
	Model Number:       SAMSUNG SV1203N                        =20
	Serial Number:      S01CJ10Y410900     =20
	Firmware Revision:  TQ100-30
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0=20
	Supported: 7 6 5 4=20
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  234493056
	LBA48  user addressable sectors:  234493056
	device size with M =3D 1024*1024:      114498 MBytes
	device size with M =3D 1000*1000:      120060 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Recommended acoustic management value: 254, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D240ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	    	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	56min for SECURITY ERASE UNIT. 56min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
	CBLID- above Vih
	Device num =3D 0 determined by the jumper
Checksum: correct

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=dmesg
Content-Transfer-Encoding: quoted-printable

36 (order: 6, 262144 bytes)
Memory: 898632k/917504k available (3368k kernel code, 18268k reserved, 867k=
 data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3001.33 BogoMIPS (lpj=3D15=
00666)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000420 00000000 00=
000000 00000000
CPU: AMD Athlon(TM) XP2000+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e18)
checking if image is initramfs... it is
Freeing initrd memory: 5639k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0f00, last bus=3D1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:03: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:03: ioport range 0xe800-0xe80f has been reserved
pnp: 00:03: ioport range 0x290-0x291 has been reserved
pnp: 00:03: ioport range 0x370-0x373 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8800000-f9dfffff
  PREFETCH window: f9f00000-fbffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x3a set to 0x1
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
matroxfb: Matrox G550 detected
PInS memtype =3D 5
matroxfb: MTRR's turned on
matroxfb: 1280x1024x32bpp (virtual: 1280x3276)
matroxfb: framebuffer at 0xFA000000, mapped to 0xf8880000, size 33554432
Console: switching to colour frame buffer device 160x128
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 32M @ 0xfc000000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EP=
P,ECP,DMA]
parport0: Printer, Hewlett-Packard HP LaserJet 1100
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 10 (level, low) -=
> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at f8802000.
PCI: Enabling device 0000:00:10.0 (0016 -> 0017)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKD] -> GSI 3 (level, low) ->=
 IRQ 3
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Pro Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

libata version 2.00 loaded.
pata_pdc2027x 0000:00:0f.0: version 0.74-ac3
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 4 (level, low) ->=
 IRQ 4
pata_pdc2027x 0000:00:0f.0: PLL input clock 18759 kHz
ata1: PATA max UDMA/133 cmd 0xF88217C0 ctl 0xF8821FDA bmdma 0xF8821000 irq 4
ata2: PATA max UDMA/133 cmd 0xF88215C0 ctl 0xF8821DDA bmdma 0xF8821008 irq 4
scsi1 : pata_pdc2027x
ata1.00: ATA-7, max UDMA/133, 234493056 sectors: LBA48=20
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi2 : pata_pdc2027x
ata2.00: ATA-7, max UDMA/133, 234493056 sectors: LBA48=20
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: SAMSUNG SV1203N   Rev: TQ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SV1203N   Rev: TQ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
pata_via 0000:00:11.1: version 0.1.13
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.1, from 0 to 11
ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x9400 irq 14
scsi3 : pata_via
ata3.00: ATAPI, max UDMA/33
ata3.00: configured for UDMA/33
  Vendor: SAMSUNG   Model: CD-R/RW SW-248F   Rev: R605
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata4: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x9408 irq 15
scsi4 : pata_via
ata4.00: ATAPI, max UDMA/33
ata4.00: configured for UDMA/33
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1912  Rev: TM01
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 2:0:0:0: Attached scsi disk sdb
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 1x/48x cd/rw xa/form2 cdda tray
sr 4:0:0:0: Attached scsi CD-ROM sr1
sd 1:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
sr 3:0:0:0: Attached scsi generic sg2 type 5
sr 4:0:0:0: Attached scsi generic sg3 type 5
ACPI: PCI Interrupt 0000:00:0c.2[C] -> Link [LNKB] -> GSI 10 (level, low) -=
> IRQ 10
PCI: VIA IRQ fixup for 0000:00:0c.2, from 255 to 10
ehci_hcd 0000:00:0c.2: EHCI Host Controller
ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0c.2: irq 10, io mem 0xf8000000
ehci_hcd 0000:00:0c.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=3D0000, idProduct=3D0000
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc1-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:0c.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKD] -> GSI 3 (level, low) ->=
 IRQ 3
uhci_hcd 0000:00:0c.0: UHCI Host Controller
uhci_hcd 0000:00:0c.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:0c.0: irq 3, io base 0x0000d800
usb usb2: new device found, idVendor=3D0000, idProduct=3D0000
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc1-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:0c.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0c.1[B] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
uhci_hcd 0000:00:0c.1: UHCI Host Controller
uhci_hcd 0000:00:0c.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:0c.1: irq 11, io base 0x0000d400
usb usb3: new device found, idVendor=3D0000, idProduct=3D0000
usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc1-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:0c.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:5=
5:50 2006 UTC).
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
ALSA device list:
  #0: Ensoniq AudioPCI ENS1370 at 0xd000, irq 11
TCP westwood registered
Using IPI Shortcut mode
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 200k freed
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 56
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
warning: process `touch' used the removed sysctl system call
md: md0 stopped.
md: bind<sdb1>
md: bind<sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 1/1 pages, set 0 bits, status: 0
created bitmap (4 pages) for device md0
md: md_d0 stopped.
md: bind<sdb2>
md: bind<sda2>
raid1: raid set md_d0 active with 2 out of 2 mirrors
md_d0: bitmap initialized from disk: read 9/9 pages, set 192 bits, status: 0
created bitmap (129 pages) for device md_d0
md: md_d1 stopped.
md: bind<sdb3>
md: bind<sda3>
md_d1: setting max_sectors to 2048, segment boundary to 524287
raid0: looking at sda3
raid0:   comparing sda3(100421632) with sda3(100421632)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at sdb3
raid0:   comparing sdb3(100421632) with sda3(100421632)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 200843264 blocks.
raid0 : conf->hash_spacing is 200843264 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
 md_d0: p1 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 >
 md_d1: p1 < p5 p6 p7<7>spurious 8259A interrupt: IRQ7.
 p8 p9 >
NET: Registered protocol family 1
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
Adding 1023992k swap on /dev/md_d0p7.  Priority:0 extents:1 across:1023992k
warning: process `touch' used the removed sysctl system call
XFS mounting filesystem md_d1p8
Ending clean XFS mount for filesystem: md_d1p8
XFS mounting filesystem md_d1p6
Ending clean XFS mount for filesystem: md_d1p6
XFS mounting filesystem md_d1p9
Ending clean XFS mount for filesystem: md_d1p9
XFS mounting filesystem md_d0p11
Ending clean XFS mount for filesystem: md_d0p11
eth0:  setting full-duplex.
NET: Registered protocol family 17
eth0:  setting full-duplex.
lp0: ECP mode
lp0: ECP mode
lp0: ECP mode
lp0: ECP mode
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
DMA write timed out
ata1: EH complete
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata2: EH complete
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata2: EH complete
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back

--FL5UXtIhxfXey3p5--

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUBRLgj0KnY3eLOiwZcAQqL+hAAywqxA3vJCwTlbf++7VVzjxD/A+O2SOgD
SAyRN+gYSoUj1KQhrHL8dNXv//PL/xKJy0BlptM2ThOR2dU83g3wlO/Qlf4xzNwQ
Lp4fBwu1dr6ViBK/SSN0nXe4MYvu7+wKrdZqxwjYiryyjmyDTInW45USgyrC/sTL
x82+jXT3sx93e3fSzRPd+dap7PGjhPIdCCqTu5CN+/TCK9lfDw/1H+SvDRaEvL8p
rUfa3C/psccJvzasHryOgxo67GL1Cx4kRqCYx/9bMWBaCFy4STtgHj2IpH5OHga6
EXSiebjmsk3anw71dOj2Oh5j5KL9CxJw12dYOKS5o7EHAII/3OfIoM05B244k5+B
2qOF2i/p6Dhw3HNeCH2cN7DWFROSgTgfS/iqphPXT3M2cC/DOQwZ2dCCswsOxaSG
H2PWOAPfsO4LIbfMqWw8j9jXOv0LrmoCBb/CyY2N2u0XDYumP+lFzIZJ7yLtzH/u
21es+PcgGHrVOH0f1qoTuxd55RF9qaWHrgUOh5gFeGTwTxtoFfhpH+ngnqx+d5x0
GKh2mxIwAqmTwphWMXTDoFBT9KzLnkEX0rbNODtDJ8F4M+SiQNNLAklY2chPqsIZ
RkE2646bDey4Di6OSa0BLai8fT4M8RP32hbGVKNNP7Doumayu7HBN8cTre7TH1vT
n2NOTjaHWB8=
=wma0
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

