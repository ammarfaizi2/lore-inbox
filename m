Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLVTES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTLVTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:04:18 -0500
Received: from hostmaster.org ([80.110.173.103]:29056 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264477AbTLVTEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:04:12 -0500
Subject: 2.6.0 lockup with de4x5/de2104x driver
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L2iic2XtxToMsHSePMvt"
Message-Id: <1072119837.1383.11.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 20:04:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L2iic2XtxToMsHSePMvt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm successfully using a "Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 11)" with the de4x5 driver under 2.4.23.

Using the same driver the system does however lock up within
milliseconds after bringing up the network interface in 2.6.0.

The de2104x driver primarily seems to fail receiving packets, running
tcpdump I do only see arp-who-has packets beeing transmitted, after some
time I do also get a 'eth0: timeout expired stopping DMA, kernel bug at
drivers/net/tulip/de2104x.c:413!'

Regards
Tom

PS: I'm using a dual Celeron/Abit BP6

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

Everybody wants to go to heaven, but nobody wants to die.

--=-L2iic2XtxToMsHSePMvt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAP+dAF2D1OYqW/8uJAQKNKwf8DRhEYFliF/9HjKPi2YtmAcy9G8ppujoS
+4f16o8VmuQj4DOLFA0IjIQkt9Z0IojWuXBdKytVl45vofEeDm8Dnxa35OFOPsYK
7jgOdrpiangzQx5Y9K9mtHryz4Kg+rFa5smNuDyvOgQJpO7fjn6m4K7oLgDRO/zQ
b0kYKgoDqFP1vfzcp4gSh4EMFfsFbnk2kRXJZX2YMGR2nab4WN3bI8BDWu4g2rAo
iWEUiSe37OuT/z65q9UGFWdoJxYpCkY8y99F5+LwRaFLewGkK5mi8hhnhwtHoziR
qpEDxGGxp8CSs++jgpiLz9CovM/XFnxlvVKxDKaeLAKUyB85xTLIVQ==
=HU3l
-----END PGP SIGNATURE-----

--=-L2iic2XtxToMsHSePMvt--

