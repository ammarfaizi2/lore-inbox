Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTKHU0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTKHU0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:26:20 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:11163 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S263827AbTKHU0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:26:11 -0500
Subject: Re: [PATCH 2.4] forcedeth
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FAC837F.2070601@gmx.net>
References: <3FAC837F.2070601@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QIWtnQPdCkVMuVVEzv9I"
Message-Id: <1068323168.25759.4.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 08 Nov 2003 22:26:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QIWtnQPdCkVMuVVEzv9I
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

I tested this driver for my Nforce2 mobo on 2.6.0-test9, and this driver
seemed useless, it just printed some random numbers in my konsole (And
trust me, it was hard to edit lilo.conf so I even could boot back to old
kernel when all the numbers just were jumping around) And it broke the
other card too, ifconfig was right, now there was this card too, but no
one from them worked. Thanks anyway.
la, 2003-11-08 kello 07:47, Carl-Daniel Hailfinger kirjoitti:
> Attached is forcedeth: A new driver for the ethernet interface of the
> NVIDIA nForce chipset, licensed under GPL.
>=20
> The driver was written without support from NVIDIA, it's the result of
> a cleanroom development:
> Carl-Daniel and Andrew reverse engineered the nvnet driver and wrote a
> specification, Manfred wrote the driver based on the spec. Since the
> driver has been available and working for a while now, Carl-Daniel
> fitted some compat glue to make it compile under 2.4.
>=20
> This release it intended for developers, it's alpha quality: normal
> network traffic could work, although slow due to incomplete interrupt
> handling. It does work on two nForce 2 systems, nForce and nForce 3
> are untested.
>=20
> Try it yourself, but don't complain if something breaks. Note that
> the driver generates quite a lot of debug output.
>=20
> Send any reports to linux-kernel or netdev@oss.sgi.com and Manfred
> will scoop them up.
>=20
> You also can download the patches for Linux 2.4.x and 2.6.x from
> http://www.hailfinger.org/carldani/linux/patches/forcedeth/
>=20
>=20
>         Manfred Spraul
>         Carl-Daniel Hailfinger
>         Andrew de Quincey
[...snip...]
Regards,
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-QIWtnQPdCkVMuVVEzv9I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digitaalisesti allekirjoitettu viestin osa

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/rVFe3+NhIWS1JHARAqumAJ9OmXjDy0nDNznrneSmI6v9DoxWcwCgmS8t
XbuQKMYfQc3lhV1HnMwiPT8=
=NmqF
-----END PGP SIGNATURE-----

--=-QIWtnQPdCkVMuVVEzv9I--

