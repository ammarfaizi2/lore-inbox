Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSBIPCK>; Sat, 9 Feb 2002 10:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSBIPCB>; Sat, 9 Feb 2002 10:02:01 -0500
Received: from mta2.rcsntx.swbell.net ([151.164.30.26]:50325 "EHLO
	mta2.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S288969AbSBIPBq>; Sat, 9 Feb 2002 10:01:46 -0500
Date: Sat, 09 Feb 2002 09:04:03 -0600
From: Jason Ferguson <jferg3@swbell.net>
Subject: [PATCH] Updated Fix For "make pdfdocs"
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Message-id: <1013267043.510.10.camel@werewolf>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-V0zA4S+e3qun3GOvhVd2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V0zA4S+e3qun3GOvhVd2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry, the cat ate my last patch. This one seems to actually apply
cleanly.

This patch fixes an SGML error in the last <chapter> tag of the
deviceiobook.tmpl. Problem is that include/asm-i386/io.h doesnt provide
documentation, so trying to include said nonexistant documentation
causes the whole process to fail.

This patch slightly modifies a patch submitted by David Gomez last
October.

Jason Ferguson


*** linux-2.4.18-pre9-virgin/Documentation/DocBook/deviceiobook.tmpl	Tue
May  1 16:20:25 2001
--- linux-2.4.18-pre9-work/Documentation/DocBook/deviceiobook.tmpl	Sat
Feb  9 08:44:23 2002
***************
*** 225,232 ****
    </chapter>

-   <chapter id=3D"pubfunctions">
-      <title>Public Functions Provided</title>
- !Einclude/asm-i386/io.h
-   </chapter>
-
  </book>
--- 225,227 ----



--=-V0zA4S+e3qun3GOvhVd2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ZTpjFw7JmibuIQURAkfKAKCX5zIHUS1qECUeVQYkiZP7/HArYQCdHOPM
EN6n0XhM/z3+W3jGuyYvr68=
=VMVt
-----END PGP SIGNATURE-----

--=-V0zA4S+e3qun3GOvhVd2--

