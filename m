Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319164AbSHTOg0>; Tue, 20 Aug 2002 10:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319165AbSHTOg0>; Tue, 20 Aug 2002 10:36:26 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:40009 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S319164AbSHTOgX>;
	Tue, 20 Aug 2002 10:36:23 -0400
Date: Tue, 20 Aug 2002 09:40:28 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4
Message-ID: <20020820144028.GB10541@iucha.net>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2002 at 07:46:16PM -0300, Marcelo Tosatti wrote:
>=20
> So here goes -pre4, with JFS merged.
>=20
> Also, if you got bootup lockups or some unexpected weird error try
> -pre4 ;)

It fails to compile on sparc32 with:

make[3]: Entering directory `/db/linux/linux.20pre4/drivers/block'
gcc -D__KERNEL__ -I/db/linux/linux.20pre4/include -Wall -Wstrict-prototypes=
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -=
m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -I /usr/lib/gc=
c-lib/sparc-linux/2.95.4/include -DKBUILD_BASENAME=3Dll_rw_blk  -DEXPORT_SY=
MTAB -c ll_rw_blk.c
ll_rw_blk.c: In function `blk_seg_merge_ok':
ll_rw_blk.c:287: warning: implicit declaration of function `page_to_phys'
gcc -D__KERNEL__ -I/db/linux/linux.20pre4/include -Wall -Wstrict-prototypes=
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -=
m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -I /usr/lib/gc=
c-lib/sparc-linux/2.95.4/include -DKBUILD_BASENAME=3Dblkpg  -DEXPORT_SYMTAB=
 -c blkpg.c
In file included from /db/linux/linux.20pre4/include/linux/blk.h:4,
                 from blkpg.c:34:
/db/linux/linux.20pre4/include/linux/blkdev.h: In function `blk_queue_bounc=
e':
/db/linux/linux.20pre4/include/linux/blkdev.h:157: `mem_map' undeclared (fi=
rst use in this function)
/db/linux/linux.20pre4/include/linux/blkdev.h:157: (Each undeclared identif=
ier is reported only once
/db/linux/linux.20pre4/include/linux/blkdev.h:157: for each function it app=
ears in.)
In file included from /db/linux/linux.20pre4/include/linux/locks.h:5,
                 from /db/linux/linux.20pre4/include/linux/blk.h:5,
                 from blkpg.c:34:
/db/linux/linux.20pre4/include/linux/mm.h: At top level:
/db/linux/linux.20pre4/include/linux/mm.h:416: `mem_map' used prior to decl=
aration
make[3]: *** [blkpg.o] Error 1
make[3]: Leaving directory `/db/linux/linux.20pre4/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/db/linux/linux.20pre4/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/db/linux/linux.20pre4/drivers'
make: *** [_dir_drivers] Error 2

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9YlTbNLPgdTuQ3+QRApBWAJ9xGc8tN5ceAC8kjgzZQaDDtZxxzwCeNza7
4tGKdFe9ri78QSi/XsYhtR8=
=JMT0
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
