Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTBLVJf>; Wed, 12 Feb 2003 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTBLVJf>; Wed, 12 Feb 2003 16:09:35 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:56052 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S267640AbTBLVJe>;
	Wed, 12 Feb 2003 16:09:34 -0500
Subject: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dq41v+ur0PdGbeKJHqcl"
Organization: Rutgers University
Message-Id: <1045084764.4767.76.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 16:19:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dq41v+ur0PdGbeKJHqcl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to use O_DIRECT to read ordinary files and read syscall
always returns 0, unless when the file size equals the fs block size. Is
it true that I can only use O_DIRECT when the size of the file written
in the inode is a multiple of block size?

Thanks and excuse me for the newbie question,

Bruno.
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-dq41v+ur0PdGbeKJHqcl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+SrpbZGORSF4wrt8RApGkAJ4hQr6iYqJYOKwxz5scl0qCaSrMOwCfTzBJ
LeluJWaL1YwA6sjeHWHGjn8=
=W2gA
-----END PGP SIGNATURE-----

--=-dq41v+ur0PdGbeKJHqcl--

