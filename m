Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUJEJYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUJEJYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJEJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:24:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:21728 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268907AbUJEJXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:23:04 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm2
Date: Tue, 5 Oct 2004 11:25:04 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org>
In-Reply-To: <20041004020207.4f168876.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1385008.ksIJCADXf3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410051125.07489.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1385008.ksIJCADXf3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 October 2004 11:02, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2=
=2E6
>.9-rc3-mm2/

i get a lot of usb errors on boot. they appear since -rc2-mm1.
below the relevant part of dmesg output. i'm not sure if the "Neighbour tab=
le=20
overflow" messages are also relevant? i didn't get them before in this lan=
=20
network i'm now. (but they are here since about 3 months, i thought it=20
depends on the lan connection, so i didn't report it, but now they are=20
present on my main lan too):

sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x10c0
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[17]  MMIO=3D[e2427000-e2427=
7ff] =20
Max
 Packet=3D[2048]
snd: Unknown parameter `device_gid'
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
intel8x0_measure_ac97_clock: measured 49715 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem 0xe2420000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller=
=20
(#2)
ohci_hcd 0000:00:03.1: irq 21, pci mem 0xe2421000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000010dc001ee09a]
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller=
=20
(#3)
ohci_hcd 0000:00:03.2: irq 22, pci mem 0xe2422000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
usb 2-1: new full speed USB device using address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem 0xe2423000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 2-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
ohci_hcd 0000:00:03.1: wakeup
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:ff:af:cd:aa.
usb 2-1: new full speed USB device using address 3
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
eth1: RealTek RTL8139 at 0xd135a000, 00:50:fc:2d:9a:5c, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8139C'
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
Linux video capture interface: v1.00
saa7130/34: v4l2 driver version 0.2.12 loaded
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
saa7134[0]: found at 0000:00:08.0, rev: 1, irq: 19, latency: 32, mmio:=20
0xe242600
0
saa7134[0]: subsystem: 16be:0003, board: Medion 7134 [card=3D12,autodetecte=
d]
saa7134[0]: board init: gpio is 0
saa7134[0]: i2c eeprom 00: be 16 03 00 08 20 1c 55 43 43 a9 1c 55 43 43 a9
saa7134[0]: i2c eeprom 10: ff ff ff ff 15 00 0e 01 0c c0 08 00 00 00 00 00
saa7134[0]: i2c eeprom 20: 00 00 00 e3 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner: Ignoring new-style parameters in presence of obsolete ones
tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
tda9887: Ignoring new-style parameters in presence of obsolete ones
tda9885/6/7: chip found @ 0x86
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
eth0: Media Link On 100mbps full-duplex
  Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
eth0: Media Link On 100mbps full-duplex
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
printk: 64315 messages suppressed.


lspci (only usb part):
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e2420000 (32-bit, non-prefetchable) [size=3D4K]

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at e2421000 (32-bit, non-prefetchable) [size=3D4K]

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at e2422000 (32-bit, non-prefetchable) [size=3D4K]

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0=20
Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e2423000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


btw, no usb devices are connected.

best regards,
dominik

--nextPart1385008.ksIJCADXf3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQWJocwvcoSHvsHMnAQJuDAQAhFw+a8atil3/YK20KT4DG/OMxo5zgOin
lXBffcrEFzOg9HpFefB0qZuy7dvYqZAziB39IIo+Q6+Z/Th76cIitzV9oiaco2vo
jDBaF7gUb5YDRf3N2DXGV4PLCo/WOKp2npTVxRGYgrn7tENOktJqi0nLHxKx1c3f
ljGGGODBBJI=
=AECY
-----END PGP SIGNATURE-----

--nextPart1385008.ksIJCADXf3--
