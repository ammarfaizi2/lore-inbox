Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWEZRYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWEZRYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWEZRYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:24:05 -0400
Received: from amnesiac.heapspace.net ([195.54.228.42]:29459 "EHLO
	amnesiac.heapspace.net") by vger.kernel.org with ESMTP
	id S1750772AbWEZRYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:24:04 -0400
Date: Fri, 26 May 2006 20:24:02 +0300
From: Daniel Stone <daniel@fooishbar.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel design: support for multiple local users
Message-ID: <20060526172402.GJ16521@fooishbar.org>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910605260901h6452c795s1c40cf61b47fc69a@mail.gmail.com> <20060526163125.GI16521@fooishbar.org> <9e4733910605261012w1d470b11rbf120d5c0d0d1750@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <9e4733910605261012w1d470b11rbf120d5c0d0d1750@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2006 at 01:12:09PM -0400, Jon Smirl wrote:
> On 5/26/06, Daniel Stone <daniel@fooishbar.org> wrote:
> >On Fri, May 26, 2006 at 12:01:15PM -0400, Jon Smirl wrote:
> >> It is possible to set the current X server up to support this
> >> configuration. Using the X server this way has some drawbacks. The X
> >> server needs to be run as root.
> >
> >So far, so good.
> >
> >> The multiple users are sharing a
> >> single X server image so things they do can impact the other users.
> >
> >No, they're not.
>=20
> So if I manage to fault my X server process, they other users a just fine?

It's entirely possible, inasmuch as it's entirely possible for a rogue X
server to take out the entire machine.

When I said that each user's server was a separate process, I wasn't
making that bit up.

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEdzmyRkzMgPKxYGwRAjdZAJsHvDO4A6jNglsqBieITyikSuVHeQCgjHw6
usCFknNEbDV8pZwPVkRKgjg=
=F0+r
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
