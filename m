Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTBOKXS>; Sat, 15 Feb 2003 05:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTBOKXS>; Sat, 15 Feb 2003 05:23:18 -0500
Received: from B5a22.pppool.de ([213.7.90.34]:29652 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261205AbTBOKXQ>; Sat, 15 Feb 2003 05:23:16 -0500
Subject: [Patch] Enable SSE for AMD Athlon (Thoroughbred) in 2.4.20
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v3TS0hT6eFR5Ztm2lwz4"
Organization: 
Message-Id: <1045266292.12105.41.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Feb 2003 00:44:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v3TS0hT6eFR5Ztm2lwz4
Content-Type: multipart/mixed; boundary="=-TAcD0YC7x1WV8J3QuQR+"


--=-TAcD0YC7x1WV8J3QuQR+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

please include the obvious oneliner attached in 2.4.21 to help
the poor folks having recent Athlons. :)

A similar change for the just released Barton would also be nice but
I do not have the model number handy.

--=20
Servus,
       Daniel

--=-TAcD0YC7x1WV8J3QuQR+
Content-Disposition: attachment; filename=diff
Content-Type: text/plain; name=diff; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- arch/i386/kernel/setup.c.orig	2003-02-03 13:26:38.000000000 +0100
+++ arch/i386/kernel/setup.c	2003-02-14 14:14:12.000000000 +0100
@@ -1421,7 +1421,7 @@
 			 * If the BIOS didn't enable it already, enable it
 			 * here.
 			 */
-			if (c->x86_model =3D=3D 6 || c->x86_model =3D=3D 7) {
+			if (c->x86_model =3D=3D 6 || c->x86_model =3D=3D 7 || c->x86_model =3D=
=3D 8) {
 				if (!test_bit(X86_FEATURE_XMM,
 					      &c->x86_capability)) {
 					printk(KERN_INFO

--=-TAcD0YC7x1WV8J3QuQR+--

--=-v3TS0hT6eFR5Ztm2lwz4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TX90chlzsq9KoIYRApVXAKCviy6/G+0sQHZ9EN9Fq22Bx+rp1QCbB1Dk
snxIOUEOmDZ563DKOeTCcGE=
=+p/l
-----END PGP SIGNATURE-----

--=-v3TS0hT6eFR5Ztm2lwz4--

