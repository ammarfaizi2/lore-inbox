Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSJQR5L>; Thu, 17 Oct 2002 13:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261774AbSJQR5L>; Thu, 17 Oct 2002 13:57:11 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:46574 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261772AbSJQR5K>; Thu, 17 Oct 2002 13:57:10 -0400
Subject: Re: [PATCH] make LSM register functions GPLonly exports
From: Arjan van de Ven <arjanv@redhat.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       Linux Security Module <linux-security-module@wirex.com>
In-Reply-To: <3DAEF703.20009@wirex.com>
References: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com> 
	<3DAEF703.20009@wirex.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sqnoNn/UJxy36A8WpWCs"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 20:03:55 +0200
Message-Id: <1034877846.3006.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sqnoNn/UJxy36A8WpWCs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-10-17 at 19:44, Crispin Cowan wrote:

> Note that if we decide that #include of a kernel header file means that=20
> a work is derived, then we cause another problem: most Linux=20
> applications come under the GPL.  glibc #includes some kernel header=20
> files, and most Linux applications #include glibc headers, so most=20
> applications are #including kernel header files. If #include is the=20
> basis for declaring a module to be a derived work of the kernel, then=20
> there is some bad news coming for people who like to use Oracle and DB2=20
> on Linux ...
>=20
difference is that glibc only uses the glibc-kernheaders; which on
several distros at least are just the data structures and not the
inlines. (and the inlines are in #ifdef KERNEL anyway and removed by the
preprocessor for userspace)

--=-sqnoNn/UJxy36A8WpWCs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9rvuLxULwo51rQBIRAoMJAJ9zJtAl+3HVAMTV0WsxI/Uz7gozMwCgnb0L
OUMwW96K7PKaH5o4FhqJA08=
=E+5u
-----END PGP SIGNATURE-----

--=-sqnoNn/UJxy36A8WpWCs--

