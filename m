Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRJNDZp>; Sat, 13 Oct 2001 23:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRJNDZe>; Sat, 13 Oct 2001 23:25:34 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:56842
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S273888AbRJNDZ2>; Sat, 13 Oct 2001 23:25:28 -0400
Date: Sat, 13 Oct 2001 20:25:56 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Ed Tomlinson <tomlins@CAM.ORG>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <20011013202556.C1356@one-eyed-alien.net>
Mail-Followup-To: Ed Tomlinson <tomlins@CAM.ORG>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011013234121.31B3B24D64@oscar.casa.dyndns.org> <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu> <20011013193635.B1356@one-eyed-alien.net> <20011014024108.BE1EA251BA@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011014024108.BE1EA251BA@oscar.casa.dyndns.org>; from tomlins@CAM.ORG on Sat, Oct 13, 2001 at 10:41:08PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Odd... it's not supposed to.  There's no code to generate a media changed
event, and the units don't generate them.

Maybe you have a strange unit that does generate media-change.  Odd.

The SDDR-09 code hasn't change since .10, so if it worked then, I _guess_
it should work now.

Matt

On Sat, Oct 13, 2001 at 10:41:08PM -0400, Ed Tomlinson wrote:
> On October 13, 2001 10:36 pm, Matthew Dharm wrote:
> > Media change is broken for the SDDR-09 driver.  That's why it's
> > experimental, among other reasons.
> >
> > Don't worry about that, but if you've got a non-media change related
> > problem, then I would look at that.
>=20
> Actually media change _worked_ with previous kernels, 2.4.10 and below.
> I would get an error from one mount and the second would work.  Not
> real clean but it did work...
>=20
> Ed Tomlinson

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7yQXEz64nssGU+ykRAlxrAKCvhGwrnHMBHqD1MIzEMNPbqc9YXACg5nkU
ABFkwU0lTMw07C98eNnnlwA=
=qYwN
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
