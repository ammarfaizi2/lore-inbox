Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSJTN6m>; Sun, 20 Oct 2002 09:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJTN6m>; Sun, 20 Oct 2002 09:58:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:45069 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262648AbSJTN6l>;
	Sun, 20 Oct 2002 09:58:41 -0400
Date: Sun, 20 Oct 2002 16:04:44 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Laramie Leavitt <laramie.leavitt@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling 2.5.43 Alpha.
Message-ID: <20021020140444.GX30418@lug-owl.de>
Mail-Followup-To: Laramie Leavitt <laramie.leavitt@attbi.com>,
	linux-kernel@vger.kernel.org
References: <OFEJKOGEKOCPKMCJDFCEKECGCAAA.laramie.leavitt@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aIPTgi9H47uqouUT"
Content-Disposition: inline
In-Reply-To: <OFEJKOGEKOCPKMCJDFCEKECGCAAA.laramie.leavitt@attbi.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aIPTgi9H47uqouUT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-18 00:26:40 -0700, Laramie Leavitt <laramie.leavitt@attbi.c=
om>
wrote in message <OFEJKOGEKOCPKMCJDFCEKECGCAAA.laramie.leavitt@attbi.com>:
>=20
> gcc -Wp,-MD,arch/alpha/kernel/.irq_alpha.o.d -D__KERNEL__ -Iinclude -Wall=
 -W
> strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali=
asi
> ng -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=3Dev56 -Wa,-mev6 -nostd=
inc -
> iwithprefix include    -DKBUILD_BASENAME=3Dirq_alpha   -c -o
> arch/alpha/kernel/irq_alpha.o arch/alpha/kernel/irq_alpha.c
> In file included from arch/alpha/kernel/irq_alpha.c:15:
> arch/alpha/kernel/irq_impl.h: In function `alpha_do_profile':
> arch/alpha/kernel/irq_impl.h:50: `prof_buffer' undeclared (first use in t=
his
> function)
> arch/alpha/kernel/irq_impl.h:50: (Each undeclared identifier is reported
> only once
> arch/alpha/kernel/irq_impl.h:50: for each function it appears in.)
> arch/alpha/kernel/irq_impl.h:61: `prof_shift' undeclared (first use in th=
is
> function)
> arch/alpha/kernel/irq_impl.h:67: `prof_len' undeclared (first use in this
> function)
> make[1]: *** [arch/alpha/kernel/irq_alpha.o] Error 1

Add "#include <linux/profile.h>" near the top to
=2E/linux/arch/alpha/kernel/irq_impl.h. Sorry, no patch this time...

By the way, accepting little patching, recent 2.5.x kernels do run fine
on my systems (AXPpci33 aka. noname and Miata).

MfG, JBG

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--aIPTgi9H47uqouUT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9srf8Hb1edYOZ4bsRAijHAKCP8jW7HDyPCzXiUmO3B76ZVeaoBgCeODwD
UQfzMSzUc4h+TkJGod8Z/kA=
=1sri
-----END PGP SIGNATURE-----

--aIPTgi9H47uqouUT--
