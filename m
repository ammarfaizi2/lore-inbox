Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283777AbRK3UIm>; Fri, 30 Nov 2001 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283779AbRK3UIX>; Fri, 30 Nov 2001 15:08:23 -0500
Received: from pec-124-150.tnt8.m2.uunet.de ([149.225.124.150]:1152 "EHLO
	avaloon.intern.net") by vger.kernel.org with ESMTP
	id <S283778AbRK3UIV>; Fri, 30 Nov 2001 15:08:21 -0500
From: M G Berberich <berberic@fmi.uni-passau.de>
Date: Fri, 30 Nov 2001 21:07:34 +0100
To: linux-kernel@vger.kernel.org
Cc: tytso@thunk.org
Subject: Re: 2.4.16: hda9: attempt to access beyond end of device
Message-ID: <20011130210734.A489@fmi.uni-passau.de>
In-Reply-To: <20011129225814.A464@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129225814.A464@fmi.uni-passau.de>; from berberic on Thu, Nov 29, 2001 at 10:58:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Am Thursday, den 29. November 2001 22:58:14 schrieb berberic:
> Partition boundary problem in 2.4.16 ?!
>=20
> I just tried to make a mke2fs on my /dev/hda9 and mke2fs with kernel
> 2.4.16 and it failed with a partial write. /var/log/messages says:
>=20
>   kernel: 03:09: rw=3D0, want=3D289140, limit=3D289138
>   kernel: attempt to access beyond end of device
>=20
> It works fine with 2.4.13 and it works with 2.4.16 if blocksize is
> set to 4k (fails with 1k blocks).

Now it failed with kernel 2.4.13 and mke2fs 1.25 on another partition,
but works with kernel 2.4.13 and mke2fs 1.18. 1k-blocks again.=20

I'm now longer sure if it is the kernel or mke2fs or both:(

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8B+cGnp4msu7jrxMRAhw3AKCc+4FDLv3WowP3XP/fdXSuBohoyQCbBhFb
7lt81jhU5OAcoRfj5TZO7DU=
=yQqZ
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
