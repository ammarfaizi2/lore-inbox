Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSCaRCV>; Sun, 31 Mar 2002 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSCaRCL>; Sun, 31 Mar 2002 12:02:11 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:13318 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311739AbSCaRCG>; Sun, 31 Mar 2002 12:02:06 -0500
Subject: [PATCH] 2.4.19-pre5 mwave driver fix
From: Thomas Hood <jdthood@yahoo.co.uk>
To: Paul B Schroeder <paulsch@haywired.net>
Cc: linux-kernel@vger.kernel.org, wes schreiner <wes@infosink.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-hMqUnzQUgRJM7upVgapB"
X-Mailer: Evolution/1.0.2 
Date: 31 Mar 2002 12:03:25 -0500
Message-Id: <1017594213.7257.807.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hMqUnzQUgRJM7upVgapB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul:  This patch is required to restore the kernel configuration
menu option for the Mwave driver to 2.4.19-pre5.  Somewhere along
the line it got lost.  Please submit to Marcelo.

Thanks to wes schreiner.         =20
--
Thomas Hood

--- linux-2.4.19-pre5/drivers/char/Config.in.orig	Fri Mar 29 21:03:52 2002
+++ linux-2.4.19-pre5/drivers/char/Config.in	Sun Mar 31 11:46:02 2002
@@ -277,4 +277,8 @@
 if [ "$CONFIG_MIPS_ITE8172" =3D "y" ]; then
   tristate ' ITE GPIO' CONFIG_ITE_GPIO
 fi
+
+if [ "$CONFIG_X86" =3D "y" ]; then
+   tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
+fi
 endmenu

--=-hMqUnzQUgRJM7upVgapB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8p0FdJnAhHStZL6ERAvdGAJkB0wSaK1mrKT3Y9PQw7YDN1mE5XgCfZV2j
fspt/ueUTtuPCx/8dbTIl8U=
=QndC
-----END PGP SIGNATURE-----

--=-hMqUnzQUgRJM7upVgapB--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

