Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316940AbSEWQRZ>; Thu, 23 May 2002 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316941AbSEWQRY>; Thu, 23 May 2002 12:17:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:1100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316940AbSEWQRX>;
	Thu, 23 May 2002 12:17:23 -0400
Date: Thu, 23 May 2002 18:17:10 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: torvalds@transmeta.com, perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.17-cset1.656-alsa] patch to compile latest alsa
Message-Id: <20020523181710.555b45fd.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.p2ClnVErtYixKo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.p2ClnVErtYixKo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
this trivial patch let alsa compile (renamed file)
I have no rme9652 based card but a ymfpci based, got a error because of missing rme9652/_rme9652.o and with this patch it compiles (for me)

Bye

diff -Nur test/linux-2.5.17/sound/pci/Makefile linux-2.5.17/sound/pci/Makefile
--- test/linux-2.5.17/sound/pci/Makefile        Tue May 21 07:07:29 2002
+++ linux-2.5.17/sound/pci/Makefile     Thu May 23 17:45:28 2002
@@ -50,7 +50,7 @@
           emu10k1/_emu10k1.o \
           korg1212/_korg1212.o \
           nm256/_nm256.o \
-          rme9652/_rme9652.o \
+          rme9652/_rmeh.o \
           trident/_trident.o \
           ymfpci/_ymfpci.o
 endif
--=.p2ClnVErtYixKo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE87RYKe9FFpVVDScsRAn3SAJ41l7rbC+Mq+ChDCBgPbaDzOY1IZgCcC15x
lDLwxuQ0JFtnFhfUHVBxlS8=
=yrBD
-----END PGP SIGNATURE-----

--=.p2ClnVErtYixKo--

