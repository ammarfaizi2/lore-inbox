Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbTCWO4O>; Sun, 23 Mar 2003 09:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbTCWO4N>; Sun, 23 Mar 2003 09:56:13 -0500
Received: from cpt-dial-196-30-178-159.mweb.co.za ([196.30.178.159]:14208 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S263074AbTCWO4L>;
	Sun, 23 Mar 2003 09:56:11 -0500
Subject: Failed to register cdrom with ide.c
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030323090152.GA1113@brodo.de>
References: <20030319211837.GA23651@brodo.de>
	 <1048146514.12350.43.camel@workshop.saharact.lan>
	 <20030320084148.GA2414@brodo.de>
	 <20030322131503.254c2aa7.azarah@gentoo.org>
	 <20030323090152.GA1113@brodo.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FGPxYa2Axyc6XLfujqq4"
Organization: 
Message-Id: <1048431682.6855.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 23 Mar 2003 17:01:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FGPxYa2Axyc6XLfujqq4
Content-Type: multipart/mixed; boundary="=-dkc87WG4/Lxc/6DAHUeD"


--=-dkc87WG4/Lxc/6DAHUeD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I am sure somebody else had this issue, but I cannot find it now
by browsing the online lists (subscribed at work only).

Up to and with 2.5.65, the kernel boots fine, but with the new
ide stuff merged, my Toshiba DVD do not register with ide.c, and I
get a kernel panic.  This is with bk3, and -ac3.  If I unplug the
drive, the kernel boots fine.

Attached is relevant part of ide initialization from kernel logs.
It is however from 2.5.64.  If you need from 2.5.65-ac3, let me
know ... its just going to be difficult as I only have this box
and a screen less gateway.


Regards,

--=20

Martin Schlemmer




--=-dkc87WG4/Lxc/6DAHUeD
Content-Disposition: attachment; filename=ide
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ide; charset=ISO-8859-1

kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with i=
debus=3Dxx
kernel: ICH2: IDE controller at PCI slot 00:1f.1
kernel: ICH2: chipset revision 4
kernel: ICH2: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
kernel:     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
kernel: hda: ST320011A, ATA DISK drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: PDC20268: IDE controller at PCI slot 02:0a.0
kernel: PDC20268: chipset revision 2
kernel: PDC20268: not 100%% native mode: will probe irqs later
kernel:     ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
kernel:     ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
kernel: hde: ASUS CRW-2410A, ATAPI CD/DVD-ROM drive
kernel: ide2 at 0xd800-0xd807,0xd402 on irq 22
kernel: hdg: MAXTOR 6L040J2, ATA DISK drive
kernel: ide3 at 0xd000-0xd007,0xb802 on irq 22
kernel: hda: host protected area =3D> 1
kernel: hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=3D38792/16/63=
, UDMA(100)
kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
kernel: hdg: host protected area =3D> 1
kernel: hdg: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=3D77557/16/63=
, UDMA(100)
kernel:  /dev/ide/host2/bus1/target0/lun0: p1
kernel: end_request: I/O error, dev hdc, sector 0
kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
kernel: Uniform CD-ROM driver Revision: 3.12
kernel: end_request: I/O error, dev hdc, sector 0
kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
kernel:   Vendor: ASUS      Model: CRW-2410A         Rev: 1.0
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0


--=-dkc87WG4/Lxc/6DAHUeD--

--=-FGPxYa2Axyc6XLfujqq4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fcxCqburzKaJYLYRAhMwAJ90sN4hMcjGukvEOGvENyOGdYMXBwCePjlf
ckEnJ0ugzMkOCyHWn2Ud+5I=
=VDBC
-----END PGP SIGNATURE-----

--=-FGPxYa2Axyc6XLfujqq4--

