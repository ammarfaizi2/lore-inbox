Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSA3H6z>; Wed, 30 Jan 2002 02:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSA3H6h>; Wed, 30 Jan 2002 02:58:37 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:26386 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S288957AbSA3H5b>;
	Wed, 30 Jan 2002 02:57:31 -0500
Date: Wed, 30 Jan 2002 11:00:25 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020130110025.A251@pazke.ipt>
In-Reply-To: <20020130122200.A254@pazke.ipt> <Pine.LNX.4.33.0201291412590.18804-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.33.0201291412590.18804-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Tue, Jan 29, 2002 at 02:14:32PM -0500
X-Uname: Linux pazke 2.4.13-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2002 at 02:14:32PM -0500, Mark Hahn wrote:
> > 	- what stop us from using -mregparm=3D3 gcc switch ?
>=20
> I dimly recall that it can generage bad code, perhaps only
> on old compilers.

Bad code, hmm ... slow code or wrong code ?
IIRC gcc 2.95.3 declared as minimal requirement for kernel compilation,
so may be it's not an issue anymore ?

>=20
> > 	- same with -Os -malign-loops=3D1 -malign-jumps=3D1 ?
>=20
> 2 is probably always the lowest you should go, and indeed,
> I think that's all the compiler permits.
>

gcc (at least 2.95.2) permits 1, but i didn't check generated code.

> > 	- any tool to measure perfomance gain/penalty of above ?
>=20
> lmbench.  it has to be a microbenchmark to measure this sort of thing,
> though a sanity check (kernel compile) would also be useful.

Thanks, i'll test these issues this weekend.=20

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8V6gZBm4rlNOo3YgRAq+mAJ48f8SwXB3fwa02oImdrN67IxniXwCbB0Cz
HqgNnXLWOeaqQn/l58SRuDY=
=OrYw
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
