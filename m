Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTE0XdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTE0XdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:33:20 -0400
Received: from c-110372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.17]:7040
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264444AbTE0XdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:33:18 -0400
Subject: 2.4.21-rc3,4 problems, ide-scsi.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E/RSXhccmK9mIzro+EDx"
Organization: 
Message-Id: <1054079192.2815.9.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 01:46:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E/RSXhccmK9mIzro+EDx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I have a odd problem with ide-scsi, which started in -rc3.

When i try to use the ide-scsi emu on my cdburner i get:
ide_scsi: CoD !=3D 0 in idescsi_pc_intr

And then it tries to reset the dma and start all over again. This burner
has worked fine with other kernels before.
(ie, it never actually boots past this point)

hdc: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)

I dunno what additional information you would require...
(worked fine in 2.4.20 at least, some later -ac series crashed my comp
while burning, with dma error messages and oopses. (but since i run
nvidias drivers i didn't submit them)

Any clues?

CC, since i'm not on this list.

--=20
Ian Kumlien <pomac@vapor.com>

--=-E/RSXhccmK9mIzro+EDx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+0/jX7F3Euyc51N8RAj+IAKCe/oqUoPEWbEqCXEBRkojtw8kEVwCfdhoN
fCAv7zG87EtArTc2RBMbUYE=
=QLDL
-----END PGP SIGNATURE-----

--=-E/RSXhccmK9mIzro+EDx--

