Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285308AbRLSOym>; Wed, 19 Dec 2001 09:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLSOyd>; Wed, 19 Dec 2001 09:54:33 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:32009 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S285308AbRLSOyO>;
	Wed, 19 Dec 2001 09:54:14 -0500
Date: Thu, 20 Dec 2001 17:57:53 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Petr Kulhavy <brain@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with GUS PnP: ad1848, pnp
Message-ID: <20011220175753.A277@pazke.ipt>
In-Reply-To: <20011220104657.A195@pazke.ipt> <Pine.LNX.3.96.1011219111521.11868A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.3.96.1011219111521.11868A-100000@artax.karlin.mff.cuni.cz>; from brain@artax.karlin.mff.cuni.cz on Wed, Dec 19, 2001 at 11:25:22AM +0100
X-Uname: Linux pazke 2.5.1-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2001 at 11:25:22AM +0100, Petr Kulhavy wrote:
> On Thu, 20 Dec 2001, Andrey Panin wrote:
>=20
> > First, don't mix isapnptools and kernel level ISAPNP support.
>=20
> Why? Both should set card parameters, shouldn't they? And when one sets
> parameters, the second should be able to read them (and read the same
> values).

They both touch hardware at the same time and ISA PnP handling isn't simple.

>=20
> > Second, send a copy of /proc/isapnp to lkml, may be we can add isapnp
> > support for your card.
>=20
> OK. But how do I learn if my card is supported or not?

IIRC, Gravis Ultrasound PnP listed as supported in Hardware Compatibility=
=20
HOWTO, but it can lack ISA PnP configuration support. So send us a copy
of /proc/isapnp anyway :))

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8IfxxBm4rlNOo3YgRAnBvAJ9/G783M9toruNSE8pdvSR62CKDhwCghH08
VKF44VeY3z33nokztPORi6A=
=zFHm
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
