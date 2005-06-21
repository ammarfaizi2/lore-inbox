Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVFUUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVFUUKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVFUUI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:08:29 -0400
Received: from zlynx.org ([199.45.143.209]:27662 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262295AbVFUUGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:06:08 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Zan Lynx <zlynx@acm.org>
To: Robert Love <rml@novell.com>
Cc: Christoph Lameter <christoph@lameter.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1119382685.3949.263.camel@betsy>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy>
	 <Pine.LNX.4.62.0506211222040.21678@graphe.net>
	 <1119382685.3949.263.camel@betsy>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v1Wc/KRHSnEfWk997pEu"
Date: Tue, 21 Jun 2005 14:02:09 -0600
Message-Id: <1119384131.15478.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v1Wc/KRHSnEfWk997pEu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 15:38 -0400, Robert Love wrote:
> On Tue, 2005-06-21 at 12:22 -0700, Christoph Lameter wrote:
>=20
> > I noticed that select() is not working on real files. Could inotify=20
> > be used to fix select()?
>=20
> Select the system call?  It should work fine.   ;-)
>=20
> Who is confused?
>=20
> 	Robert Love

Sounds interesting.  tail -f could use it.  Instead of sleep 1, seek to
current position, read to eof; just select() for read on the file and
sleep in select() until someone else writes to that file. =20

I've never tried doing that.  It might work, for all I know.
--=20
Zan Lynx <zlynx@acm.org>

--=-v1Wc/KRHSnEfWk997pEu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuHJBG8fHaOLTWwgRApnSAJ9/uFgsoAhQpkJU68hhU44ox6/BFgCff7vD
3SmXnk4GNXGPItp+lzMfZnE=
=iITm
-----END PGP SIGNATURE-----

--=-v1Wc/KRHSnEfWk997pEu--

