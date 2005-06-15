Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFOIzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFOIzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFOIzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:55:35 -0400
Received: from downeast.net ([12.149.251.230]:23767 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261319AbVFOIzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:55:22 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 04:54:02 -0400
User-Agent: KMail/1.8
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>
In-Reply-To: <42AFE624.4020403@poczta.fm>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7999414.x7bqqeETVd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506150454.11532.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7999414.x7bqqeETVd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 June 2005 04:26 am, Lukasz Stelmach wrote:
> M=C3=A5ns Rullg=C3=A5rd napisa=C5=82(a):
> > I use utf-8 exclusively for my filenames (the few that are not 7-bit
> > ascii).  Forcing others who use the system to do the same would cause
> > them a lot of trouble, as they must transfer files to and from Windows
> > machines that use anything but utf-8.
>
> But VFAT (and NTFS???) use unicode, i.e. UTF-16 (???). AFAIK

No, VFAT and NTFS use an 8-bit encoding, and I think its only NTFS5 that is=
=20
forced to only use UTF-8 as the encoding (vfat can use any 8-bit encoding,=
=20
and NTFS4 afaik can as well, and I don't think NTFS5 uses UTF-16 internally=
),

=46orcing people to use unicode isn't a bad thing btw, especially since it =
is a=20
culture agnostic encoding that can represent wide characters (eg. from Asia=
n=20
languages) in a uniform manner*, and allowing to use multiple languages (eg=
=2E=20
Chinese and Japanese) at once without needing to switch encodings.

This also means it fixes the 'bug' where you have multiple encodings for th=
e=20
same language (ie. JIS, SJIS, and EUC_JP; similarly, simplified Chinese has=
 5=20
popular encoding methods, and traditional Chinese as three), which allows=20
easier sharing of data between users without needing to muck with encoding.

* Unicode can do so in UTF-8 as well as UTF-16 to describe the entire 20-bi=
t=20
space.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart7999414.x7bqqeETVd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCr+yz8Gvouk7G1cURAucUAJ4sn29KTigKGC2b0f5x9lbwN9waOwCdEJXH
BPtOiB5TG+KVgN/7eapKNX0=
=qRJD
-----END PGP SIGNATURE-----

--nextPart7999414.x7bqqeETVd--
