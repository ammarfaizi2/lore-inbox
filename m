Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTFXW2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFXW07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:26:59 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31506 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262490AbTFXW0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:26:13 -0400
Date: Wed, 25 Jun 2003 00:40:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030624224021.GJ6353@lug-owl.de>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <20030624063137.GA6353@lug-owl.de> <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcmJb3WyrQSdDnng"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcmJb3WyrQSdDnng
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-24 15:44:36 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiew=
icz@elka.pw.edu.pl>
wrote in message <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu=
.pl>:

> Corrected patch below...

Taking this 2nd IDE patch, my boot-up looks as shown below. I still have
to test the taskfile thing again, but I cannot find my girlfriends
digital camera right now:)

MfG, JBG

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC2850F, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
hda: tcq forbidden by blacklist
hdb: only one drive on a channel supported for tcq
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L120AVV207-0, ATA DISK drive
hdd: Maxtor 4W100H6, ATA DISK drive
hdc: only one drive on a channel supported for tcq
hdd: only one drive on a channel supported for tcq
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
hda: 1667232 sectors (854 MB) w/64KiB Cache, CHS=3D1654/16/63, DMA
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: host protected area =3D> 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=3D79780/16/63, UDMA(3=
3)
 hdb: hdb1 hdb2 hdb3 hdb4
hdc: max request size: 1024KiB
hdc: host protected area =3D> 1
hdc: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=3D15017/255/63, UDM=
A(33)
 hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 hdc15 h=
dc16 hdc17 >
hdd: max request size: 128KiB
hdd: host protected area =3D> 1
hdd: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=3D194158/16/63, UDM=
A(33)
 hdd: hdd1 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 hdd12 hdd13 hdd14 >
--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--qcmJb3WyrQSdDnng
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++NNTHb1edYOZ4bsRArd+AJoDfwmvMwH6hpFb8RyHggqE6VksfACfd6jY
lVZ3AeGL7p6gI7Hy72qqDNs=
=OSZ/
-----END PGP SIGNATURE-----

--qcmJb3WyrQSdDnng--
