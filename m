Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSEUWdN>; Tue, 21 May 2002 18:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316762AbSEUWdM>; Tue, 21 May 2002 18:33:12 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:47371 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S316763AbSEUWdK>;
	Tue, 21 May 2002 18:33:10 -0400
Date: Wed, 22 May 2002 00:33:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update to srm_env.c update (for Alpha arch.)
Message-ID: <20020521223309.GH13368@lug-owl.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo!

Please accept this (cosmetic) update to the srm_env.c driver. It fixes
a spelinck bug within a comment.

MfG, JBG



--- linux/arch/alpha/kernel/srm_env.c.orig	Wed May 22 00:09:19 2002
+++ linux/arch/alpha/kernel/srm_env.c	Wed May 22 00:12:08 2002
@@ -1,5 +1,5 @@
 /*
- * srm_env.c - Access to SRC environment
+ * srm_env.c - Access to SRM environment
  *             variables through linux' procfs
  *
  * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
@@ -31,6 +31,11 @@
=20
 /*
  * Changelog
+ * ~~~~~~~~~
+ *
+ * Wed, 22 May 2002 00:11:21 +0200
+ * 	- Fix typo on comment (SRC -> SRM)
+ * 	- Call this "Version 0.0.4"
  *
  * Tue,  9 Apr 2002 18:44:40 +0200
  * 	- Implement access by variable name and additionally
@@ -54,7 +59,7 @@
 #define BASE_DIR	"srm_environment"	/* Subdir in /proc/		*/
 #define NAMED_DIR	"named_variables"	/* Subdir for known variables	*/
 #define NUMBERED_DIR	"numbered_variables"	/* Subdir for all variables	*/
-#define VERSION		"0.0.3"			/* Module version		*/
+#define VERSION		"0.0.4"			/* Module version		*/
 #define NAME		"srm_env"		/* Module name			*/
=20
 MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");



--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE86sskHb1edYOZ4bsRAkNhAJ480ksh+M9lbT46TsQe1CwAyaiCgACgkw84
iezQFeGytxtL4cd1tj6FFyI=
=r0U2
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
