Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbTILPBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTILPBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:01:14 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:43003 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261721AbTILPBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:01:06 -0400
Date: Fri, 12 Sep 2003 08:01:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hal <pshbro@open.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: missing config options in 2.6.0-test5-bk1 arch PPC
Message-ID: <20030912150104.GD13672@ip68-0-152-218.tc.ph.cox.net>
References: <3F5A001F.10509@open.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <3F5A001F.10509@open.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 06, 2003 at 08:41:19AM -0700, Hal wrote:
> [1] arch/ppc/platforms/mpc82xx.h: platforms/willow.h not found.
>=20
> [2]
>=20
> In arch/ppc/platforms/mpc82xx.h line 33 platforms/willow.h is included.=
=20
> This file does not exist.
>=20
> [3] arch/ppc/kernel/asm-offsets.s include/asm/io.h include/asm/mpc8260.h=
=20
> platforms/willow.h
>=20
> [4] 2.6.0-test5-bk1
>=20
> [5]
>=20
>  CC      arch/ppc/kernel/asm-offsets.s
>  In file included from include/asm/mpc8260.h:12,
>      from include/asm/io.h:32,
>      from arch/ppc/kernel/asm-offsets.c:21:
>  arch/ppc/platforms/mpc82xx.h:33:30: platforms/willow.h: No such file=20
> or directory
>  make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
>  make: *** [arch/ppc/kernel/asm-offsets.s] Error 2
>=20
> [6] make allyesconfig; make

The notion of 'allyesconfig' is broken on PPC, IMHO.  If you want to try
test compiling a number of drivers, do this, followed by whichever
config target you normally do, and build for a pmac, or whatever
hardware you actually have.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Yd+wdZngf2G4WwMRAlFUAJ99jVyrHLENsAcoBhA6xWINBm1yWACeIDE3
RZkkTiojILtLELFv3phoqV4=
=Sfw3
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
