Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSKNRHl>; Thu, 14 Nov 2002 12:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSKNRGN>; Thu, 14 Nov 2002 12:06:13 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:17231 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S265037AbSKNRFr>;
	Thu, 14 Nov 2002 12:05:47 -0500
Subject: 2.5.47 "DAC960" Compile Error
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ZqQsoMTw+YRyqiV75Ku2"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 12:12:38 -0500
Message-Id: <1037293958.16834.12.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 14 Nov 2002 17:12:39.0094 (UTC) FILETIME=[08D6B560:01C28C01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZqQsoMTw+YRyqiV75Ku2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Kernel being Compiled: 2.5.47
Distro: Redhat 8
GCC: 3.2-7

2.5.47 Compile with mostly default options, stops compiling in the
make phase with:

gcc -Wp,-MD,drivers/block/.DAC960.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE -include include/linux/modversions.h =20
-DKBUILD_BASENAME=3DDAC960   -c -o drivers/block/DAC960.o
drivers/block/DAC960.c
In file included from drivers/block/DAC960.c:49:
drivers/block/DAC960.h:2572:2: #error I am a non-portable driver, please
convert me to use the Documentation/DMA-mapping.txt interfaces
In file included from drivers/block/DAC960.c:49:
drivers/block/DAC960.h: In function `DAC960_BA_WriteHardwareMailbox':
drivers/block/DAC960.h:2846: warning: implicit declaration of function
`Virtual_to_Bus32'
drivers/block/DAC960.c: In function `DAC960_V2_GeneralInfo':
drivers/block/DAC960.c:656: warning: implicit declaration of function
`Virtual_to_Bus64'
drivers/block/DAC960.c: In function `DAC960_V1_ProcessCompletedCommand':
drivers/block/DAC960.c:3102: warning: implicit declaration of function
`Bus32_to_Virtual'
drivers/block/DAC960.c:3102: warning: passing arg 2 of
`__constant_memcpy' makes pointer from integer without a cast
drivers/block/DAC960.c:3102: warning: passing arg 2 of `__memcpy' makes
pointer
from integer without a cast
drivers/block/DAC960.c:3107: warning: passing arg 2 of
`__constant_memcpy' makes pointer from integer without a cast
drivers/block/DAC960.c:3107: warning: passing arg 2 of `__memcpy' makes
pointer
from integer without a cast
drivers/block/DAC960.c: In function `DAC960_P_InterruptHandler':
drivers/block/DAC960.c:5038: warning: passing arg 1 of
`DAC960_P_To_PD_TranslateEnquiry' makes pointer from integer without a
cast
drivers/block/DAC960.c:5044: warning: passing arg 1 of
`DAC960_P_To_PD_TranslateDeviceState' makes pointer from integer without
a cast
make[2]: *** [drivers/block/DAC960.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2

--=20
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

--=-ZqQsoMTw+YRyqiV75Ku2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA909mGF9k9BmZXCWYRArruAKCi5s2S97CVoBVTLWLVbKpod6XvyACeIuwL
MP9E3fwjMvnQnfRJPlVFe/4=
=NCAp
-----END PGP SIGNATURE-----

--=-ZqQsoMTw+YRyqiV75Ku2--

