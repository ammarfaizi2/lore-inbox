Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRLPTXj>; Sun, 16 Dec 2001 14:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284761AbRLPTXT>; Sun, 16 Dec 2001 14:23:19 -0500
Received: from sphere.open-net.org ([64.53.98.77]:54916 "HELO open-net.org")
	by vger.kernel.org with SMTP id <S282684AbRLPTXQ>;
	Sun, 16 Dec 2001 14:23:16 -0500
Date: Sun, 16 Dec 2001 14:17:38 -0500
From: Robert Jameson <rj@open-net.org>
To: linux-kernel@vger.kernel.org
Message-Id: <20011216141738.6bbc372c.rj@open-net.org>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.7U9+cJFF3'(.Nq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.7U9+cJFF3'(.Nq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Does anyone have any ideas about this error while compiling 2.5.1-pre11

output from make modules:

make[1]: Entering directory `/usr/src/linux-2.5.1-pre11/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.5.1-pre11/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.1-pre11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.5.1-pre11/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.5.1-pre11/drivers'
make -C block modules
make[2]: Entering directory `/usr/src/linux-2.5.1-pre11/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.1-pre11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.5.1-pre11/include/linux/modversions.h   -c -o xd.o xd.c
xd.c: In function `xd_init':
xd.c:173: too few arguments to function `blk_init_queue_Rb01d9c7f'
make[2]: *** [xd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.1-pre11/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.1-pre11/drivers'
make: *** [_mod_drivers] Error 2

-- 

I'm praying for rain and I'm praying for tidal waves I wanna see the ground give way. 
I wanna watch it all go down - tool.

--=.7U9+cJFF3'(.Nq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8HPNYyWZRCCLwK/cRAlrkAKCQ4BH7JpKuwo5RiyrSRar35fVrigCfYNfC
MVg0XkCgwY28MYQzsVxdS1g=
=UUmP
-----END PGP SIGNATURE-----

--=.7U9+cJFF3'(.Nq--

