Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTK3SMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTK3SMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:12:15 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:22206
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S262491AbTK3SML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:12:11 -0500
Subject: Re: NForce2 pseudoscience stability testing (general)
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Kumlien <pomac@vapor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-csIVKcC3k3HCLAU1rnpx"
Message-Id: <1070215929.12640.8.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 30 Nov 2003 19:12:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-csIVKcC3k3HCLAU1rnpx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I also have a nforce2 mb (a7n8x-x). And i have also seen the same
lockups, but, while NOT USING the amd/nvidia driver i had some not as
bad experiences... It did lockup for 30 seconds or so at a time but it
always come back and when doing dmesg i had constant statements about
lost interrupts.

And to quote Craig Bradney:
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.

This was the first time i saw that, i doubt it's in 2.4 and i bet that
it's related. Imho it could be the amd/nvidia driver not handling the
lost interrupt as nicely as the "Unified E-IDE" driver.
(Since thats the only difference between complete deadlock and stalling
for XX seconds)

Or is this apic workaround in 2.4.23 (the only kernel i have tested on
this mb)?

This is just how i see it, I had hoped that someone would have shared my
view... =3DP

CC, Since i'm not on this ml... And, Comments please.

--=20
Ian Kumlien <pomac@vapor.com>

--=-csIVKcC3k3HCLAU1rnpx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/yjL57F3Euyc51N8RAjx4AJ9nQppltyzZJyL2qw9w/RJZXxsyIwCdED+G
6+O5XFxm/Zb7Il/W6qrqrhE=
=rhwQ
-----END PGP SIGNATURE-----

--=-csIVKcC3k3HCLAU1rnpx--

