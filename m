Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUFKTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUFKTGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUFKTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 15:06:49 -0400
Received: from smtp.golden.net ([199.166.210.31]:48145 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S264308AbUFKTGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 15:06:46 -0400
Date: Fri, 11 Jun 2004 15:06:39 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [4/12]
Message-ID: <20040611190639.GC12953@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>
References: <200406111755.02325.bzolnier@elka.pw.edu.pl> <20040611181106.GB12953@linux-sh.org> <200406112047.58373.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <200406112047.58373.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2004 at 08:47:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > sh will be making use of this as well for multiple drivers. Obviously we
> > can make this local to each driver though if that's going to be the
> > preferred approach.
>=20
> Currently it is used only by icside for storing DMA number
> from struct expansion_card.  What is the usage pattern on sh?
>=20
It's used for the DMA channel number, or NO_DMA for falling back on PIO.


--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAygK/1K+teJFxZ9wRAo5/AJ9d4y1zuog97m4ciypCQ+KklQpHlwCeItLz
Np+jqgKo6t6QveIxDfnxTkw=
=5cl0
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
