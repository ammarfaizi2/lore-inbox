Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSAXK1u>; Thu, 24 Jan 2002 05:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSAXK1k>; Thu, 24 Jan 2002 05:27:40 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:6417 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S286904AbSAXK1V>; Thu, 24 Jan 2002 05:27:21 -0500
Subject: 2.5.3pre4 compile error - DAC960.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IdU1ALnVZkf3mqx37t4l"
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 10:33:19 +0000
Message-Id: <1011868400.1236.1304.camel@unhygienix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IdU1ALnVZkf3mqx37t4l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686    -DEXPORT_SYMTAB -c DAC960.c
In file included from DAC960.c:49:
DAC960.h: In function `DAC960_AcquireControllerLock':
DAC960.h:2511: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.h: In function `DAC960_ReleaseControllerLock':
DAC960.h:2523: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.h: In function `DAC960_AcquireControllerLockIH':
DAC960.h:2560: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.h: In function `DAC960_ReleaseControllerLockIH':
DAC960.h:2573: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c: In function `DAC960_WaitForCommand':
DAC960.c:309: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c:311: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.c: In function `DAC960_RegisterBlockDevice':
DAC960.c:1948: too few arguments to function `blk_init_queue'
DAC960.c:1961: structure has no member named `MaxSectorsPerRequest'
DAC960.c: In function `DAC960_RegisterDisk':
DAC960.c:2076: incompatible type for argument 2 of `register_disk'
DAC960.c:2088: incompatible type for argument 2 of `register_disk'
DAC960.c: In function `DAC960_V1_QueueReadWriteCommand':
DAC960.c:2745: warning: implicit declaration of function `bio_size'
DAC960.c: In function `DAC960_ProcessCompletedBuffer':
DAC960.c:2948: too few arguments to function
DAC960.c: In function `DAC960_Open':
DAC960.c:5302: invalid operands to binary &
DAC960.c: In function `DAC960_UserIOCTL':
DAC960.c:5539: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c:5543: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
make[3]: *** [DAC960.o] Error 1

--=20
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com

--=-IdU1ALnVZkf3mqx37t4l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjxP4u8ACgkQwgE0gTKdDobsEQCfcHQYnqIkrQaVpHWazj8MkvoV
f10AniRgfMBohp0p+7v7vNP6Oio2SsmN
=EQHx
-----END PGP SIGNATURE-----

--=-IdU1ALnVZkf3mqx37t4l--

