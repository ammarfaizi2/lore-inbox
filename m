Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUGYW60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUGYW60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 18:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGYW60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 18:58:26 -0400
Received: from smtp06.auna.com ([62.81.186.16]:7910 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264560AbUGYW6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 18:58:23 -0400
Date: Mon, 26 Jul 2004 00:58:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1
Message-ID: <20040725225821.GA4745@werewolf.able.es>
References: <18199.1090681162@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <18199.1090681162@ocs3.ocs.com.au> (from kaos@ocs.com.au on Sat, Jul 24, 2004 at 16:59:22 +0200)
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.07.24, Keith Owens wrote:
> On Sat, 24 Jul 2004 09:19:04 -0400 (EDT),=20
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >> >gcc -D__KERNEL__ -nostdinc -iwithprefix include
> >                     ^^^^^^^_______
> >
> >This will prevent it from using its private copy of stdarg.h.
> >
> >There needs to be one in the -I<include-path>
>=20
> No.  -iwithprefix include picks up the private path.  It is probably a
> misconfigured gcc, but I am waiting on detailed diagnostics to be sure.
>=20

Sorry, I won't have time to do more dignostics until wednesday.
I'll be back then...

Just one note. 2.6 builds fine with this gcc...

werewolf:~# gcc -v
Reading specs from /usr/lib/gcc/i586-mandrake-linux-gnu/3.4.1/specs
Configured with: ../configure --prefix=3D/usr --libdir=3D/usr/lib --with-sl=
ibdir=3D/li
b --mandir=3D/usr/share/man --infodir=3D/usr/share/info --enable-shared --e=
nable-thr
eads=3Dposix --disable-checking --enable-long-long --enable-__cxa_atexit --=
enable-
clocale=3Dgnu --disable-libunwind-exceptions --enable-languages=3Dc,c++,ada=
,f77,objc
,java --host=3Di586-mandrake-linux-gnu --with-system-zlib
Thread model: posix
gcc version 3.4.1 (Mandrakelinux (Alpha 3.4.1-2mdk)


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Alpha 1) for i586
Linux 2.6.8-rc1-jam2 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-2mdk)) #1

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBDsNRlIHNEGnKMMRAshZAJ98URTpDBIm684B3aWVOcX8H4zhhgCcC6NM
psExr136ss1rHYUkWcHOyRk=
=1wun
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
