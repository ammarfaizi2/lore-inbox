Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267621AbUBTBMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUBTBLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:11:49 -0500
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:45841 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S267626AbUBTBIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:08:51 -0500
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
From: Paul Wagland <paul@wagland.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Tridge <tridge@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	 <20040219163838.GC2308@mail.shareable.org>
	 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	 <20040219182948.GA3414@mail.shareable.org>
	 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
	 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
	 <20040219204853.GA4619@mail.shareable.org>
	 <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
	 <20040220000054.GA5590@mail.shareable.org>
	 <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
	 <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fKRkDd2lImlix44hmEdV"
Message-Id: <1077239219.12565.1.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 02:07:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fKRkDd2lImlix44hmEdV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-20 at 01:24, Linus Torvalds wrote:

> That said, who actually _uses_ dnotify? The only time dnotify seems to=20
> come up in discussions is when people complain how badly designed it is,=20
> and I don't think I've ever heard anybody say that they use it and=20
> that they liked it ;)

Well, in the desktop land both kde and gnome use fam, and fam can use
dnotify as it's backend to watch files. Server side, courier can use fam
as well, so although there are not a lot of programs that use dnotify
directly, there are a lot that can use it indirectly, and will fall back
to polling on a non-dnotify system. I don't know if the famd people like
it or not though ;-)

Cheers,
Paul


--=-fKRkDd2lImlix44hmEdV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBANV2ztch0EvEFvxURAuKBAKClsSCHdmeZha/r1yO+srbx2wUBbQCgmUbU
fuDRVbnVfG/vC0xpp+xnKlY=
=pDsK
-----END PGP SIGNATURE-----

--=-fKRkDd2lImlix44hmEdV--

