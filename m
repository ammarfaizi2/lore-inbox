Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279429AbRJZWKh>; Fri, 26 Oct 2001 18:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279443AbRJZWKR>; Fri, 26 Oct 2001 18:10:17 -0400
Received: from hastur.andastra.de ([212.172.44.2]:22803 "HELO mail.andastra.de")
	by vger.kernel.org with SMTP id <S279429AbRJZWKJ>;
	Fri, 26 Oct 2001 18:10:09 -0400
Date: Sat, 27 Oct 2001 00:11:01 +0200
From: Sebastian Benoit <ben-lists@andastra.de>
To: torvalds@transmeta.com
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre2: typo in drivers/block/nbd.c
Message-ID: <20011027001101.A9358@smtp.andastra.de>
Mail-Followup-To: Sebastian Benoit <ben-lists@andastra.de>,
	torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Cthulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--- drivers/block/nbd.c.orig    Sat Oct 27 00:03:14 2001
+++ drivers/block/nbd.c Fri Oct 26 23:52:24 2001
@@ -471,7 +471,7 @@
=20
 static struct block_device_operations nbd_fops =3D
 {
-       owner:          THIS_MODULE.
+       owner:          THIS_MODULE,
        open:           nbd_open,
        release:        nbd_release,
        ioctl:          nbd_ioctl,



--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72d90OW2TvIKudeQRAimeAJsGNJWvjLPfUx95gNp09ELARphKAwCfcoN/
Jr35ibPozZyJkte4odeqwh4=
=xYX9
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
