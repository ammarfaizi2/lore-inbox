Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271137AbRHYVDh>; Sat, 25 Aug 2001 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271149AbRHYVD1>; Sat, 25 Aug 2001 17:03:27 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:6016 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271137AbRHYVDS>; Sat, 25 Aug 2001 17:03:18 -0400
Date: Sat, 25 Aug 2001 16:03:22 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: basic module bug
Message-ID: <20010825160322.A793@draal.physics.wisc.edu>
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu> <200108251122.f7PBMvl17221@www.2ka.mipt.ru> <20010825102756.R21497@draal.physics.wisc.edu> <20010825105645.T21497@draal.physics.wisc.edu> <200108251903.f7PJ3Zl21152@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200108251903.f7PJ3Zl21152@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Sat, Aug 25, 2001 at 11:04:09PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Evgeny Polyakov [johnpol@2ka.mipt.ru] wrote:
> Hello.
>=20
> On Sat, 25 Aug 2001 10:56:45 -0500
> Bob McElrath <mcelrath@draal.physics.wisc.edu> wrote:
>=20
> BM> Where can I find a "skeleton" kernel module for comparison?
>=20
> You wrote it some strins below.

Aha!  It was caused by not passing the right compiler options.  There
are some compiler options (CFLAGS) in arch/{arch}/Makefile that should
be included for modules, and some in the top level Makefile.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuIEpoACgkQjwioWRGe9K3eZACePdt04F4OcVUUPvBBi6Re0DaX
8LUAn1sDtzBad8m6yM2EBGGZREvYyeq+
=LqIc
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
