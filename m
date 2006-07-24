Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWGXQ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWGXQ57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWGXQ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:57:59 -0400
Received: from www.timetrex.com ([69.93.244.106]:52408 "EHLO
	mail.academyoflearning.ca") by vger.kernel.org with ESMTP
	id S932218AbWGXQ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:57:58 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Mike Benoit <ipso@snappymail.ca>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20060724102508.GA26553@merlin.emma.line.org>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org>
	 <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com>
	 <44C44622.9050504@namesys.com>
	 <20060724085455.GD24299@merlin.emma.line.org>
	 <44C4813E.2030907@namesys.com>
	 <20060724102508.GA26553@merlin.emma.line.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hy1dBR9GcM+ZB2Rkbv6q"
Date: Mon, 24 Jul 2006 09:57:24 -0700
Message-Id: <1153760245.5735.47.camel@ipso.snappymail.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4-2mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hy1dBR9GcM+ZB2Rkbv6q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-24 at 12:25 +0200, Matthias Andree wrote:
> On Mon, 24 Jul 2006, Hans Reiser wrote:
>=20
> > >and that's the end
> > >of the story for me. There's nothing wrong about focusing on newer cod=
e,
> > >but the old code needs to be cared for, too, to fix remaining issues
> > >such as the "can only have N files with the same hash value".=20
> >
> > Requires a disk format change, in a filesystem without plugins, to fix =
it.
>=20
> You see, I don't care a iota about "plugins" or other implementation deta=
ils.
>=20
> The bottom line is reiserfs 3.6 imposes practial limits that ext3fs
> doesn't impose and that's reason enough for an administrator not to
> install reiserfs 3.6. Sorry.
>=20

And EXT3 imposes practical limits that ReiserFS doesn't as well. The big
one being a fixed number of inodes that can't be adjusted on the fly,
which was reason enough for me to not use EXT3 and use ReiserFS
instead.=20

Do you consider the EXT3 developers to have "abandoned" it because they
haven't fixed this issue? I don't, I just think of it as using the right
tool for the job.

I've been bitten by running out of inodes on several occasions, and by
switching to ReiserFS it saved one company I worked for over $250,000
because they didn't need to buy a totally new piece of software.

I haven't been able to use EXT3 on a backup server for the last ~5 years
due to inode limitations. Instead, ReiserFS has been filling that spot
like a champ.=20

The bottom line is that every file system imposes some sort of limits
that bite someone. In your case it sounds like EXT3 limits weren't an
issue for you, in my case they were. Thats life.=20

--=20
Mike Benoit <ipso@snappymail.ca>

--=-hy1dBR9GcM+ZB2Rkbv6q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBExPv0MhKjsejwBhgRApGXAJ0ZLb8PDVvRoTUCIBkwedpKy7qBKwCcCxIv
F71NjdfIZN13Wsr4UR755Tc=
=x4MO
-----END PGP SIGNATURE-----

--=-hy1dBR9GcM+ZB2Rkbv6q--

