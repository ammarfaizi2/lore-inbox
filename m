Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSDCUFZ>; Wed, 3 Apr 2002 15:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDCUFP>; Wed, 3 Apr 2002 15:05:15 -0500
Received: from adsl-64-108-133-56.dsl.milwwi.ameritech.net ([64.108.133.56]:52725
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S293196AbSDCUFF>; Wed, 3 Apr 2002 15:05:05 -0500
Date: Wed, 3 Apr 2002 14:05:01 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Abdij Bhat <Abdij.Bhat@kshema.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-mips-kernel@lists.sourceforge.net'" 
	<linux-mips-kernel@lists.sourceforge.net>
Subject: Re: [Linux-mips-kernel]error compiling kernel for mips
Message-ID: <20020403200501.GA14938@0xd6.org>
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FD5@BHISHMA>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Abdij Bhat <Abdij.Bhat@kshema.com> on Thu, Apr 04, 2002:

> Hi,
>  When i try compiling the Kernel for mips i get errors. The kernel is 2.4=
.17
> downloaded from www.kernel.org. I have the mips developments environment
> set. I have (hopefully) the right headers and have modified the makefile =
to
> get the headers from those include directories.
>  My main problem is changing the architecture from arch686 ( mine ) to mi=
ps.
> How to i do this? What do i need to do inorder for the make to get the ri=
ght
> architecture? Or is there some other problem too?
>=20

You need to pass something like:

$ make ARCH=3Dmips CROSS_COMPILE=3Dmipsel-linux- config dep clean vmlinux

So that the kernel build system knows that you are cross-compiling.

M. R.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8q2BsaK6pP/GNw0URArnuAKCEnvcHv+N/jAHp061/eZMcfDzN6ACfQZWq
VUTn00w8rlQlxh6tAbLsJVQ=
=c1UO
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
