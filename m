Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTEWUjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEWUjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:39:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22464 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264184AbTEWUjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:39:02 -0400
Date: Fri, 23 May 2003 17:51:17 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: ncorbic@sangoma.com
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix multiline string on sdla_chdlc
Message-ID: <20030523205117.GX2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BcZrms9gUsdgyR6a"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BcZrms9gUsdgyR6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Detected when using gcc 3.3.

--=20
Eduardo


diff -purN linux-2.4.orig/drivers/net/wan/sdla_chdlc.c linux-2.4/drivers/ne=
t/wan/sdla_chdlc.c
--- linux-2.4.orig/drivers/net/wan/sdla_chdlc.c	2003-05-22 20:13:17.0000000=
00 -0300
+++ linux-2.4/drivers/net/wan/sdla_chdlc.c	2003-05-22 20:13:17.000000000 -0=
300
@@ -591,8 +591,7 @@ int wpc_init (sdla_t* card, wandev_conf_
 =09
=20
 		if (chdlc_set_intr_mode(card, APP_INT_ON_TIMER)){
-			printk (KERN_INFO "%s:=20
-				Failed to set interrupt triggers!\n",
+			printk (KERN_INFO "%s: Failed to set interrupt triggers!\n",
 				card->devname);
 			return -EIO;=09
         	}

--BcZrms9gUsdgyR6a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zonFcaRJ66w1lWgRArURAJ4/VY4GRBRrVnKjRvmtIG11ti1YJQCfcORN
ZipIeF73EfvnpXjTo+dpimc=
=hew+
-----END PGP SIGNATURE-----

--BcZrms9gUsdgyR6a--
