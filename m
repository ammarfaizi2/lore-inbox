Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278374AbRJSL6B>; Fri, 19 Oct 2001 07:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278373AbRJSL5v>; Fri, 19 Oct 2001 07:57:51 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:15369 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S278374AbRJSL5k>;
	Fri, 19 Oct 2001 07:57:40 -0400
Date: Fri, 19 Oct 2001 15:58:19 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for Specialix SX serial card driver
Message-ID: <20011019155819.A3170@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:51pm  up 7 days,  4:01,  4 users,  load average: 0.24, 0.12, 0.15
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Apply and enjoy :)

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sx
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff linux.vanilla/drivers/char/sx.c linux/drivers/ch=
ar/sx.c
--- linux.vanilla/drivers/char/sx.c	Wed Oct 17 11:25:41 2001
+++ linux/drivers/char/sx.c	Fri Oct 19 11:40:24 2001
@@ -257,6 +257,11 @@
 #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
 #endif
=20
+static struct pci_device_id sx_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, PCI_ANY_ID=
, PCI_ANY_ID },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
=20
 /* Configurable options:=20
    (Don't be too sure that it'll work if you toggle them) */

--gBBFr7Ir9EOA20Yy--

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70BVbBm4rlNOo3YgRAj3fAJ9w4DtWOv5E1vxOnZeS5P0ggBkTIwCfaBJO
cBPTT/grxyCWV1jn+9H9cJs=
=EOfC
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
