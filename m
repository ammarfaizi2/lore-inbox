Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVEKBD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVEKBD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEKBCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:02:44 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:55529 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261992AbVEKBCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:02:14 -0400
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
	cleanup)
From: Tom Duffy <tduffy@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
In-Reply-To: <20050510172913.2d47a4d4.akpm@osdl.org>
References: <20050510161657.3afb21ff.akpm@osdl.org>
	 <20050510.161907.116353193.davem@davemloft.net>
	 <20050510170246.5be58840.akpm@osdl.org>
	 <20050510.170946.10291902.davem@davemloft.net>
	 <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
	 <20050510172913.2d47a4d4.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sd1HRn71Eek95AvhOnMI"
Date: Tue, 10 May 2005 18:01:03 -0700
Message-Id: <1115773263.3169.5.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sd1HRn71Eek95AvhOnMI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-10 at 17:29 -0700, Andrew Morton wrote:
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > I'll need time to do this - no matter how you cut it there are a lot of=
=20
> >  files, and a lot of lines - so don't expect the patch bombing to start=
 for=20
> >  the next few weeks.
> >  And before I embark on this venture I'd like some feedback that when I=
 do=20
> >  turn up with patches they'll have a resonable chance of getting merged=
 -=20
> >  this is going to be a lot of boring work, and with no commitment to me=
rge=20
> >  anything it's not something I want to waste days on...  Sounds fair?

Solaris build makes sure files passes a "lint" test during the build and
nothing can be checked in until such a test can pass.

Would it make sense to add such a test during kernel compile for Linux?
Something that could be turned off if somebody needed really fast
builds.  This would check for things like whitespace violations and
other things that violate CodingStyle.

People tend to fix things quick if they break the build.

-tduffy

--=-Sd1HRn71Eek95AvhOnMI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCgVlPdY502zjzwbwRAiakAJ4pfqUC/VsUQRv8JGxLRPvB0dQQIACeNVma
JmEGy9t5zKHcpRY42Jw65Xo=
=LWcZ
-----END PGP SIGNATURE-----

--=-Sd1HRn71Eek95AvhOnMI--
