Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTEEGTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTEEGTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:19:24 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:26284 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S261968AbTEEGTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:19:22 -0400
Subject: Re: Linux 2.5.69
From: Anders Karlsson <anders@trudheim.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jYpfOAl+oT1p26LERghR"
Organization: Trudheim Technology Limited
Message-Id: <1052116306.31300.50.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 05 May 2003 07:31:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jYpfOAl+oT1p26LERghR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-05 at 05:41, Linus Torvalds wrote:

> Make sure to also test with regular 1x AGP (and no fast write stuff etc).=
=20
> A lot of motherboards really aren't going to like 4x and some other=20
> settings (in particular, enabling fast writes seems to be a very iffy=20
> proposition indeed).

Will try that in case that fixes the problems I see.

> Also, check if the same setup is stable under 2.4.x and possibly using th=
e
> DRI CVS tree. Radeon in particular seems to be a lot stabler in DRI these=
=20
> days than it has historically been.
>=20
> Indeed, one of the reasons it took me so long to figure out the stability
> issues I saw was simply that there have been real bugs in direct
> rendering, and I was blaming them instead and I spent a lot of time tryin=
g=20
> to chase down the bug as an AGP or DRI issue.

Would you think that the problems I have been seeing with a Radeon
Mobility LY on kernel 2.4.2[01] could be down to exactly these issues as
well?

The problems are that the X server can be started only once and that
there seems to be a chance of it locking the machine hard at start after
that, especially after unloading the radeon.o module.

I will do more testing on that to find out exactly what does what, but
would 2.5.69 be a good test to see what has been fixed?

Regards,

/Anders

--=-jYpfOAl+oT1p26LERghR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+tgVRLYywqksgYBoRAvO4AJ9vxF/XBrYeX7v8KtpGyaymwbdEmwCgpQ4M
tg+TT7cRjQ64uoN7uz4/VNY=
=HYsh
-----END PGP SIGNATURE-----

--=-jYpfOAl+oT1p26LERghR--

