Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSFELDy>; Wed, 5 Jun 2002 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFELDx>; Wed, 5 Jun 2002 07:03:53 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:26381 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S314702AbSFELDw>;
	Wed, 5 Jun 2002 07:03:52 -0400
Date: Wed, 5 Jun 2002 13:03:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Docu-PATCH] Updated docu for srm_env.o driver
Message-ID: <20020605110352.GP20788@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this patch. It updates the documentation to my driver.

MfG, JBG



--- linux-2.5.20/arch/alpha/Config.help.orig	Wed Jun  5 12:48:39 2002
+++ linux-2.5.20/arch/alpha/Config.help	Wed Jun  5 12:58:54 2002
@@ -570,13 +570,14 @@
   unless you really know what this hack does.
=20
 CONFIG_SRM_ENV
-  If you enable this option, a subdirectory called srm_environment
-  will give you access to the most important SRM environment
-  variables. If you've got an Alpha style system supporting
-  SRC, then it is a good idea to say Yes or Module to this driver.
+  If you enable this option, you'll find all important SRM environment
+  variables in /proc/srm_environment/named_variables/. In addition to
+  this, you can access any custom variable through its assigned number
+  in /proc/srm_environment/numbered_variables/. If you want to access
+  your SRM environment (or if you're building a generic kernel for
+  distribution) it's a good idea to say Y or M to this driver.
=20
-  This driver is also available as a module and will be called
-  srm_env.o if you build it as a module.
+  If you build it as a module, the resulting file will be srm_env.o.
=20
 CONFIG_DEBUG_KERNEL
   Say Y here if you are developing drivers or trying to debug and




--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/fAXHb1edYOZ4bsRAlYhAJ44HskefHocSUDsKHGFXQTMAjVpOACfcSFp
AuVMqFPC4pJamnv9dwaJtRk=
=vRwn
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
