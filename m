Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUBNVqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 16:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUBNVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 16:46:40 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:63648 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262687AbUBNVqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 16:46:37 -0500
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>, linux-kernel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
In-Reply-To: <200402141124.50880.ross@datscreative.com.au>
References: <200402120122.06362.ross@datscreative.com.au>
	 <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au>
	 <200402141124.50880.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qhL4O+M94tW6Qps768DW"
Message-Id: <1076795196.3659.5.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 22:46:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qhL4O+M94tW6Qps768DW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-02-14 at 02:24, Ross Dickson wrote:
> On Saturday 14 February 2004 00:41, Ross Dickson wrote:
> Found the problem for 2.6
>=20
> After fixing it the 2.6 temperature is
> Patched Linux 2.6.3-rc1-mm1, 38C
> Ambient today is 1C cooler also.
>=20
> The fix is to put the brackets back on "!need_resched()"  so that we call
> the function and test its return value - not just test the function point=
er!

Seems to work just great here... I also did some testing before i
applied it.

I tested Uberbios for my mb, but it didn't help at all, actually it
seemed quite odd... (Strange values etc)

Now i'm back to normal bios and running Ross' quality work again! =3D)

Keep up the good work guys, seems like the trade off is getting smaller
and smaller =3D). Btw, uptime before i decided that i should update kernel
was 17 days (haven't had any nforce in quite some time when running
ross' quality work, so the uptime more reflects my eagerness to update
kernels and stuff)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-qhL4O+M94tW6Qps768DW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBALpc67F3Euyc51N8RAtRFAJ0RC25a6S/hczEcij5rbLNiD8PEiwCfRahU
57cEORQ5M9bTGYrUrfHfpFc=
=Zhcm
-----END PGP SIGNATURE-----

--=-qhL4O+M94tW6Qps768DW--

