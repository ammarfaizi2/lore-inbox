Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbSLNGQq>; Sat, 14 Dec 2002 01:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbSLNGQp>; Sat, 14 Dec 2002 01:16:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31408 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267315AbSLNGQo>;
	Sat, 14 Dec 2002 01:16:44 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Sat, 14 Dec 2002 00:57:16 -0500
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: Symlink indirection
Message-ID: <20021214055716.GA14721@zion.rivenstone.net>
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com> <200212131616.gBDGGH302861@devserv.devel.redhat.com> <3DFA0F6D.1010904@walrond.org> <20021213115508.A16493@devserv.devel.redhat.com> <3DFA130C.1030106@walrond.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <3DFA130C.1030106@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2002 at 05:04:12PM +0000, Andrew Walrond wrote:
> Of course; Didn't think of that in this context.
>=20
> My application of symlinks involves overlaying several directories onto=
=20
> another, in an order such that any like named files are overridden in a=
=20
> defined way.
>=20
> I had thought about asking the feasibility of [made up name]=20
> 'transparent bindings' which would have this effect
>=20
> Suppose I might as well ask now ;) Any takers?

    I don't understand what you are trying to explain.  Do you mean a
union mount, or a variation thereof?

    I thought Al Viro was going to do union mount support for 2.5, but
I haven't heard about it in a while.  Maybe it went in and no one noticed?

=20
> Pete Zaitcev wrote:
> >>Date: Fri, 13 Dec 2002 16:48:45 +0000
> >>From: Andrew Walrond <andrew@walrond.org>
> >
> >
> >>Sorry for being dense, but what do you mean by 'bindings' ? Hard links?
> >
> >
> >$ man mount
> >
> >       Since Linux 2.4.0 it is possible to remount part of the file =20
> >       hierarchy
> >       somewhere else. The call is
> >              mount --bind olddir newdir
> >       After this call the same contents is accessible in two places.
> >
> >
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9+sg8Wv4KsgKfSVgRAiUcAJwO9QxzM+0WvgZ1VEsSi9doebW95wCcDSnh
WWZn9kajJ0BQgNDMqiY+TLo=
=VbqH
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
