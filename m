Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVFPBts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVFPBts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVFPBts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:49:48 -0400
Received: from downeast.net ([12.149.251.230]:15332 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261699AbVFPBti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:49:38 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 21:49:05 -0400
User-Agent: KMail/1.8
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain>
In-Reply-To: <1118690448.13770.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3260359.ZKZrSuiHNa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506152149.06367.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3260359.ZKZrSuiHNa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 13 June 2005 03:20 pm, Alan Cox wrote:
> An ext3fs is always utf-8. People might have chosen to put other
> encodings on it but thats "not our fault" ;)

What happens if you 'field upgrade' ext2 to ext3 by adding a journal? That=
=20
doesn't magically convert !utf-8 to utf-8.

> There are some good technical reasons too
>
> Encodings don't map 1:1 - two names may cease to be unique

Hold up. Unless the original encoding is 'wrong' and has two mapped charact=
ers=20
that, in reality, are the same character, no such uniqueness should stop.=20
(This implies the encoding that we switched to 'fixed' said 'bug')

> Encodings vary in length - image a file name that is longer than the
> allowed maximum on your system with your encoding choice - that could
> occur with KOI8-R to UTF-8 I believe

Thats a fault of the file system design, not of the encoding. File systems=
=20
should not have very short filenames.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart3260359.ZKZrSuiHNa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsNqS8Gvouk7G1cURAkwcAJ9slsQVw7/MdAJy/FuaTyrvhW1m9ACdEhMh
wWbUbmus3O9DeikuzKm4pPY=
=nvib
-----END PGP SIGNATURE-----

--nextPart3260359.ZKZrSuiHNa--
