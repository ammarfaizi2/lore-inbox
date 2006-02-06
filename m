Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWBFTbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWBFTbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWBFTbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:31:18 -0500
Received: from mx.laposte.net ([81.255.54.11]:63964 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932309AbWBFTbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:31:17 -0500
Subject: Re: Linux drivers management
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: yarick@it-territory.ru
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c0V8gwI2QGdJkenkVlLp"
Organization: Adresse perso
Date: Mon, 06 Feb 2006 20:30:21 +0100
Message-Id: <1139254221.20009.43.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c0V8gwI2QGdJkenkVlLp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Hi,
> On 6 February 2006 21:31, Nicolas Mailhot wrote:
> >=20
> >=20
> > Since you invoke end-users I'll answer.
> >=20
> > This end-user is mad at hell at people like you that advocate separatin=
g
> > drivers from mainline.
> Huh...
> > Do you really think us end-users enjoy hunting your drivers all over th=
e
> > net because you never bothered pushing them to mainline ?
> He don't needs to "bother".

Sometimes yes.
But even in these cases if *he* does not want to merge in mainline *he*
needn't invoke end-user wishes to justify himself. (I didn't answer its
other points. I *did* answer the "end-users want drivers to be separate"
bit)

> He wrote the drivers. And you never paid him.

If he was paid or helped by the hardware manufacturer to write the
driver I *did* pay him

> (Take it, "this software is beer-free" overusers, straight in your face).
> >=20
> [Loads of "I'm actually proving his point, but I want to be in mainstream=
, so..." \
> skipped] You have just nicely proved all the stable API pros.=20

Nah.
I've just proved taking drivers out-of-tree only pushes problems to
end-users. You are right when drivers are in mainline some of the burden
is reported to driver writers only:

1. they have the free support of other kernel people (reviews,
mentoring, adaptations to some kernel changes)
2. they have the free support of the kernel infrastructure (issue
system, mailing lists, hosting, testing)
3. they have the free support of distributions that package their
changes automatically
4. they can actually influence the decisions that will change the kernel
bits they depend on (just by being their their code is taken into
account)
5. they have tools knowledge and docs to deal with it
6. they are focused on their drivers while end-users have a whole system
to care about and little time to master each of its parts

And anyway do you really think a poll which asks end-users whether they
want stuff to be done by device writers or by themselves will find a
majority for "push problems to users" motions ?

The original assertion I responded to being "users clamour for
out-of-tree drivers"

You may want kernel rules change to accommodate your activity as driver
writer (just guessing, you're not answering like a user). Only :
1. do not hide between end-users you won't find them sympathetic to your
cause. Especially if you try to make them hostage to your claims.
2. the rules where written by a boatload of other kernel people so I
doubt they'd be so hard on you if you tried to follow them

--=20
Nicolas Mailhot

--=-c0V8gwI2QGdJkenkVlLp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkPno8sACgkQI2bVKDsp8g317gCePQt84r2D0I2zwdEChQOXTybi
voAAoLayYiGfuZh32XxI2NfHkVsE0h9L
=DqrQ
-----END PGP SIGNATURE-----

--=-c0V8gwI2QGdJkenkVlLp--

