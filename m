Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312372AbSCZQ47>; Tue, 26 Mar 2002 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312477AbSCZQ4t>; Tue, 26 Mar 2002 11:56:49 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:31134 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312372AbSCZQ4m>; Tue, 26 Mar 2002 11:56:42 -0500
Date: Tue, 26 Mar 2002 11:56:20 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Andrew Morton <akpm@zip.com.au>
Cc: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020326165619.GB10880@localhost>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9FC76F.6050900@mandrakesoft.com> <20020326014050.GP1853@ufies.org> <3C9FF4B3.3070408@mandrakesoft.com> <20020326043943.GR1853@ufies.org> <3C9FFE1E.F9F766FF@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 08:50:38PM -0800, Andrew Morton wrote:
> I've added three new module options:
>=20
> 	global_enable_wol=3DN
> 	global_options=3DN
> 	global_full_duplex=3DN
>=20
> If you set one of these, they apply to all 3c59x NICs
> in the machine.  If you also set an entry in the corresponding
> array, that will override the global_* option.
>=20
> How does that sound?

A different fix. Which in my case is enough (as was the previous one).

> Oh look, it compiled :)  Wanna test it?

Applied, Compiled, Tested.
<marcelo> Hope to see it in 2.4.19. </marcelo>

Andrew would you be interested in a patch to ethtoolize this driver ?
Has ethtool a futur in the next kernel serie ?

Thank you,
Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats are rather delicate creatures and they are subject to a good
many ailments, but I never heard of one who suffered from insomnia.
--Joseph Wood Krutch

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8oKgzj0UvHtcstB4RAib3AKCSoqVZHQy/SBh5xABykFr8t99kVwCdHos4
NJd3/xijpfnN4ljMfZfA/M4=
=gpIU
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
