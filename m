Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUAEVKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUAEVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:10:09 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:53174 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265164AbUAEVJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:09:58 -0500
Subject: Re: linux-2.4.24 released
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040105190619.GD10569@fs.tum.de>
References: <200401051355.i05DtvgC020415@hera.kernel.org>
	 <1073321792.21338.2.camel@midux> <20040105171843.GA2407@alpha.home.local>
	 <1073324505.21338.11.camel@midux>  <20040105190619.GD10569@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E7H0I0AwBnao63cuBD9/"
Message-Id: <1073336935.21983.4.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 23:08:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E7H0I0AwBnao63cuBD9/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 21:06, Adrian Bunk wrote:
> Please you doublecheck whether the following really fails for you:
>=20
>   cd linux-2.4.24
>   mv .config /tmp
>   cd ..
>   rm -rf linux-2.4.24
>   tar xzf linux-2.4.24.tar.gz
>   cd linux-2.4.24
>   mv /tmp/.config .
>   make oldconfig
>   make dep
>   make bzImage
>   make modules
>   make modules_install
>=20
Tested that already, my bet is that debian sarge has something broken.
Well, actually this is what I used:
cd /usr/src
cp linux-2.4.24/.config .
rm -rvf /linux-2.4.24
tar xjf linux-2.4.24.tar.bz2
cd linux-2.4.24
cp ../.config .
make oldconfig
time sh -c "make dep && make bzImage && make modules && make
modules_install"

I'll try to do it once again when I get time/acces to the box.

Thanks all,
Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-E7H0I0AwBnao63cuBD9/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+dJn3+NhIWS1JHARApUuAJ9oOBSipiL8adGzGrgkwkQD4fCWQQCgzMP+
3NEC53ritQxfiSr2WyFYZLs=
=UnG6
-----END PGP SIGNATURE-----

--=-E7H0I0AwBnao63cuBD9/--

