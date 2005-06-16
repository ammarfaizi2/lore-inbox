Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVFPBn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFPBn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVFPBn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:43:29 -0400
Received: from downeast.net ([12.149.251.230]:45283 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261624AbVFPBnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:43:22 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 21:42:00 -0400
User-Agent: KMail/1.8
Cc: Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
References: <f192987705061303383f77c10c@mail.gmail.com> <42B04090.7050703@poczta.fm> <20050615212825.GS23621@csclub.uwaterloo.ca>
In-Reply-To: <20050615212825.GS23621@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10087837.Qcm0npPvv8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506152142.02178.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10087837.Qcm0npPvv8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 June 2005 05:28 pm, Lennart Sorensen wrote:
> What do you do if the underlying filesystem can not store some unicode
> characters that are allowed on others?

Um, thats impossible, unless you're implying something like the file system=
=20
not being 8-bit safe. The only thing UTF-8 does is store data in bytes, it=
=20
doesn't need any real support from the file system.

> > It depend's on what it is used for. It is very good fs for removable
> > media. None of linux native filesystems is good for this because of
> > different uids on different machines. Since VFAT uses unicode it is
> > possible to see the filenames properly on systems using different
> > codepages for the same language (1:1 is possible).

> VFAT uses unicode?  I thought it used the same codepage silyness as FAT
> did, since after all ti was just supposed to be a long filename
> extension to FAT.  Do they use unicode in the long filenames only?

I mentioned earlier that VFAT uses 8-bit encodings, none of them (supported=
 by=20
Windows, at least) are Unicode.

> I think UDF is a better filesystem for many types of media since it is
> able to me more gently to the sectors storing the meta data than VFAT
> ever will be.

I agree. UDF is the true successor to the portable media throne.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart10087837.Qcm0npPvv8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsNjq8Gvouk7G1cURAgNBAKCIzsssZcIn//fCVm83YI1OYOKIFQCgwjhJ
53NQuS5/39Izb1vYOjBXMG0=
=Tj00
-----END PGP SIGNATURE-----

--nextPart10087837.Qcm0npPvv8--
