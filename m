Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRLQRkq>; Mon, 17 Dec 2001 12:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLQRkg>; Mon, 17 Dec 2001 12:40:36 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:16123
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S281794AbRLQRkX>; Mon, 17 Dec 2001 12:40:23 -0500
Date: Mon, 17 Dec 2001 11:40:20 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: nbecker@fred.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why no -march=athlon?
Message-ID: <20011217174020.GA24772@0xd6.org>
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* nbecker@fred.net <nbecker@fred.net> on Mon, Dec 17, 2001:

> I noticed that linux/arch/i386/Makefile says:
>=20
> ifdef CONFIG_MK7
> CFLAGS +=3D -march=3Di686 -malign-functions=3D4=20
> endif
>=20
>=20
> Why not -march=3Dathlon?  Is this just for compatibility with old gcc?

The recommend kernel compiler is gcc 2.95.x, which doesn't support
"-march=3Dathlon".

> If so, can't we fix it with an ifdef?

Can you fix it?  You'd have to parse the output of `gcc -v`, I think
kbuild 2.5 does this, so start there first.

M. R.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8Hi4EaK6pP/GNw0URArqgAKC4uxzsHzmpUxeLaBh9fDUfzRPA/QCgtKWd
nlQfR5kP4wxYSAflLRkG0Cc=
=kRtN
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
