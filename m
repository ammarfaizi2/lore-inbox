Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267924AbTBLXjq>; Wed, 12 Feb 2003 18:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTBLXjq>; Wed, 12 Feb 2003 18:39:46 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:20890 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S267924AbTBLXjp>;
	Wed, 12 Feb 2003 18:39:45 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030212233846.GA13540@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
	 <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
	 <20030212232443.GA13339@f00f.org>
	 <1045092802.4766.96.camel@urca.rutgers.edu>
	 <20030212233846.GA13540@f00f.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qAH8vRFAeQ1Y/G9e7azW"
Organization: Rutgers University
Message-Id: <1045093775.21195.99.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 18:49:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qAH8vRFAeQ1Y/G9e7azW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-12 at 18:38, Chris Wedgwood wrote:

> Seems to.  I get 0 the 2nd time about,  presumably this is EOF but
> arguably it should return something else.

It didn't work for me. See the output:

diniz@urca:/var/tmp$ gcc -Wall od.c=20
diniz@urca:/var/tmp$ cp od.c test
diniz@urca:/var/tmp$ ./a.out=20
read 0 bytes
diniz@urca:/var/tmp$=20

What is your partition type? ext2?

Bruno.
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-qAH8vRFAeQ1Y/G9e7azW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+St2OZGORSF4wrt8RApDOAKCM4wX32GfI370qkIFeoootsEdyNQCeMJIo
QTVUzTJL/bU542U6ZGJc7Eo=
=DKUw
-----END PGP SIGNATURE-----

--=-qAH8vRFAeQ1Y/G9e7azW--

