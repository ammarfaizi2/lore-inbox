Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTEWUdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTEWUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:33:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41407 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264180AbTEWUdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:33:19 -0400
Date: Fri, 23 May 2003 17:45:14 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: 95Etwl@alumni.ee.ust.hk, dag@brattli.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] ma600 irda driver: Remove unneeded '##' from macro definition
Message-ID: <20030523204513.GV2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lpUp1egui7PDlNtH"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lpUp1egui7PDlNtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Detected when using gcc 3.3. Compilation fails without this fix.

--=20
Eduardo


diff -purN linux-2.4.orig/drivers/net/irda/ma600.c linux-2.4/drivers/net/ir=
da/ma600.c
--- linux-2.4.orig/drivers/net/irda/ma600.c	2003-05-22 20:13:14.000000000 -=
0300
+++ linux-2.4/drivers/net/irda/ma600.c	2003-05-22 20:13:14.000000000 -0300
@@ -53,7 +53,7 @@
 	if(!(expr)) { \
 	        printk( "Assertion failed! %s,%s,%s,line=3D%d\n",\
         	#expr,__FILE__,__FUNCTION__,__LINE__); \
-	        ##func}
+	        func}
 #endif
=20
 /* convert hex value to ascii hex */

--lpUp1egui7PDlNtH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zohZcaRJ66w1lWgRApT5AKCJxVM+dSozFaFnNBtHYL/l+m7S9QCfWUaK
nCVAzX23xMAmV40VHKjMAak=
=3kyV
-----END PGP SIGNATURE-----

--lpUp1egui7PDlNtH--
