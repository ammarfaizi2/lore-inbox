Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUIONbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUIONbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUIONap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:30:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265489AbUION3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:29:19 -0400
Date: Wed, 15 Sep 2004 15:29:04 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-ID: <20040915132904.GA30530@devserv.devel.redhat.com>
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net> <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org> <1094405830.2809.8.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org> <20040915132712.GA6158@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20040915132712.GA6158@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2004 at 03:27:12PM +0200, J=F6rn Engel wrote:
> On Sun, 5 September 2004 10:58:07 -0700, Linus Torvalds wrote:
> > On Sun, 5 Sep 2004, Arjan van de Ven wrote:
> > >=20
> > > well... we have a reverse mapping now. What is stopping us from doing
> > > physical defragmentation ?
> >=20
> > Nothing but replacement policy, really, and the fact that not everything
> > is rmappable.
>=20
> What about pointers?  I have an ethernet driver that hands pointers to
> physical memory pages to hardware.  Would be fun if someone
> defragmented those pages. ;)

if you haven't pinned those pages then you have lost already.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBSEOgxULwo51rQBIRAmsAAJ0RClG9gZA53bBEKcicH9iJPgC20gCff2tE
J31kS7uh6UKGQs3DKgnUiLA=
=sCyb
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
