Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSBSSvl>; Tue, 19 Feb 2002 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSBSSvc>; Tue, 19 Feb 2002 13:51:32 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:18800 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S286942AbSBSSvW>;
	Tue, 19 Feb 2002 13:51:22 -0500
Subject: Re: kernel panic
From: Justin Carlson <justincarlson@cmu.edu>
To: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020219182754.68142.qmail@web21308.mail.yahoo.com>
In-Reply-To: <20020219182754.68142.qmail@web21308.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Or0vIouoPcyAg0iMr9cq"
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 13:50:45 -0500
Message-Id: <1014144646.7832.6.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Or0vIouoPcyAg0iMr9cq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The problem is while booting the kernel with my newly
> developed floppy, I am getting the error message
>=20
> kernel panic: VFS: Unable to mount root fs on 08:03
>=20
> I donno what to do. Is it some thing related to "make
> xconfig" options or some other thing. Please give me
> suggestion.

I guess the obvious questions are:

What kind of filesystem are you trying to mount as root?  Have you
checked whether a root argument is being passed to the kernel by
whatever loader you're using?

Did you inadvertently disable support for that kind of filesystem?

If you're mounting root over NFS, did you disable support for=20
any of the networking options you might need?  (like, say, kernel-level
IP autoconfiguration).

In short, what changed between the last configuration that worked,
and this one that doesn't? =20

-Justin



--=-Or0vIouoPcyAg0iMr9cq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8cp6F47Lg4cGgb74RAi2JAJ9MEFHBw7HkOQbeDXGH9GvTaX4OxACdG5CQ
1aJrMYteskfhYF9AjZGG8EI=
=AYDP
-----END PGP SIGNATURE-----

--=-Or0vIouoPcyAg0iMr9cq--

