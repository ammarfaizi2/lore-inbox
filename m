Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTLFCIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLFCIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:08:05 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:52111
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264925AbTLFCIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:08:02 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: cbradney@zip.com.au
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1K2Br9upLstkIEixaih9"
Message-Id: <1070676480.1989.15.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 03:08:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1K2Br9upLstkIEixaih9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Craig Bradney wrote:
> All the interrupts are the same...except:
> 0, timer is now IO-APIC-edge.

Same here...=20

> Im not getting any NMI counts.. should I use nmi-watchdog=3D1?

I got nmi counts with nmi_watchdog=3D2...  I never tested with =3D1... if
you get nmi's 1 lemme know.

> Ian, from looking back, you have an A7N8X-X bios 1007.
> Interesting that my USB hcis are still sharing IRQs there.

Your? i only see one... But you share it with sound and eth0...=20

> Any idea how I can get them apart, or if I should try.

You could always move eth0 to a different slot. Other than that, you can
do manual config for the irq's in the bios, but it shouldn't be
needed...

> My system was pretty stable as I've stated.. but the patch has changed
> things slightly re the timer.

As i stated in my prev email, i had to do 2 full greps at a sizable
amount of data to recreate the crash... =3DP

And, please CC since i'm not on this ml =3DP
--=20
Ian Kumlien <pomac@vapor.com>

--=-1K2Br9upLstkIEixaih9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0ToA7F3Euyc51N8RAsswAKClVWZcd2uJ7edrkNiRnE0FJUZKBwCdEtqt
rFuhyzzB1E2WwLWzOzytHvc=
=sUwj
-----END PGP SIGNATURE-----

--=-1K2Br9upLstkIEixaih9--

