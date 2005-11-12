Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVKLUbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKLUbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVKLUbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:31:38 -0500
Received: from ctb-mesg5.saix.net ([196.25.240.85]:65522 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S964782AbVKLUbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:31:37 -0500
Subject: Re: gen_initramfs_list.sh: Cannot open 'y'
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Henrik Christian Grove <grove@fsr.ku.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7gk6fdy5t9.fsf@serena.fsr.ku.dk>
References: <7gk6fdy5t9.fsf@serena.fsr.ku.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KTOxwP6hGiTWa8ZwZRAZ"
Date: Sat, 12 Nov 2005 22:35:04 +0200
Message-Id: <1131827704.19428.6.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KTOxwP6hGiTWa8ZwZRAZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-11-12 at 21:22 +0100, Henrik Christian Grove wrote:
> When I try to compile a 2.6.14 kernel on my new laptop, I get the
> following error:
> x40:~/kerne/linux-2.6.14# make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
> dnsdomainname: Host name lookup failure
>   CHK     usr/initramfs_list
>   /root/kerne/linux-2.6.14/scripts/gen_initramfs_list.sh: Cannot open 'y'
> make[1]: *** [usr/initramfs_list] Error 1
> make: *** [usr] Error 2
>=20
> I simply don't understand what it's trying to do, and google doesn't
> seem to know that error. Can anyone here help?
>=20

I am going to guess the help text is unclear or something, and you have
in your .config:

CONFIG_INITRAMFS_SOURCE=3D"y"


--=20
Martin Schlemmer


--=-KTOxwP6hGiTWa8ZwZRAZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDdlH4qburzKaJYLYRAvIjAJ0evdyqWqabJWYrb67eH2/qspc1SwCfeiUU
s/aTx0RQ9xJr+Pg1BUSAjNc=
=tk9y
-----END PGP SIGNATURE-----

--=-KTOxwP6hGiTWa8ZwZRAZ--

