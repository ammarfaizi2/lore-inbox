Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIH37>; Fri, 9 Feb 2001 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130059AbRBIH3t>; Fri, 9 Feb 2001 02:29:49 -0500
Received: from oker.escape.de ([194.120.234.254]:49928 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S129030AbRBIH3i>;
	Fri, 9 Feb 2001 02:29:38 -0500
Date: Fri, 9 Feb 2001 08:29:22 +0100
From: Jochen Striepe <jochen@tolot.escape.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] modify ver_linux to check e2fsprogs and more.
Message-ID: <20010209082922.A25273@tolot.escape.de>
In-Reply-To: <01020813571906.04066@localhost.localdomain> <20010208223133.D21223@tolot.escape.de> <01020820024207.04066@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <01020820024207.04066@localhost.localdomain>; from elenstev@mesatop.com on Thu, Feb 08, 2001 at 08:02:42PM -0700
X-Editor: vim/5.7.24
X-Signature: http://alfie.ist.org/sigd/
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

        Hi,

On 08 Feb 2001, Steven Cole <elenstev@mesatop.com> wrote:
>=20
> But, there is an easy solution:
> [root@localhost scripts]# ifconfig --version
> net-tools 1.57
> ifconfig 1.40 (2000-05-21)
>=20
> I replaced the old code for Net-tools with this:
>=20
> ifconfig --version 2>&1 | grep tools | awk \
> 'NR=3D=3D1{print "Net-tools             ", $NF}'
>=20
> That should work.  I hope.  Try it please.

This works great for me. Thanks!


Greetings from Germany,

Jochen Striepe.

--=20
"Gosh that takes me back ... or forward.  That's the trouble with time
travel, you never can tell."
                -- Dr. Who


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6g5xRm3eMyUx1sM4RAvrcAJwIL7ooeivjJ7ecQcS2qMzhKhFwCQCdGkfB
ulDmuABaeKkfRlD2cmJCu9s=
=ap4X
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
