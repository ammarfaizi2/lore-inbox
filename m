Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVFPB4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVFPB4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVFPB4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:56:05 -0400
Received: from downeast.net ([12.149.251.230]:6373 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261702AbVFPBz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:55:57 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 21:55:04 -0400
User-Agent: KMail/1.8
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-kernel@vger.kernel.org
References: <f192987705061303383f77c10c@mail.gmail.com> <200506151213.44742.vda@ilport.com.ua>
In-Reply-To: <200506151213.44742.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2539200.gc0paBJE4W";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506152155.05865.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2539200.gc0paBJE4W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 June 2005 05:13 am, Denis Vlasenko wrote:
> I do not understand how this is going to look from userspace perspective.
> Can you give examples how this will work?

IMHO, he means that the userspace would only see Unicode filenames, and the=
=20
userspace could only give Unicode names back to the kernel. The kernel, usi=
ng=20
this global NLS layer would translate back and forth, and the userland=20
wouldn't know about it.

Its basically the only sane way to approach the problem of getting the enti=
re=20
Linux community to convert to Unicode.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart2539200.gc0paBJE4W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsNv58Gvouk7G1cURAoAhAJ0fsJHeGv0XyoWKpjSAaWvXBNxHbQCgr0IA
bWm7JSiNT3XARCVJB86IrlI=
=ps2z
-----END PGP SIGNATURE-----

--nextPart2539200.gc0paBJE4W--
