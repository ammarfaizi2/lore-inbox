Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHYP2R>; Sat, 25 Aug 2001 11:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHYP2H>; Sat, 25 Aug 2001 11:28:07 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:34995 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S269421AbRHYP1x>; Sat, 25 Aug 2001 11:27:53 -0400
Date: Sat, 25 Aug 2001 10:27:56 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: basic module bug
Message-ID: <20010825102756.R21497@draal.physics.wisc.edu>
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu> <200108251122.f7PBMvl17221@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200108251122.f7PBMvl17221@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Sat, Aug 25, 2001 at 03:21:39PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Evgeny Polyakov [johnpol@2ka.mipt.ru] wrote:
> Hello.
>=20
> On Sat, 25 Aug 2001 00:59:57 -0500
> Bob McElrath <mcelrath@draal.physics.wisc.edu> wrote:
>=20
> BM> both egcs 2.91.66 and redhat's gcc 2.96-85 barf on it:
>=20
> BM> In file included from /usr/src/linux/include/asm/semaphore.h:11,
> BM> from /usr/src/linux/include/linux/fs.h:198,
> <...>
> BM> used for global register variable
>=20
> BM> What have I done wrong?
>=20
> How do you compile this module?
> I've just trying to do this with the following command and all is OK:
> gcc ./test.c -c -o ./test.o -D__KERNEL__ -DMODULE.

That's because if you -D__KERNEL__ the whole file is ifdef'ed out.  ;)

Remove the #ifdef __KERNEL__ stuff if you want to compile it that way.

> BM> Thanks,
> BM> -- Bob
>=20
> ---
> WBR. //s0mbre
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuHw/wACgkQjwioWRGe9K21gwCgwk9x9s2Y/oSNJihOuZ1Z1pMn
EY4AoP49Nr6uDmiTSzytQLlEsEgWkRzu
=eQW/
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--
