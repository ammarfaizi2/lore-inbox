Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbSJMPYX>; Sun, 13 Oct 2002 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbSJMPYX>; Sun, 13 Oct 2002 11:24:23 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:1762 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261536AbSJMPYW>; Sun, 13 Oct 2002 11:24:22 -0400
Date: Sun, 13 Oct 2002 17:30:10 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.42-ac1
Message-Id: <20021013173010.587917d5.us15@os.inf.tu-dresden.de>
In-Reply-To: <200210122239.g9CMdOj10740@devserv.devel.redhat.com>
References: <200210122239.g9CMdOj10740@devserv.devel.redhat.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=./a6fcMLE53+DVw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=./a6fcMLE53+DVw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2002 18:39:24 -0400 (EDT) Alan Cox (AC) wrote:

AC> ** I strongly recommend saying N to IDE TCQ options otherwise this
AC>    should hopefully build and run happily.
AC>
AC> Linux 2.5.42-ac1

Hello,

As you said, everything but TCQ works. Below is the output of a TCQ enabled
kernel in case it's helpful to anyone working on it.

Regards,
-Udo.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hda: bad special flag: 0x03
hda: tagged command queueing enabled, command queue depth 32
hdb: bad special flag: 0x03
hdb: tagged command queueing enabled, command queue depth 32
ide0 at 0x9400-0x9407,0x9002 on irq 10
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hde: DMA disabled
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hda:ide_tcq_intr_timeout: timeout waiting for completion interrupt
hda: invalidating tag queue (1 commands)
hda: status error: status=0x48 { DriveReady DataRequest }

hda: drive not ready for command
hda: status error: status=0x48 { DriveReady DataRequest }

hda: drive not ready for command
 hda1
hdb: host protected area => 1
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hdb:ide_tcq_intr_timeout: timeout waiting for completion interrupt
hdb: invalidating tag queue (1 commands)
hdb: status error: status=0x48 { DriveReady DataRequest }

hdb: drive not ready for command
hdb: status error: status=0x48 { DriveReady DataRequest }

hdb: drive not ready for command
 hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >

--=./a6fcMLE53+DVw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qZGEnhRzXSM7nSkRAjyCAJ9JouOUlpvJdbOonVUcj5z1GJ+AvQCfbwIw
LRTcVNXu56up236sOFrtt+g=
=mSfO
-----END PGP SIGNATURE-----

--=./a6fcMLE53+DVw--
