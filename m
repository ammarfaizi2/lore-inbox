Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTCEAml>; Tue, 4 Mar 2003 19:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTCEAml>; Tue, 4 Mar 2003 19:42:41 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25612 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S266810AbTCEAmk>;
	Tue, 4 Mar 2003 19:42:40 -0500
Date: Wed, 5 Mar 2003 01:53:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_ALPHA_SRM not compiling on 2.5
Message-ID: <20030305005309.GM27794@lug-owl.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <3E6538EF.3060602@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F7w+4yMapWozG0Ib"
Content-Disposition: inline
In-Reply-To: <3E6538EF.3060602@gmx.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--F7w+4yMapWozG0Ib
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-05 00:38:23 +0100, Christian <evilninja@gmx.net>
wrote in message <3E6538EF.3060602@gmx.net>:
> hi,
>=20
> recently i decided to make an Alpha EV45 / Avanti here as a testbed for=
=20
> the latest 2.5 kernels. but it always fails to compile the kernel with
>=20
> CONFIG_ALPHA_SRM=3Dy

> arch/alpha/kernel/built-in.o: In function `common_shutdown_1':
> arch/alpha/kernel/built-in.o(.text+0x2508): undefined reference to=20
> `dummy_con'
> arch/alpha/kernel/built-in.o(.text+0x251c): undefined reference to=20
> `take_over_console'
> arch/alpha/kernel/built-in.o(.text+0x2520): undefined reference to=20
> `take_over_console'
> make: *** [vmlinux] Error 1
> lila:/usr/src/linux-2.5.x#

There seems to be a missing dependency then. Please ensure that you
compile in the input subsystem core as well as virtual terminal support
and support for console on virtual terminal.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--F7w+4yMapWozG0Ib
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZUp1Hb1edYOZ4bsRArVBAJ9suIFpJHSHX916OtkaRBLhciSbfQCeIbP4
D/qCeAM9FqJ6SQ2wvhh459g=
=xve3
-----END PGP SIGNATURE-----

--F7w+4yMapWozG0Ib--
