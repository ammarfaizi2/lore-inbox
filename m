Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277704AbRJRNc6>; Thu, 18 Oct 2001 09:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277710AbRJRNci>; Thu, 18 Oct 2001 09:32:38 -0400
Received: from adsl-64-109-204-69.milwaukee.wi.ameritech.net ([64.109.204.69]:16378
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S277704AbRJRNc1>; Thu, 18 Oct 2001 09:32:27 -0400
Date: Thu, 18 Oct 2001 08:32:44 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: pierre@lineo.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
Message-ID: <20011018083244.G22296@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com> <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3BCDF89C.32916516@lineo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <3BCDF89C.32916516@lineo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* pierre@lineo.com <pierre@lineo.com> on Wed, Oct 17, 2001:

>=20
> I can make a kernel driver that compiles statically
> and also uses a non-GPL library, even in the form of
> a binary .o file, and the "tainted" mechanism as it
> is today will miss it entirely.
>=20

Statically into the kernel?  I don't think so.  First off, if your "static"
code isn't GPL'd you can't distribute the resultant kernel since you've
violated the GPL.  The tainted mechanism was designed for proprietary
and/or binary-only modules without a supported license.  The case you
mention above can't even exist (at least, not in any publically-accessible
code).

M. R.

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7ztn8aK6pP/GNw0URAr4nAJ9D4KptBKPSiUFNDjbKbqR7OaiN5QCeOfoW
tpj7QKxQGq/qtb+sepGAfzE=
=zbyq
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
