Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVFPBrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVFPBrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVFPBrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:47:12 -0400
Received: from downeast.net ([12.149.251.230]:996 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261674AbVFPBrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:47:06 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 21:44:55 -0400
User-Agent: KMail/1.8
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, mru@inprovide.com,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
References: <f192987705061303383f77c10c@mail.gmail.com> <20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm>
In-Reply-To: <42B0BAF5.106@poczta.fm>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1327223.c9iJ4j8BY0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506152144.56540.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1327223.c9iJ4j8BY0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 June 2005 07:34 pm, Lukasz Stelmach wrote:
> That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
> software that need not to be aware of unicodeness of the text it manages
> to handle it without any hickups *and* to store in the text information
> about multibyte characters.What characters exactly you do mean? NULL?
> There is no NULL byte in any UTF-8 string except the one which
> terminates it.

Bingo. Only the operating system itself and software displaying filenames=20
needs to understand Unicode; the file system implementation itself just kno=
ws=20
its a string of bytes and nothing else.

> I've tried cd packet writing with UDF and it gives insane overhead of
> about 20%. What metadata you'd like to store for example on your
> flashdrive or a floppy disk?

Uh, 20%? That sounds awfully high. You sure you didn't do something wrong?

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1327223.c9iJ4j8BY0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsNmY8Gvouk7G1cURAgEgAJwIHTyOfyzxUiysW/+CETM77eNnlACgrVok
n/z/n2UPUyy1/dYsjK6bHEY=
=743b
-----END PGP SIGNATURE-----

--nextPart1327223.c9iJ4j8BY0--
