Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbSIYNxe>; Wed, 25 Sep 2002 09:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261982AbSIYNxe>; Wed, 25 Sep 2002 09:53:34 -0400
Received: from B5694.pppool.de ([213.7.86.148]:1770 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261981AbSIYNxe>; Wed, 25 Sep 2002 09:53:34 -0400
Subject: Re: [PATCH] streq()
From: Daniel Egger <degger@fhm.edu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020925124536.A6083@flint.arm.linux.org.uk>
References: <20020924045313.0FBE52C075@lists.samba.org>
	<1032953252.18004.18.camel@sonja.de.interearth.com> 
	<20020925124536.A6083@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-l2yCg05z67np/LXnFb9H"
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Sep 2002 14:38:32 +0200
Message-Id: <1032957513.18004.66.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l2yCg05z67np/LXnFb9H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2002-09-25 um 13.45 schrieb Russell King:

> Small problem - you need to find the length first.  Which means you need
> to scan each string, and use the smaller.

In most cases one of the strings is constant and thus the length known=20
at compiletime. I have no idea whether we are allowed (in kernel space)
to read beyond the end of a string, iff we are we could simply use the
fixed length.

> Wouldn't it be faster just to iterate over both strings at the same time
> only once?

Time has shown that the obvious solution is often not the fastest one.
:) Though in this case it really might be.=20

--=20
Servus,
       Daniel

--=-l2yCg05z67np/LXnFb9H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ka5Ichlzsq9KoIYRAqHZAJ9W7PfHm19uiDVqO57E5Lb3P0v+MgCeIeeG
HhMGxhcHhomFvg7LvbrC1as=
=9/DY
-----END PGP SIGNATURE-----

--=-l2yCg05z67np/LXnFb9H--

