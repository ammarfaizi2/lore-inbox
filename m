Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTECIrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 04:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTECIrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 04:47:32 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:52865 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263275AbTECIra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 04:47:30 -0400
Subject: Re: Compile error kernel 2.4.21-rc1
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051946869.3976.32.camel@marx>
References: <1051938126.3976.11.camel@marx>  <1051946869.3976.32.camel@marx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/nE8U1kuGS1CkYcc0oEx"
Organization: Trudheim Technology Limited
Message-Id: <1051952389.3976.35.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 03 May 2003 09:59:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/nE8U1kuGS1CkYcc0oEx
Content-Type: multipart/mixed; boundary="=-6PIJEUtRSo7V7U9BWp1D"


--=-6PIJEUtRSo7V7U9BWp1D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-03 at 08:27, Anders Karlsson wrote:
> On Sat, 2003-05-03 at 06:02, Anders Karlsson wrote:
> > Hi,
> >=20
> > Just tried to compile kernel 2.4.21-rc1 and I get the compile error as
> > per attached file 'compile_error.txt'. The config file used is also
> > attached. This happened while doing 'make rpm'. This is being compiled
> > on SuSE Pro 8.2 which is using GCC 3.3.
> >=20
> > I'll happily try out patches.
>=20
> Found another compile error. Again attached in 'compile_error.txt'.
>=20
And another one.

/Anders

--=-6PIJEUtRSo7V7U9BWp1D
Content-Disposition: attachment; filename=compile_error.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=compile_error.txt; charset=UTF-8

gcc -D__KERNEL__ -I/usr/src/packages/BUILD/kernel-2.4.21rc1/include -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fom=
it-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -DMODUL=
E -DMODVERSIONS -include /usr/src/packages/BUILD/kernel-2.4.21rc1/include/l=
inux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dolym=
pic  -c -o olympic.o olympic.c
olympic.c:658:16: missing terminating " character
olympic.c:659:7: missing terminating " character
olympic.c: In function `olympic_rx':
olympic.c:858: warning: signed and unsigned type in conditional expression
olympic.c: At top level:
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:299: warnin=
g: `__module_kernel_version' defined but not used
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:302: warnin=
g: `__module_using_checksums' defined but not used
olympic.c:1805: warning: `__module_license' defined but not used
make[4]: *** [olympic.o] Error 1
make[4]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net/tokenring'
make[3]: *** [_modsubdir_tokenring] Error 2
make[3]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net'
make[2]: *** [_modsubdir_net] Error 2
make[2]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1'
Bad exit status from /var/tmp/rpm-tmp.64597 (%build)
make: *** [rpm] Error 1


--=-6PIJEUtRSo7V7U9BWp1D--

--=-/nE8U1kuGS1CkYcc0oEx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+s4UFLYywqksgYBoRAmJzAJ4gpQTN+NTwrwL0bzK6DGlRnSxqwwCffoeJ
mNGZHX+AVL9W1EKnkiFzhGQ=
=JiAw
-----END PGP SIGNATURE-----

--=-/nE8U1kuGS1CkYcc0oEx--

