Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131831AbRCXVwr>; Sat, 24 Mar 2001 16:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRCXVw1>; Sat, 24 Mar 2001 16:52:27 -0500
Received: from t2.redhat.com ([199.183.24.243]:5368 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131831AbRCXVwT>; Sat, 24 Mar 2001 16:52:19 -0500
Date: Sat, 24 Mar 2001 21:51:02 +0000
From: Tim Waugh <twaugh@redhat.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010324215102.R1469@redhat.com>
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>, <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>; <20010323235909.C3098@werewolf.able.es> <3ABBED86.3B7ED60B@uow.edu.au> <20010324015515.C10781@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="sxKBPtypMsgSHGIi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010324015515.C10781@werewolf.able.es>; from jamagallon@able.es on Sat, Mar 24, 2001 at 01:55:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sxKBPtypMsgSHGIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 24, 2001 at 01:55:15AM +0100, J . A . Magallon wrote:

>=20
> On 03.24 Andrew Morton wrote:
> > "J . A . Magallon" wrote:
> > >=20
> > >  The same is with that ugly out: at the end
> > > of the function. Just change all that 'goto out' for a return.
> >=20
> > Oh no, no, no.  Please, no.
> >=20
> > Multiple return statements are a maintenance nightmare.
> >=20
>=20
> Well, I do not want this to restart a religion war.
>=20
> The real thing is: gcc 3.0 (ISO C 99) does not like that practice
> (let useless things there for someday using them ?).

The GCC warning has nothing to do with the (good) practice of having a
single exit point.  It is the difference between this:

=2E..
out:
}

and this:

=2E..
out:
	return;
}

I think that the latter looks better, and the C standard says that
it's also the only one that's correct.

You are the one arguing about coding religion, by saying that
_neither_ of them is any good.

Tim.
*/

--sxKBPtypMsgSHGIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6vRbFONXnILZ4yVIRAi+FAKCe7UzzwcZeULwbQpRFE6enpyCnigCeKQMw
gbiqb3CgtHT6HgiI4ZS00Cs=
=4OC7
-----END PGP SIGNATURE-----

--sxKBPtypMsgSHGIi--
