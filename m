Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVLPQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVLPQXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVLPQXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:23:50 -0500
Received: from mout1.freenet.de ([194.97.50.132]:56975 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750716AbVLPQXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:23:50 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 17:23:19 +0100
User-Agent: KMail/1.8.3
References: <20051215212447.GR23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
In-Reply-To: <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, arjan@infradead.org, Diego Calleja <diegocg@gmail.com>
MIME-Version: 1.0
Message-Id: <200512161723.19965.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart4834720.4iaFcoEkKL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4834720.4iaFcoEkKL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 16 December 2005 16:49, you wrote:
> > and leaves time for the broadcom driver developers to finish, merge =20
> > and push to the distributions their driver
>=20
> It's working partially now.  This is the time when we should really =20
> try to force ndiswrapper junkies over to the driver to get it tested =20
> and bugfixed for inclusion.

Partially means:
=2D Connections on CCK Rates (802.11b) are stable,
  if the signal quality is good (you are close to the AP).
=2D No encryption support, yet (I am working on it, but it's
  a bit difficult)

Now, I want to test bcm43xx on 4k stacks. But only have a
ppc32 machine with such a broadcom card. ppc32 has 8k stacks.
How am I supposed to test the driver for 4kstack conformance?
Given this, why aren't there people working on 4kstacks for
ppc32? Is it not needed there, or did simply nobody care to
do this now?
Thanks for your nonflaming suggestions. ;)

=2D-=20
Greetings Michael.

--nextPart4834720.4iaFcoEkKL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDoun3lb09HEdWDKgRAndbAKCjycCdzCcB5ncfsMjE4FwGLuOG4gCgr2+S
eZQjf1GmI0tzVhWaE4xBcMc=
=wpuI
-----END PGP SIGNATURE-----

--nextPart4834720.4iaFcoEkKL--
