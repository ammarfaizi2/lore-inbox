Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293719AbSCES4X>; Tue, 5 Mar 2002 13:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSCES4R>; Tue, 5 Mar 2002 13:56:17 -0500
Received: from adsl-66-127-87-238.dsl.sntc01.pacbell.net ([66.127.87.238]:45457
	"HELO Mail.ChaoticDreams.ORG") by vger.kernel.org with SMTP
	id <S293719AbSCES4K>; Tue, 5 Mar 2002 13:56:10 -0500
Date: Tue, 5 Mar 2002 10:55:39 -0800
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre2: <M> SGI HAL2 sound (EXPERIMENTAL) results in compile error
Message-ID: <20020305105539.A10872@ChaoticDreams.ORG>
In-Reply-To: <200203051440.g25Eeoq18818@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200203051440.g25Eeoq18818@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Tue, Mar 05, 2002 at 04:40:04PM -0200
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2002 at 04:40:04PM -0200, Denis Vlasenko wrote:
> 2.4.19-pre2:
>=20
> <M> SGI HAL2 sound (EXPERIMENTAL) results in:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> gcc -D__KERNEL__ -I/.share/usr/src/linux-2.4.19-pre2/include -Wall=20
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer=20
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2=20
> -march=3Di386 -DMODULE -DMODVERSIONS -include=20
  ^^^^^^^^^^^
> /.share/usr/src/linux-2.4.19-pre2/include/linux/modversions.h =20
> -DKBUILD_BASENAME=3Dhal2  -c -o hal2.o hal2.c
>=20
> hal2.c:36:29: asm/sgi/sgint23.h: No such file or directory
> In file included from hal2.c:38:
> hal2.h:24:27: asm/addrspace.h: No such file or directory
> hal2.h:25:28: asm/sgi/sgihpc.h: No such file or directory

These are mips64 things, and don't reside in include/asm-i386. Try building=
 it
again with ARCH=3Dmips64.

Regards,

--=20
Paul Mundt <lethal@chaoticdreams.org>


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyFFKoACgkQYLvqhoOEA4FubgCbBAWsbIOrYnlbiVEAqquAAmpe
9ZgAnA178lcscsz1U+gOcWPDv2Z/iG0u
=WTeD
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
