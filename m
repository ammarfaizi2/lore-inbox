Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJUH74>; Mon, 21 Oct 2002 03:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJUH74>; Mon, 21 Oct 2002 03:59:56 -0400
Received: from B5064.pppool.de ([213.7.80.100]:29613 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261268AbSJUH7z>; Mon, 21 Oct 2002 03:59:55 -0400
Subject: Re: [PATCH] 2.5.43 : drivers/block/xd.c
From: Daniel Egger <degger@fhm.edu>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0210182055450.15417-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210182055450.15417-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BIWgadaUzpR42fA5bljC"
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Oct 2002 01:33:17 +0200
Message-Id: <1035156808.17725.4.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BIWgadaUzpR42fA5bljC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2002-10-19 um 02.58 schrieb Frank Davis:

> Hello all,
>  The following fixes a 'used but not declared' compile error.  Please rev=
iew=20
> for inclusion.

The "standard" way of achieving the same would be to assign the variable
to itself. In your fragment the compiler will initialise the variable to
zero which will cost at least one instruction and thus "bloat" the code,
it'll also be slower due to an additional instruction and may schedule
worse. Not that it mattered much in this case but if you can save a byte
or two... :)
=20
--=20
Servus,
       Daniel

--=-BIWgadaUzpR42fA5bljC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9sz08chlzsq9KoIYRAt7QAKC289qta/4/b5Hw/wqD+OXdyNAoXQCffCnM
IJyLtXuBsasMm6wUaoWuLcc=
=0vhS
-----END PGP SIGNATURE-----

--=-BIWgadaUzpR42fA5bljC--

