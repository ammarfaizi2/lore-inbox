Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSH0MBT>; Tue, 27 Aug 2002 08:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSH0MBT>; Tue, 27 Aug 2002 08:01:19 -0400
Received: from B5764.pppool.de ([213.7.87.100]:1152 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S315690AbSH0MBQ>; Tue, 27 Aug 2002 08:01:16 -0400
Subject: Two equal harddrives on one cable behaving different
From: Daniel Egger <degger@fhm.edu>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-xhBg4oeg3//A0lEmr2eZ"
X-Mailer: Ximian Evolution 1.0.7 
Date: 27 Aug 2002 13:03:23 +0200
Message-Id: <1030446205.2539.13.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xhBg4oeg3//A0lEmr2eZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I'm currently in the process of mirroring a drive with bad sector
to an equal second one (same modell, same version, same firmware).
Both of them are on the same cable, the old one as master, the new
one is slave (now on the outer end of the cable). According to=20
smartctl the old one is continously ressolving a couple CRC errors
per hour while the second one hasn't suffered a single one yet.

(195)Hardware ECC Recovered  0x001a   100   100   000       29678
few minutes later:
(195)Hardware ECC Recovered  0x001a   100   100   000       29694

other drive:
(195)Hardware ECC Recovered  0x001a   100   100   000       0

The cable (80 conductor) seems fine (optically) and I'd wonder if it
is the culprit because the drive on the outer end (now) works fine.

Any idea?

Just for the records:
ATA device, with non-removable media
        Model Number:       MAXTOR 6L080J4                         =20
        Serial Number:      6642121550**       =20
        Firmware Revision:  A93.0500
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1=20
        Supported: 5 4 3 2 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  156355584
        device size with M =3D 1024*1024:       76345 MBytes
        device size with M =3D 1000*1000:       80054 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max =3D 16  Current =3D 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6=20
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4=20
             Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400EB-00CPF0, ATA DISK drive
hdc: MAXTOR 6L080J4, ATA DISK drive
hdd: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63
hdc: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=3D155114/16/63
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=3D155114/16/63

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Flags: bus master, medium devsel, latency 0
        Memory at e2000000 (32-bit, prefetchable) [size=3D4M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro13=
3x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 0000d000-0000dfff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo =
VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at e000 [size=3D16]

--=20
Servus,
       Daniel

--=-xhBg4oeg3//A0lEmr2eZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9a1x7chlzsq9KoIYRAl8VAKDQog87T7vSiF/2Pi1ZNC97fjtJ+wCg015R
hdruKxCD79gYXJSiFgtt/Ts=
=sd6k
-----END PGP SIGNATURE-----

--=-xhBg4oeg3//A0lEmr2eZ--

