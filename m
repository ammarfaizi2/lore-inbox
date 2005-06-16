Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVFPBxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVFPBxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVFPBxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:53:24 -0400
Received: from downeast.net ([12.149.251.230]:46820 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261701AbVFPBxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:53:01 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 21:52:01 -0400
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f192987705061303383f77c10c@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain> <f192987705061513503afb73cb@mail.gmail.com>
In-Reply-To: <f192987705061513503afb73cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10977259.EhfRPQFGee";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506152152.02840.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10977259.EhfRPQFGee
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 June 2005 04:50 pm, Alexey Zaytsev wrote:
> On 13/06/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > That said it ought to be possible to use the stackable fs work (FUSE
> > etc) to write a layer you can mount over any fs that does NLS
> > translation.
>
> Now I quite agree that it isn't a Great Idea to do such conversion in
> the kernel, but the problem still remains and there is no other place
> we can do it. I belive that it should be done now and removed after
> the world finishes to move to utf. Maybe it should not be applyed to
> the main kernel tree, but I'm sure that at least Russian linux
> distributions will like it.

I partially agree. I think no userland application should have access to th=
e=20
un-'fixed' file names; they should be fed only Unicode to prevent the sprea=
d=20
and acceptance of out of date encodings.

=46orcing users to do smart things is often the only way to make them do sm=
art=20
things, and the lack of acceptance of Unicode on Linux in the wild seems to=
=20
be the only way.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart10977259.EhfRPQFGee
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsNtC8Gvouk7G1cURAjUkAJ9QttNU3jHa0rE8i+sgi4VYlXsInACfVxls
zf1heya8HoEYgzhl+fr5Di8=
=LhBp
-----END PGP SIGNATURE-----

--nextPart10977259.EhfRPQFGee--
