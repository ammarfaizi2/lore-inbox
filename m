Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVFQIv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVFQIv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFQIv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:51:26 -0400
Received: from downeast.net ([12.149.251.230]:14016 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261923AbVFQIvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:51:16 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Fri, 17 Jun 2005 04:49:33 -0400
User-Agent: KMail/1.8
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <200506162118.18470.pmcfarland@downeast.net> <yw1xekb1xuk9.fsf@ford.inprovide.com>
In-Reply-To: <yw1xekb1xuk9.fsf@ford.inprovide.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1442359.KqoQES1IUI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506170450.12943.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1442359.KqoQES1IUI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 June 2005 04:21 am, M=E5ns Rullg=E5rd wrote:
> Patrick McFarland <pmcfarland@downeast.net> writes:
> > On Thursday 16 June 2005 11:04 am, Lennart Sorensen wrote:
> >>  Most people seem happy with 50 or so being a good limit even though
> >> many systems support much longer.
> >
> > 50 characters or 50 bytes? Because in the case of UTF-8, if you do a lot
> > of three byte characters (which require four bites to encode), 50 bytes
> > is very short.
>
> What do you mean by three-byte characters requiring four bytes to
> encode?  Is a three-byte character not a character encoded using three
> bytes?

(implication of utf8 and not utf16 goes here)

Very few Unicode characters require three bytes, instead of the usual one o=
r=20
two.

=46or one byte you just have the byte.=20

=46or two bytes, you really have three: a control code stating "the followi=
ng=20
two bytes are a two byte character", and then the two bytes.=20

=46or three bytes, you really have four bytes: a control code stating "the=
=20
following three bytes are a three byte character" and then the three bytes.

Unless I've completely misunderstood the Unicode specification, this is wha=
t=20
is going on.

> As for 50 bytes being too short, many of the multibyte characters are
> equivalent to several English characters, so fewer of them are
> required.  You have a point, though.

Any English characters (ie, the first 127 ascii characters) map directly to=
=20
the first 127 Unicode characters (if thats what you meant).

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1442359.KqoQES1IUI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCso7E8Gvouk7G1cURArv5AJ9SLc2qCf/OBsfsaB9r27naPS7eJwCcC8DC
ayjVmC5PrwILsRdXklkia9k=
=g0Hg
-----END PGP SIGNATURE-----

--nextPart1442359.KqoQES1IUI--
