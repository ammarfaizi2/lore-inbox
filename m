Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSLJBGv>; Mon, 9 Dec 2002 20:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLJBGv>; Mon, 9 Dec 2002 20:06:51 -0500
Received: from [216.38.156.94] ([216.38.156.94]:62480 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S266407AbSLJBGu>; Mon, 9 Dec 2002 20:06:50 -0500
Subject: Re: grub and 2.5.50
From: Dmitri <dmitri@users.sourceforge.net>
To: wz6b@arrl.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212091640.35716.wz6b@arrl.net>
References: <200212091640.35716.wz6b@arrl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-TBFkNgIuSmHBbP8WDMHE"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 17:11:58 -0800
Message-Id: <1039482718.23280.92.camel@usb.networkfab.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TBFkNgIuSmHBbP8WDMHE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-12-09 at 16:40, Matt Young wrote:

> These grub commands work with SUSE 2.4.19-4GB:
>=20
>    kernel (hd0,0)/bzImage root=3D/dev/hda3   vga=3D791
>    initrd (hd0,0)/initrd
>=20
> But with 2.5.50 the kernel panics after Freeing the initrd memory with=20
> "Unable te mount root FS, please correct the root=3D cammand line"
> I have compiled with the required file systems (EXT2,EXT3,REISERFS).

grub that came with RH 8.0 can boot 2.5.50 with no problems.

- what is the filesystem on /dev/hda3 ?
- do you have the FS *compiled into the kernel* ?
- did you rebuild your initrd?

Otherwise your old initrd will have old modules, and the FS module won't
load into your new kernel. If you compile them *into* the 2.5.50 then it
will just complain. That's what I did.

Dmitri



--=-TBFkNgIuSmHBbP8WDMHE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99T9eiqqasvm69/IRAiZFAKDUqcWGQs3m7zTlpZMLCgaGdC4yGQCfX8Nv
mlYT2GRf0ScToEl/U33OA4w=
=x2Jc
-----END PGP SIGNATURE-----

--=-TBFkNgIuSmHBbP8WDMHE--

