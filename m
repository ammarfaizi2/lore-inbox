Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbUKVUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUKVUGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUKVUGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:06:41 -0500
Received: from panda.sul.com.br ([200.219.150.4]:52228 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262568AbUKVTzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:55:25 -0500
Date: Mon, 22 Nov 2004 17:55:15 -0200
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Micah Dowty <micah@navi.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Force feedback support for uinput
Message-ID: <20041122195515.GF24080@cathedrallabs.org>
References: <20041110163751.GA13361@navi.cx> <20041112120852.GA25736@cefetpr.br> <20041121085452.GA26087@navi.cx> <20041122103801.GC24080@cathedrallabs.org> <20041122194751.GA30536@navi.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uK5R2a4OYMA55GL9"
Content-Disposition: inline
In-Reply-To: <20041122194751.GA30536@navi.cx>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uK5R2a4OYMA55GL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Nov 22, 2004 at 08:38:01AM -0200, Aristeu Sergio Rozanski Filho w=
rote:
> > > +The uinput driver creates a character device, usually at /dev/uinput=
, that can
> > the default is '/dev/input/uinput'
>=20
> Really? I haven't tried udev yet (shamefully enough) but with devfs at le=
ast
> it shows up as /dev/misc/uinput with a symlink at /dev/uinput.
>=20
> If it really can be either /dev/uinput or /dev/input/uinput, I guess the =
document
> and some of my userspace code needs modifying ;)
well, at least I think everything related to input subsystem should be
inside /dev/input/ and I always did so because it seems more logical.
I guess udev is also using /dev/input/uinput, but I'm not sure.
As soon I finish some user space stuff I'm working on I'll add more
documentation on uinput.txt and check devfs and udev.

--=20
Aristeu


--uK5R2a4OYMA55GL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBokQjRRJOudsVYbMRAi0UAJ9pjw0FiehRuva5IG/uvadruHjDewCdHELW
USjyoeCm6wqWs8oGQr++xeA=
=PRrh
-----END PGP SIGNATURE-----

--uK5R2a4OYMA55GL9--
