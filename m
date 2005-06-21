Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVFUUSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVFUUSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVFUURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:17:10 -0400
Received: from zlynx.org ([199.45.143.209]:28942 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262305AbVFUUQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:16:11 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Zan Lynx <zlynx@acm.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Robert Love <rml@novell.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506211309300.22490@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy>
	 <Pine.LNX.4.62.0506211222040.21678@graphe.net>
	 <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost>
	 <Pine.LNX.4.62.0506211306060.22372@graphe.net>
	 <1119384473.3949.279.camel@betsy>
	 <Pine.LNX.4.62.0506211309300.22490@graphe.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YGU1oGPc3fZTqLnqQru+"
Date: Tue, 21 Jun 2005 14:15:27 -0600
Message-Id: <1119384927.15478.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YGU1oGPc3fZTqLnqQru+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 13:10 -0700, Christoph Lameter wrote:
> On Tue, 21 Jun 2005, Robert Love wrote:
>=20
> > > I was told that Linux cannot do this. It always returns the filehandl=
es as=20
> > > ready for disk files.
> >=20
> > Inotify would definitely work.
>=20
> Well we could use it in kernel to make select() work correctly. For disk=20
> files set up a notification for write and then only return from select if=
=20
> new data is available.

You could do it inside glibc.
--=20
Zan Lynx <zlynx@acm.org>

--=-YGU1oGPc3fZTqLnqQru+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuHVfG8fHaOLTWwgRAnOuAJ0R0gViYJPx73azTd21irRUdZQlyQCfdF2e
A+Y+ZnZi29+ajzwEXAZSQco=
=mvDU
-----END PGP SIGNATURE-----

--=-YGU1oGPc3fZTqLnqQru+--

