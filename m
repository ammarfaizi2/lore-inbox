Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTIYMLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTIYMLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:11:46 -0400
Received: from smtp2.clb.oleane.net ([213.56.31.18]:2196 "EHLO
	smtp2.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261176AbTIYMLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:11:44 -0400
Subject: Re: PS2 keyboard & mice mandatory again ?
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20030925111547.GL15696@fs.tum.de>
References: <1064428364.1673.11.camel@rousalka.dyndns.org>
	 <20030925074656.GA22543@ucw.cz>
	 <1064477341.13077.7.camel@ulysse.olympe.o2t>
	 <20030925111547.GL15696@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WTseRVeZolko6pH3C4xe"
Organization: Adresse personelle
Message-Id: <1064491863.17990.10.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Thu, 25 Sep 2003 14:11:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WTseRVeZolko6pH3C4xe
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le jeu 25/09/2003 =E0 13:15, Adrian Bunk a =E9crit :
> On Thu, Sep 25, 2003 at 10:11:45AM +0200, Nicolas Mailhot wrote:
> >=20
> > Great, now a standard mass-market computer is an embedded device. I can
> > (and will) certainly do it, but this looks like a ticking bomb to me.
> >...
>=20
> What does it cost if an unneeded driver is included in your kernel?=20
> Perhaps a few kB?

And all the bugs of the unneeded driver.
I didn't notice this because I have the habit to run diff between my old
and new config. I noticed it because on 2.6.0-test-bk9 or 10 I had my
boot logs full of warnings associated to PS/2 input.

The less things I have to worry about the better I sleep. That's why I
only build EHCI on my kernel and plug all USB1 devices in an external
USB2 hub.

The next "obvious" step is to make serial, parallel, floppy, ide and
vesa drivers mandatory since most people have this kind of harware. How
would _you_ like that ?

Cheers,

--=20
Nicolas Mailhot

--=-WTseRVeZolko6pH3C4xe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/cttWI2bVKDsp8g0RAnzuAJ9Bbng3apFqNiphaxPdQnsnqEwZYACePt+i
pVigvd/ERKZVCnyb6eb/4S8=
=fX0w
-----END PGP SIGNATURE-----

--=-WTseRVeZolko6pH3C4xe--

