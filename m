Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVCYWQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVCYWQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVCYWQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:16:40 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.34]:60342 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261836AbVCYWPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:15:41 -0500
Date: Sat, 26 Mar 2005 00:15:40 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325221540.GE4192@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com> <20050325195826.GC4192@linux-sh.org> <20050325202508.A12715@flint.arm.linux.org.uk> <20050325205603.GD4192@linux-sh.org> <20050325210357.D12715@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20050325210357.D12715@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2005 at 09:03:57PM +0000, Russell King wrote:
> > It would be trivial to treat them both as foobar0 and have the
> > registration succeed for whoever gets it first, but I could see that th=
is
> > would be problematic in the serial8250 case. On the other hand, this is
> > then serial8250's problem.
>=20
> Thank you for ignoring the other case of i82385 to justify your point
> of view of it being just a single driver problem.
>=20
I didn't ignore it, I said that this was useful for anything that had
device names ending in numbers. The above was just in reply to what you
had pointed out about the serial8250 behaviour. Thank you for missing the
point though.

> Maybe you can work out a patch to fix up this mess?
>=20
Yes, I'll hack something together in the morning.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCRI2M1K+teJFxZ9wRAu8qAJwIjF4a2ElXyPRLJdGAK6zghQ0LnQCeLQu9
TNvHlm9NJFSHxJFRSwSuqxA=
=OcCf
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
