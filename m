Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUHYUQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUHYUQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUHYUNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:13:54 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:30950 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S268473AbUHYUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:09:50 -0400
Date: Wed, 25 Aug 2004 13:09:44 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: compile error if make O=/some/other/dir in 2.6.9-rc1
To: Sam Ravnborg <sam@ravnborg.org>, kai@germaschewski.name
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1093464584.23633.31.camel@duffman>
MIME-version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-6jYuL6jeCIUmeLzIiPsQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6jYuL6jeCIUmeLzIiPsQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This was introduced in 2.6.9-rc1

$ make V=3D1 O=3D/tmp/kbuild2/

  gcc -Wp,-MD,arch/x86_64/boot/tools/.build.d -Iarch/x86_64/boot -Wall -Wst=
rict-prototypes -O2 -fomit-frame-pointer  -o arch/x86_64/boot/tools/build /=
build1/tduffy/openib-work/linux-2.6.9-rc1-openib/arch/x86_64/boot/tools/bui=
ld.c
cc1: No such file or directory: opening dependency file arch/x86_64/boot/to=
ols/.build.d
make[2]: *** [arch/x86_64/boot/tools/build] Error 1
make[1]: *** [bzImage] Error 2
make: *** [_all] Error 2



--=-6jYuL6jeCIUmeLzIiPsQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBLPIIdY502zjzwbwRAgt9AJ4xGAITwaiQig0I6bL73I/lu4KtDgCgmFPi
ivh2FhxxvR+DLZC3360ajL8=
=PeK6
-----END PGP SIGNATURE-----

--=-6jYuL6jeCIUmeLzIiPsQ--

