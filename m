Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKDXhj>; Mon, 4 Nov 2002 18:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSKDXhj>; Mon, 4 Nov 2002 18:37:39 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:54247 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S262905AbSKDXhi>; Mon, 4 Nov 2002 18:37:38 -0500
Date: Tue, 5 Nov 2002 00:44:11 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org
Subject: Re: Linux v2.5.46
Message-Id: <20021105004411.3f474ef2.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.2I+0bJzj2QK4Eg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.2I+0bJzj2QK4Eg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2002 15:13:04 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Gerd Knorr <kraxel@bytesex.org>:
LT>   o videobuf update
LT>   o add v4l2 api
LT>   o tv tuner driver update
LT>   o bttv documentation update
LT>   o bttv update
LT>   o new v4l2 driver: saa7134

gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic
-nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_cards   -c -o
drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
make[4]: *** [drivers/media/video/bttv-cards.o] Error 1

Does anyone have a fix yet?

Regards,
-Udo.

--=.2I+0bJzj2QK4Eg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9xwZLnhRzXSM7nSkRAmcGAJ9gevyyi11q7jQBiF+WcnH6HgMc/gCcCXrv
tNYdAZvB8j2oVwiIct0mLXc=
=y7o/
-----END PGP SIGNATURE-----

--=.2I+0bJzj2QK4Eg--
