Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUDNH3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbUDNH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:29:45 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:50333 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263944AbUDNH3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:29:34 -0400
Date: Wed, 14 Apr 2004 09:29:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Add missing newline
Message-ID: <20040414072933.GM630@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JlJsEFsx9RQyiX4C"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JlJsEFsx9RQyiX4C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew/Linus!

Please add this missing \n:

--- linux-2.6.5/arch/i386/kernel/timers/timer_tsc.c~	2004-04-14 09:05:24.00=
0000000 +0200
+++ linux-2.6.5/arch/i386/kernel/timers/timer_tsc.c	2004-04-14 09:06:04.000=
000000 +0200
@@ -232,7 +232,7 @@
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
 			printk(KERN_WARNING "Losing too many ticks!\n");
-			printk(KERN_WARNING "TSC cannot be used as a timesource.  ");
+			printk(KERN_WARNING "TSC cannot be used as a timesource.\n");
 			printk(KERN_WARNING "Possible reasons for this are:\n");
 			printk(KERN_WARNING "  You're running with Speedstep,\n");
 			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (s=
ee hdparm),\n");

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--JlJsEFsx9RQyiX4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfOhdHb1edYOZ4bsRAi7rAJ9oSs0Yg6rkt0Scn7DMLE0gRM1APwCdFG+3
DGxwOjfOUzSzzYkUpLUuvXc=
=BZGx
-----END PGP SIGNATURE-----

--JlJsEFsx9RQyiX4C--
