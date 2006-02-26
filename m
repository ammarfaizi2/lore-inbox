Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWBZPAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBZPAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWBZPAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:00:11 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:55730 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751191AbWBZPAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:00:08 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: woho@woho.de
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200602260957.04305.woho@woho.de>
References: <4400FC28.1060705@gmx.net>
	 <20060225180353.5908c955@localhost.localdomain>
	 <200602260957.04305.woho@woho.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gGwFEbi5+z/ApT70N3Xa"
Date: Sun, 26 Feb 2006 16:00:11 +0100
Message-Id: <1140966011.22812.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gGwFEbi5+z/ApT70N3Xa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-26 at 09:57 +0100, Wolfgang Hoffmann wrote:
> On Sunday 26 February 2006 03:03, Stephen Hemminger wrote:
> > Instead of whining, try this.
>=20
> I tried and still see the hang.

I'm at a record 12 hours with that patch.

> Stephen, if you want me (as suggested off-list) to bisect the individual=20
> patches leading from 0.13a to current head, please give me a series of=20
> patches to incrementally apply, eighter via mail/ftp/git, and I'll test. =
I=20
> don't want to hack the patches together myself, because results would be=20
> worthless if I screw up, and given that I have no networking background=20
> chances are high ...

There is a git bisect for that, and a link for it somewhere =3D)

> It takes me between 5 - 20 GB of data transfer to reproduce the hang, so =
it=20
> will take a while, but I'm willing to help. If you see vendor chip specs=20
> arrive soon and feel it's not worth the hassle, that's fine for me, too.

My last real test with sky2 was at 205gb, which made me think that it's
more of a race and not data dependant (read, 2 boxes doing ping -f -s
8000)...

> In the meanwhile, I'll resort to 0.13a
>=20
> Wolfgang
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-gGwFEbi5+z/ApT70N3Xa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQBEAcJ77F3Euyc51N8RAlTZAKC59pzFoEGmCHMFZaHysbMZZX7zNwCePDan
LC1kIvqBb2qkM6OsnP/n2G8=
=gxHp
-----END PGP SIGNATURE-----

--=-gGwFEbi5+z/ApT70N3Xa--

