Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264517AbSIVUag>; Sun, 22 Sep 2002 16:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264518AbSIVUag>; Sun, 22 Sep 2002 16:30:36 -0400
Received: from ulima.unil.ch ([130.223.144.143]:20868 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264517AbSIVUaf>;
	Sun, 22 Sep 2002 16:30:35 -0400
Date: Sun, 22 Sep 2002 22:35:42 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.38-ml2
Message-ID: <20020922203541.GA26899@ulima.unil.ch>
References: <20020922181358.GA16388@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20020922181358.GA16388@minerva.local.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2002 at 08:13:59PM +0200, Martin Loschwitz wrote:
> Ok, this version is fixed.

Hello,

it miss the floppy fix...

  gcc-3.2 -Wp,-MD,./.floppy.o.d -D__KERNEL__
-I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=3D2 -march=3Di686
-I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc -iwithprefix
include -DMODULE   -DKBUILD_BASENAME=3Dfloppy   -c -o floppy.o floppy.c
floppy.c: In function `cleanup_module':
floppy.c:4565: `drive' undeclared (first use in this function)
floppy.c:4565: (Each undeclared identifier is reported only once
floppy.c:4565: for each function it appears in.)
floppy.c:4559: warning: unused variable `i'
floppy.c:4573: warning: statement with no effect
make[2]: *** [floppy.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/block'
make[1]: *** [block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jimcFDWhsRXSKa0RAhZMAJsEewPjBiO4UaGTn2QrW5Lcr03KDACbBc1V
73o2pLe9v0V0w9aaWKAG3K0=
=4ZI8
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
