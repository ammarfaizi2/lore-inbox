Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTEWUXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEWUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:23:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:958 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264174AbTEWUXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:23:23 -0400
Date: Fri, 23 May 2003 17:35:32 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: twoller@crystal.cirrus.com, nils@kernelconcepts.de
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix InitStruct types on cs46xx driver
Message-ID: <20030523203532.GT2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FWibJpkbnkY6rrXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FWibJpkbnkY6rrXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Detected when using gcc 3.3.

--=20
Eduardo


diff -purN linux-2.4.orig/drivers/sound/cs46xx.c linux-2.4/drivers/sound/cs=
46xx.c
--- linux-2.4.orig/drivers/sound/cs46xx.c	2003-05-22 20:13:12.000000000 -03=
00
+++ linux-2.4/drivers/sound/cs46xx.c	2003-05-22 20:13:12.000000000 -0300
@@ -947,8 +947,8 @@ static void cs_play_setup(struct cs_stat
=20
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] =3D { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},
=20

--FWibJpkbnkY6rrXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zoYUcaRJ66w1lWgRAjh9AKClhAoi0uGKNMJbib/L0AvLFZq8KQCcDfvp
sad2ZuZAApYGGLj3pl4fuaE=
=Pj2P
-----END PGP SIGNATURE-----

--FWibJpkbnkY6rrXF--
