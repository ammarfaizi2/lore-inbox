Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSBIO12>; Sat, 9 Feb 2002 09:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSBIO1S>; Sat, 9 Feb 2002 09:27:18 -0500
Received: from mta1.rcsntx.swbell.net ([151.164.30.25]:1192 "EHLO
	mta1.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S288955AbSBIO1D>; Sat, 9 Feb 2002 09:27:03 -0500
Date: Sat, 09 Feb 2002 08:29:15 -0600
From: Jason Ferguson <jferg3@swbell.net>
Subject: [PATCH] Fix make pdfdocs
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Message-id: <1013264955.512.4.camel@werewolf>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-zrnjpFSexC0Wggsdp9G1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zrnjpFSexC0Wggsdp9G1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, Im actually resubmitting a patch I dug up in the archives from David
Gomez back in October to fix a problem when creating the
deviceiobook.pdf file.=20

Details and patch below.

Jason


i, this patch fix an error when generating postscript files. Error is
caused by the absence of documentation in include/asm/io.h.

--- deviceiobookold.tmpl        Sun Oct 28 22:28:36 2001
+++ deviceiobook.tmpl   Sun Oct 28 22:28:45 2001
@@ -224,9 +224,5 @@

   </chapter>

-  <chapter id=3D"pubfunctions">
-     <title>Public Functions Provided</title>
-  !Einclude/asm-i386/io.h
-  </chapter>

 </book>


David G=F3mez

"The question of whether computers can think is just like the question
of
 whether submarines can swim." -- Edsger W. Dijkstra



--=-zrnjpFSexC0Wggsdp9G1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ZTI7Fw7JmibuIQURAi7/AJ9EnC5jKXbtJs5bhkYCxN4MBK6hnACff5WC
dkCLngLtXpWARMQ5LkMAA3A=
=m93F
-----END PGP SIGNATURE-----

--=-zrnjpFSexC0Wggsdp9G1--

