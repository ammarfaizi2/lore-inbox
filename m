Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTGONYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGONYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:24:20 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:3334 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267378AbTGONYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:24:12 -0400
Subject: Re: mis-identified cisco aironet pccard (and Re: hang with pcmcia
	wlan card)
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Russell King <rmk@arm.linux.org.uk>
Cc: jt@hpl.hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
In-Reply-To: <20030714175243.B1076@flint.arm.linux.org.uk>
References: <1058100731.778.5.camel@localhost>
	 <20030714164852.GC22238@bougret.hpl.hp.com>
	 <20030714175243.B1076@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lDiPDtloqfYafFyM2B5c"
Message-Id: <1058275220.758.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 23:20:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lDiPDtloqfYafFyM2B5c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-15 at 02:52, Russell King wrote:
> On Mon, Jul 14, 2003 at 09:48:52AM -0700, Jean Tourrilhes wrote:
> > On Sun, Jul 13, 2003 at 10:57:58PM +1000, Sven Dowideit wrote:
> > > Hi,
> > > i just noticed with 2.5.75 that if I boot with the cisco airo 340 wif=
i
> > > card in, this kernel thinks it is a memory card. when i remove it and
> > > re-insert it after boot, it then works .... see the following log :) =
I
> > > am running debian unstable, on an ibm t21 pIII-850 notebook
> > >=20
> > > the cisco card works at boot time using 2.5.70.
> > >=20
> > > as for the two patches for the pcmcia hang, this time i am running th=
e
> > > one Russell posted, but the result is the same for the other.
> > >=20
> > > as i shutdown i get a number of kernel stack dumps related to airo_st=
at,
> > > but the machine reboots before i can do anything about them..(what do=
 i
> > > need to log them?)
> > >=20
> > > if i replace the cisco card with a dlink orinoco card, it get recogni=
sed
> > > correctly at boot.=20
> > >=20
> > > to make this story more interesting, i put the thinkpad into the dock=
ing
> > > station and the cisco card into the dock's pccard (something that has
> > > locked up 2.5 every time that i tried it), and the card is recogised
> > > correctly at boot, and runs fine (there was a kernel stack dump durin=
g
> > > boot - *what do i need to do to get them logged?*)
> > >=20
> > > thanks for the great work!
> > >=20
> > > sven
> >=20
> > 	I've seen this bug come and go in the 2.5.X serie. I believe
> > this is because of the various work happening in the Pcmcia
> > layer. Please contact Dominik Brodowski <linux@brodo.de>.
>=20
> I think this may be my fault, but I haven't head a clear bug report for
> it yet; I've only seen vague references to something going wrong with
> aero cards on lkml yesterday, referring to what seemed to be a non-
> existent thread.

okely, for me it happened for the first time between 2.5.70 and
2.6-test1. and now its every time :) what can i send you that will help,
or, what do i need to figure it out.

cheers

sven

--=-lDiPDtloqfYafFyM2B5c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/E/+UPAwzu0QrW+kRAhZcAKCHNMwe5zb1/kETx2ja3a+xk1ukOgCgkDl9
J+JIt+68m25t6Xf0sSfZF3o=
=D1A2
-----END PGP SIGNATURE-----

--=-lDiPDtloqfYafFyM2B5c--

