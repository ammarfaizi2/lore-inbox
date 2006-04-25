Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWDYP1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWDYP1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWDYP1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:27:38 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:48285
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751226AbWDYP1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:27:37 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "marty fouts" <mf.danger@gmail.com>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 17:32:15 +0200
User-Agent: KMail/1.9.1
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
In-Reply-To: <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, "Kyle Moffett" <mrmacman_g4@mac.com>
MIME-Version: 1.0
Message-Id: <200604251732.15494.mb@bu3sch.de>
Content-Type: multipart/signed;
  boundary="nextPart4986875.zBA9ySxkhK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4986875.zBA9ySxkhK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 April 2006 23:50, you wrote:
> Oh, and yeah, a =3D b + c *is* more readable than
>=20
> a =3D malloc(strlen(b) + strlen(c));
> strcpy(a,b);
> strcat(a,c);
>=20
> and contains fewer bugs ;)

and a hidden memory allocation.
Which GFP flag would you use for the allocation?
(And how would you actually _pass_ it)
GFP_KERNEL? Good luck, if you see a
a =3D b + c;
in atomic context.
GFP_ATOMIC? Well, we both don't want that.
Checking is_atomic() and deciding upon that?
I call that overhead... .

=2D-=20
Greetings Michael.

--nextPart4986875.zBA9ySxkhK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBETkD/lb09HEdWDKgRAlLHAJ41QOXDaNlUK1USouoxC0urdfOLUgCeItF3
IxuatjkeEnRqpEvLH8pJfdE=
=c628
-----END PGP SIGNATURE-----

--nextPart4986875.zBA9ySxkhK--
