Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUFSQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUFSQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFSQI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:08:56 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:22967 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264103AbUFSQIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:08:50 -0400
Subject: Re: [sundance] Known problems?
From: Ian Kumlien <pomac@vapor.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D46220.9030806@tomt.net>
References: <1087650302.2971.44.camel@big>  <40D43E26.7060207@tomt.net>
	 <1087651887.2971.47.camel@big>  <40D46220.9030806@tomt.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DciPgZ+YKmcsMIXCnmva"
Message-Id: <1087661289.2971.55.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 18:08:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DciPgZ+YKmcsMIXCnmva
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 at 17:56, Andre Tomt wrote:
> Ian Kumlien wrote:
> > On Sat, 2004-06-19 at 15:22, Andre Tomt wrote:
> >>FYI;
> >>
> >>Other than beeing a slow card with mmio-bugs, the only problems I have=20
> >>had with that card was when having a kernel patched with the now defunc=
t=20
> >>and buggy IMQ. Problems were identical.
> >=20
> > Yeah i know about the MMIO bit, but i never had this problem before...
> > Even when loading it with full 100mbit bw (but that was on 2.4).
>=20
> I have not used the card since around 2.6.4, but it worked fine back=20
> then. Did some performance testing on it, with high data and packets/s=20
> rates, so it did get a fair amount of beating.

Yeah, I noticed when testing that it is when you make use of fullduplex
that the driver goes all ape. Ie, the report i sent was about 1mb/s up
and the rest down of the total 5.5 mb/s.

> > Can't it be to paranoid watchdog timings?
> > (Btw, what is IMO, I'd think it meant 'in my opinion' but, heh =3D))
>=20
> Not IMO, IMQ, Q as in q ;-)

Ack, =3D)

> If you don't know what it is, you most likely aren't using it. I'm not=20
> avare of any distributions having it applied. It's used for combinding=20
> several network packet queues into one for example.

Which might help the case that i saw... Is it avail from somewhere?

My main problem is that enough of these watchdog thingies and i have
reboot the machine to reinit the hw. (ie, hw is constantly down no
matter what you do... )

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-DciPgZ+YKmcsMIXCnmva
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1GTp7F3Euyc51N8RApYmAJ0V7OG3n69bg7OGYFHn9rIwB0P+fwCglOlS
K6xuW+gFh5IICv4uuCPzraM=
=BFTW
-----END PGP SIGNATURE-----

--=-DciPgZ+YKmcsMIXCnmva--

