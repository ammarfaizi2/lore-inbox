Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRLSR4m>; Wed, 19 Dec 2001 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280638AbRLSR4d>; Wed, 19 Dec 2001 12:56:33 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:8184
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S280426AbRLSR4S>; Wed, 19 Dec 2001 12:56:18 -0500
Date: Wed, 19 Dec 2001 11:56:16 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Benoit Poulot-Cazajous <poulot@ifrance.com>
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
Message-ID: <20011219175616.GD19236@0xd6.org>
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org> <lnitb3drx6.fsf_-_@walhalla.agaha>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <lnitb3drx6.fsf_-_@walhalla.agaha>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Benoit Poulot-Cazajous <poulot@ifrance.com> on Wed, Dec 19, 2001:

>=20
> But gcc-2.95,x _supports_ "-march=3Dk6", and we should use that instead of
> "-march-i686".
>=20

No, k6 !=3D athlon.  IIRC, the i686 optimization is closer to the Athlon th=
an
the k6 opt.

>=20
> before the patch :
> 1017.92user 261.80system 24:39.89elapsed 86%CPU
> 706.33user 160.79system 16:23.61elapsed 88%CPU
> 1787.38user 418.76system 43:35.97elapsed 84%CPU
>=20
> after the patch :
> 1018.42user 253.85system 24:44.68elapsed 85%CPU
> 704.89user 151.76system 16:16.14elapsed 87%CPU
> 1786.96user 410.76system 43:05.32elapsed 85%CPU
>=20
> The improvement in system time is nice.
>=20

Er, there's not much difference...

Curious, what happens when you compile using gcc 3.0.1 against
-march=3Dathlon?

M. R.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8INTAaK6pP/GNw0URAqrLAJ4h/KAqf1MzdXNnAHOikrQkWsqOSwCfSEGB
j65gJwFKLdnnUya2s4uFnkM=
=Aq3h
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
