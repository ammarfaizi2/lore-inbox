Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTEVPQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTEVPQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:16:29 -0400
Received: from pfepc.post.tele.dk ([193.162.153.4]:45955 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261956AbTEVPQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:16:26 -0400
Subject: Re: Error during compile of 2.5.69-mm8
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1053611668.4649.1.camel@krycek>
References: <1053611668.4649.1.camel@krycek>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hIXeTs+BywFibHcMcjUn"
Organization: krycek.org
Message-Id: <1053617369.1402.0.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 17:29:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hIXeTs+BywFibHcMcjUn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey!

Well you can fix it by either compiling apm as a module or not compiling
apm at all =3D)

Best Regards
Mads Christensen

On tor, 2003-05-22 at 15:54, Mads Christensen wrote:
> Hello
>=20
> Got this while i tried to compile the fucker!=20
>=20
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=3Dversion
> -DKBUILD_MODNAME=3Dversion -c -o init/.tmp_version.o init/version.c
> scripts/fixdep init/.version.o.d init/version.o 'gcc
> -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=3Dversion
> -DKBUILD_MODNAME=3Dversion -c -o init/.tmp_version.o init/version.c' >
> init/.version.o.tmp; rm -f init/.version.o.d; mv -f init/.version.o.tmp
> init/.version.o.cmd
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/mounts.o init/initramfs.o
>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> --start-group  usr/built-in.o  arch/i386/kernel/built-in.o=20
> arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o=20
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o=20
> security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a=20
> drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o=20
> net/built-in.o --end-group  -o vmlinux
> arch/i386/kernel/built-in.o(.init.text+0x5521): In function `apm_init':
> : undefined reference to `SET_MODULE_OWNER'
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.69-mm8'
> make: *** [stamp-build] Error 2
>=20
>=20
> Thanks in advance!
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
| Mads F. Christensen     ||                      |
| Email:                  || mfc@krycek.org       |
| Webdesign Development   || www.krycek.org       |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


--=-hIXeTs+BywFibHcMcjUn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+zOzZ44SvOSUXdFgRApBdAJ9GyPY8DdcafQ8XWAhkt9P8Mni47QCgjWp/
0WtuhIUZaOai1WLXVMq0JSc=
=aGFb
-----END PGP SIGNATURE-----

--=-hIXeTs+BywFibHcMcjUn--

