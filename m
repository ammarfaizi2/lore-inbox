Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSFUU5n>; Fri, 21 Jun 2002 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSFUU5m>; Fri, 21 Jun 2002 16:57:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18450 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S316792AbSFUU5l>;
	Fri, 21 Jun 2002 16:57:41 -0400
Date: Fri, 21 Jun 2002 22:57:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 doesn't compile on Alpha
Message-ID: <20020621205741.GN24903@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020621064835.GA13502@alpha.of.nowhere> <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at> <20020621141957.GA22555@alpha.of.nowhere> <20020621192405.A749@jurassic.park.msu.ru> <20020621203726.GA2308@alpha.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline
In-Reply-To: <20020621203726.GA2308@alpha.of.nowhere>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-06-21 22:37:26 +0200, Jurriaan on Alpha <thunder7@xs4all.nl>
wrote in message <20020621203726.GA2308@alpha.of.nowhere>:
> From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Date: Fri, Jun 21, 2002 at 07:24:05PM +0400
> > On Fri, Jun 21, 2002 at 04:19:57PM +0200, Jurriaan on Alpha wrote:
> > > I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h (the non-smp
> > > section) but the same line in include/asm/mmu_context.h works - for a
> > > while.
> >=20
> > I'm running 2.5.24 on sx164 with following (unfinished - SMP is broken)
> > patch.
> >=20
> This patchs helps a lot; now I get:
> drivers/built-in.o(.data+0x37118): undefined reference to `local symbols =
in discarded section .text.exit'

I think this "bug" appears with some binutils some weeks/months old. Try
to upgrade them.

I'm not hitting this bug, but for me, ./arch/alpha/kernel/head.o isn't
build (actually, there aren't any .o files in that directory), even if
I try to explicitely compile head.o by 'make arch/alpha/kernel/head.o'.
Any hints there?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9E5NEHb1edYOZ4bsRAuRtAJwKAfswcyPJmmVtS+bHkELwcoNK7QCfaAg4
8KBSeabnV4buYbGAAxL4OKI=
=GvgV
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--
