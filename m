Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131336AbRBHVdO>; Thu, 8 Feb 2001 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129804AbRBHVdD>; Thu, 8 Feb 2001 16:33:03 -0500
Received: from oker.escape.de ([194.120.234.254]:45433 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S130056AbRBHVcp>;
	Thu, 8 Feb 2001 16:32:45 -0500
Date: Thu, 8 Feb 2001 22:31:33 +0100
From: Jochen Striepe <jochen@tolot.escape.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] modify ver_linux to check e2fsprogs and more.
Message-ID: <20010208223133.D21223@tolot.escape.de>
In-Reply-To: <01020813571906.04066@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <01020813571906.04066@localhost.localdomain>; from elenstev@mesatop.com on Thu, Feb 08, 2001 at 01:57:19PM -0700
X-Editor: vim/5.7.24
X-Signature: http://alfie.ist.org/sigd/
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

        Hi,

On 08 Feb 2001, Steven Cole <elenstev@mesatop.com> wrote:
> I have modified the scripts/ver_linux script to provide the following:
>
[...]
>
> hostname -V 2>&1 | awk 'NR=3D=3D1{print "Net-tools             ", $NF}'

*Please* consider modifying this. There might be a problem:


tolot:/root # hostname -V
tolot:/root # hostname
-V
tolot:/root # hostname --version
hostname (GNU sh-utils) 2.0.11
Written by Jim Meyering.

Copyright (C) 2000 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Greetings from Germany,

Jochen Striepe

--=20
The number of UNIX installations has grown to 10, with more expected.
                     - Dennis Ritchie and Ken Thompson, June 1972


--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6gxA1m3eMyUx1sM4RAt9AAJ409GEPEsENum65ftlBaHGm1zoLzACcCOex
0ytXeGACDH/Vv9WeNXqievM=
=RSI3
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
