Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIERhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIERhd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUIERhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 13:37:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266894AbUIERhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 13:37:19 -0400
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
References: <413AA7B2.4000907@yahoo.com.au>
	 <20040904230210.03fe3c11.davem@davemloft.net>
	 <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au>
	 <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gBFueCUhQyrMDSObYYqC"
Organization: Red Hat UK
Message-Id: <1094405830.2809.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 19:37:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gBFueCUhQyrMDSObYYqC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-05 at 19:24, Linus Torvalds wrote:
> On Sun, 5 Sep 2004, Nick Piggin wrote:
> >=20
> > Hmm, and the crowning argument for not stopping at order 3 is that if w=
e
> > never use higher order allocations, nothing will care about their water=
marks
> > anyway. I think I had myself confused when that question in the first p=
lace.
> >=20
> > So yeah, stopping at a fixed number isn't required, and as you say it k=
eeps
> > things general and special cases minimal.
>=20
> Hey, please refute my "you need 20% free" to get even to order-3 for most
> cases first.
>=20
> It's probably acceptable to have a _very_ backgrounded job that does
> freeing if order-3 isn't available, but it had better be pretty
> slow-moving, I suspect. On the order of "It's probably ok to try to aim
> for up to 25% free 'overnight' if the machine is idle" but it's almost
> certainly not ok to aggressively push things out to that degree..

well... we have a reverse mapping now. What is stopping us from doing
physical defragmentation ?


--=-gBFueCUhQyrMDSObYYqC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBO07FxULwo51rQBIRAkhTAKCRUI8TVsSPkr894h/GVNPCG1uR2ACeOrFx
B27Xlikn4ADanXmjsAub4K8=
=gNLr
-----END PGP SIGNATURE-----

--=-gBFueCUhQyrMDSObYYqC--

