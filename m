Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278338AbRJMSG1>; Sat, 13 Oct 2001 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278339AbRJMSGQ>; Sat, 13 Oct 2001 14:06:16 -0400
Received: from grip.panax.com ([63.163.40.2]:22543 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278338AbRJMSGM>;
	Sat, 13 Oct 2001 14:06:12 -0400
Date: Sat, 13 Oct 2001 14:06:38 -0400
From: Patrick McFarland <unknown@panax.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: [unknown@panax.com: Re: Which is better at vm, and why? 2.2 or 2.4]
Message-ID: <20011013140638.J249@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heh, well 2.2 actually could get away with it. I think I remember seeing th=
e system size (reported by make bzimage) to me 2 megs vs 2.4's 4 megs. Or m=
aybe I'm just imagining things.

On 13-Oct-2001, Mark Hahn wrote:
> > Now, the great kernel hacker, ac, said that 2.2 is better at vm in low
> > memory situations than 2.4 is. Why is this? Why hasnt someone fixed the=
 2.4
> > code?=20
>=20
> not to slight TGKH AC, but he's also the 2.2 maintainer; perhaps there's=
=20
> some paternal protectiveness there ;)
>=20
> my test for VM is to compile a kernel on my crappy old BP6 with mem=3D64m;
> I use a dedicated partition with a fresh ext2, unpack the same source tre=
e,
> make -j2 7 times, drop 1 outlier, and average:
>=20
> 2.2.19: 584.462user 57.492system 385.112elapsed 166.5%CPU
> 2.4.12: 582.318user 40.535system 337.093elapsed 184.5%CPU
>=20
> notice that elapsed is noticably faster even than the 1+17 second
> benefit to user and system times.  Rik's VM seems to be slightly
> slower on this test.  with 128M, there's much less diference for=20
> any of the versions (and I don't have the patience for <64M.)
>=20
> regards, mark hahn.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Patrick "Diablo-D3" McFarland || unknown@panax.com

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7yIKt8Gvouk7G1cURAimxAJ43sph0LgA9teLOoA006xDoeyIs7QCfcECQ
gy/d7ffCOQz/72dgXff5ft0=
=edA4
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
