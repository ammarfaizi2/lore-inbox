Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTARXn6>; Sat, 18 Jan 2003 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTARXn5>; Sat, 18 Jan 2003 18:43:57 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:49130 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S265197AbTARXn5>;
	Sat, 18 Jan 2003 18:43:57 -0500
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
From: Max Valdez <maxvaldez@yahoo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030118154414.607df22b.akpm@digeo.com>
References: <1042932078.3476.25.camel@garaged.fis.unam.mx>
	 <20030118154414.607df22b.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2hHWeec1lnczEtYfOohE"
Organization: 
Message-Id: <1042933992.3470.31.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Jan 2003 17:53:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2hHWeec1lnczEtYfOohE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>Your ext3 filesystem is being built as a module, so you are dependent
>upon
>correct initrd setup to be able to mount the other filesystems.  If
>those
>filesystems were not cleanly shut down, ext2 will not be able to mount
>them.

>Or something like that.  Try setting CONFIG_EXT3_FS=3Dy.

I do have EXT3_FS=3Dm

But I did a correct initrd build, / mount is ext3, and gets mounted ok,
but not the other partitions or disk, and the get mounted manually
without any other requierment (i.e. modprobe scsi)
Thanks for the reply
Max

--=20
Max Valdez <maxvaldez@yahoo.com>

--=-2hHWeec1lnczEtYfOohE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+KejosvQlVyd+QikRAsCcAJ4+1d0rar+CM119X9xWNiFgyY0jCwCgtfpw
/roZFSe1navGcieORMOQrWw=
=zYRB
-----END PGP SIGNATURE-----

--=-2hHWeec1lnczEtYfOohE--

