Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTJILka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJILka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:40:30 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:36482 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262057AbTJILk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:40:29 -0400
Date: Thu, 9 Oct 2003 13:40:23 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Mark Hounschell <markh@compro.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't build external module against 2.6.0-test6 kernel
Message-ID: <20031009114023.GI4699@actcom.co.il>
References: <3F8544DF.85E7CA81@compro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <3F8544DF.85E7CA81@compro.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2003 at 07:22:07AM -0400, Mark Hounschell wrote:

> I'm trying to build a driver external to the kernel. I'm running 2.6.0-te=
st6
> kernel.
> It appears to me (I'm probably wrong) that there is a kernel include
> file issue.=20
>=20
> gcc -c rtom.c -D__KERNEL__ -DMODULE -DDEBUG -DDEBUG_LEVEL=3D6
> -I/lib/modules/2.6.0-test6/build/include -I../include/linux/sys
> -I../include/linux -I../include -O -o rtom

This compilation command line dos not look like it came from the kerel
build system? If indeed you're using your own build system, please use
the kernel's build system to compile external modules. See
Documentation/kbuild/* for details, as well as lwn.net's "Compling
External Modules" article - http://lwn.net/Articles/21823/. I'm
guessing that you do not have something set up properly that the
kernel's build system would've set up for you.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hUknKRs727/VN8sRAqPjAKC6tAyM0GalQqagTw0XF01iFcOqWwCgglyx
9FKNJNBIlL3Kk+nctMGMlMc=
=G3hM
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
