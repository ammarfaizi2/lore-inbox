Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUHYO0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUHYO0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUHYO0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:26:40 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29639 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265770AbUHYOZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:25:57 -0400
Date: Wed, 25 Aug 2004 16:25:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] lkkbd: "DB9" plugs are called "DE9", really!
Message-ID: <20040825142556.GA18334@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RacQGezy2Y99S6cT"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RacQGezy2Y99S6cT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this patch. It corrects the the wrong use of "DB9" to the
correct name, "DE9".

Signed-Off-By: Jan-Benedict Glaw <jbglaw@lug-owl.de>


--- linux-2.6.9-rc1-bk1/drivers/input/keyboard/lkkbd.c~	2004-08-25 16:07:18=
=2E000000000 +0200
+++ linux-2.6.9-rc1-bk1/drivers/input/keyboard/lkkbd.c	2004-08-25 16:07:45.=
000000000 +0200
@@ -14,13 +14,13 @@
  * DISCLAIMER: This works for _me_. If you break anything by using the
  * information given below, I will _not_ be liable!
  *
- * RJ11 pinout:		To DB9:		Or DB25:
+ * RJ11 pinout:		To DE9:		Or DB25:
  * 	1 - RxD <---->	Pin 3 (TxD) <->	Pin 2 (TxD)
  * 	2 - GND <---->	Pin 5 (GND) <->	Pin 7 (GND)
  * 	4 - TxD <---->	Pin 2 (RxD) <->	Pin 3 (RxD)
- * 	3 - +12V (from HDD drive connector), DON'T connect to DB9 or DB25!!!
+ * 	3 - +12V (from HDD drive connector), DON'T connect to DE9 or DB25!!!
  *
- * Pin numbers for DB9 and DB25 are noted on the plug (quite small:). For
+ * Pin numbers for DE9 and DB25 are noted on the plug (quite small:). For
  * RJ11, it's like this:
  *
  *      __=3D__	Hold the plug in front of you, cable downwards,
--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--RacQGezy2Y99S6cT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLKF0Hb1edYOZ4bsRAoscAKCRzz9JSInkwSXOmoiZ4W3vgYLWXgCfUTDH
pHGnY2of3fwsrZfKd1Yx9N4=
=MuQL
-----END PGP SIGNATURE-----

--RacQGezy2Y99S6cT--
