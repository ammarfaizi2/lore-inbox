Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSE1X5P>; Tue, 28 May 2002 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSE1X5O>; Tue, 28 May 2002 19:57:14 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31505 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S311898AbSE1X5N>;
	Tue, 28 May 2002 19:57:13 -0400
Date: Wed, 29 May 2002 01:57:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.5] Trivial compile fix to fs/binfmt_em86.c
Message-ID: <20020528235713.GX4148@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7NLafZe7Bh9OCap"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U7NLafZe7Bh9OCap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this patch to let binfmt_em86.c compile again.

MfG, JBG



diff -Nur orig/linux-2.5.18/fs/binfmt_em86.c linux-2.5.18/fs/binfmt_em86.c
--- orig/linux-2.5.18/fs/binfmt_em86.c	Sat May 25 03:55:28 2002
+++ linux-2.5.18/fs/binfmt_em86.c	Tue May 28 20:18:00 2002
@@ -16,7 +16,9 @@
 #include <linux/binfmts.h>
 #include <linux/elf.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/errno.h>
=20
=20
 #define EM86_INTERP	"/usr/bin/em86"


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--U7NLafZe7Bh9OCap
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE89BlSHb1edYOZ4bsRAkqTAJ9BXHvWukB36exceSdW7jyek3fG2wCfT0UR
NZbTt6X7vDjqEcNGrcPb2k4=
=+0AS
-----END PGP SIGNATURE-----

--U7NLafZe7Bh9OCap--
