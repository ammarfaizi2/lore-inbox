Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280921AbRKLSue>; Mon, 12 Nov 2001 13:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280923AbRKLSuX>; Mon, 12 Nov 2001 13:50:23 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:26320 "HELO
	rhlx01.fht-esslingen.de") by vger.kernel.org with SMTP
	id <S280921AbRKLSuI>; Mon, 12 Nov 2001 13:50:08 -0500
Subject: Re: [PATCH] VIA timer fix was removed?
From: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011112140530.A23866@socrates>
In-Reply-To: <20011112111409.A2617@socrates>
	<200111121448.PAA01060@green.mif.pg.gda.pl> 
	<20011112140530.A23866@socrates>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-AmOQaAbt383TNeRZ7ZEa"
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 12 Nov 2001 19:49:14 +0100
Message-Id: <1005590954.23106.1.camel@wombat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AmOQaAbt383TNeRZ7ZEa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2001-11-12 at 17:05, Jeronimo Pellegrini wrote:
> On Mon, Nov 12, 2001 at 03:48:24PM +0100, Andrzej Krzysztofowicz wrote:
> > > The following patch (introduced by Vojtech Pavlik some time ago) was
> > > removed somewhere between 2.4.14 and 2.4.15-pre3.
> > > Without it, the timer counter is reset to a wrong value and
> > > gettimeofday() starts to return strange values
> > >=20
> > > Nothing aboutit is mentioned in the changelog, so I suppose it wasn't
> > > supposed to be removed?
> >=20
> > Maybe, it happens because somebody forgot to comment why this code is
> > necessary here ?
> > Just a guess...
>=20
> Then perhaps this would be a good idea?

I have seen IBM machines (Netfinity 6000R) where this code got triggered
even though they didn't have VIA chipsets/timers. Seems to have caused
some problems there and I removed the code (in the custom kernel running
on those machines).

Nils
--=20
 Nils Philippsen / Berliner Stra=DFe 39 / D-71229 Leonberg //
+49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@redhat.de /
nils@fht-esslingen.de
        Ever noticed that common sense isn't really all that common?

--=-AmOQaAbt383TNeRZ7ZEa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA78BmpR9ibZWlRMBERAkz1AKCE6zRpfV0MjQ+Rbs12hjesMlYwSgCgkStT
C+ntgIkJKDMsKEopH8T9EQU=
=VJnu
-----END PGP SIGNATURE-----

--=-AmOQaAbt383TNeRZ7ZEa--

