Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSA2JUJ>; Tue, 29 Jan 2002 04:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSA2JT4>; Tue, 29 Jan 2002 04:19:56 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:28431 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S289084AbSA2JTf>;
	Tue, 29 Jan 2002 04:19:35 -0500
Date: Wed, 30 Jan 2002 12:22:00 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020130122200.A254@pazke.ipt>
In-Reply-To: <012d01c1a687$faa11120$0201a8c0@HOMER> <Pine.LNX.4.33.0201261339220.17628-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.33.0201261339220.17628-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Jan 26, 2002 at 01:42:52PM -0800
X-Uname: Linux pazke 2.4.13-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2002 at 01:42:52PM -0800, Linus Torvalds wrote:
>=20
> On Sat, 26 Jan 2002, Martin Eriksson wrote:
> >
> > Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just g=
ot a
> > ~1% smaller vmlinux and a ~3% smaller bzImage.
>=20
> Note that while "-Os" exists and is documented, as far as I know gcc
> doesn't actually do much with it. It really acts mostly as a "disable
> certain optimizations" than anything else.
>=20

Stupid questions:
	- what stop us from using -mregparm=3D3 gcc switch ?
	- same with -Os -malign-loops=3D1 -malign-jumps=3D1 ?
	- any tool to measure perfomance gain/penalty of above ?

> In the 3.0.x tree, it seems to change some of the weights of some
> instructions, and it might make more of a difference there. But at the
> same time it is quite telling that "-Os" doesn't even change any of the
> alignments etc - because gcc developers do not seem to really support it
> as a real option. It's an after-thought, not a big performance push.
>=20
> 		Linus
>=20

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8V7s4Bm4rlNOo3YgRAlhnAJ0eIYkGBRqMUxVbs8uMS8xgnWLx8QCgiv1+
kzBPdlitozHhpL4YcTmU1Ik=
=bRaG
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
