Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUKUBYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUKUBYD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUKUBYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:24:03 -0500
Received: from dreamcraft.com.au ([202.55.152.18]:60289 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S261270AbUKUBX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:23:58 -0500
Date: Sun, 21 Nov 2004 12:23:53 +1100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041121012353.GA4008@himi.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20041119174405.GE20162@kroah.com>
User-Agent: Mutt/1.5.6+20040722i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2004 at 09:44:05AM -0800, Greg KH wrote:
> On Tue, Nov 16, 2004 at 04:49:43PM +0100, Roger Luethi wrote:
> > generic_startup in visor.c was not called for some hardware, resulting
> > in attempts to access memory that had never been allocated, which in
> > turn caused the problem several people reported with recent (2.6.10ish)
> > kernels.
> >=20
> > Signed-off-by: Roger Luethi <rl@hellgate.ch>
>=20
> Thanks for finding this.
>=20
> Applied.
>=20
This patch fixes the oops, but after applying it I can no longer
sync my palm 5 - it starts, but part way through the connection is
lost.

I can sync perfectly with 2.9.10-rc1.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBn+4pQPlfmRRKmRwRAoNMAJ9+0cEEsUpUHieFo2AzLq5DCSENTwCeLeJ6
henz/iogiOJuuglySIYlIac=
=WU34
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
