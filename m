Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbULYPrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbULYPrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbULYPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:47:15 -0500
Received: from mithrin.mh57.de ([217.160.185.21]:13721 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S261524AbULYPrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:47:11 -0500
Date: Sat, 25 Dec 2004 16:46:59 +0100
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10, lockup on lvrename of a snapshot volume
Message-ID: <20041225154659.GF26392@mh57.de>
References: <41CD8438.10207@tomt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <41CD8438.10207@tomt.net>
User-Agent: Mutt/1.5.6+20040907i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "mithrin.mh57.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Sat, Dec 25, 2004 at 04:16:08PM +0100, Andre Tomt
	wrote: > device-mapper snapshots lock up the kernel if you lvrename the
	snapshot > volume. The original volume has to be mounted for this to
	happen. [...] > LVM2 version is 2.00.24 (Debian Sarge userland), kernel
	2.6.10 from > kernel.org. It has been reported that this affects 2.6.9
	also, but I > have not verified this myself. [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	2.5 AWL                    AWL: Auto-whitelist adjustment
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 25, 2004 at 04:16:08PM +0100, Andre Tomt wrote:
> device-mapper snapshots lock up the kernel if you lvrename the snapshot=
=20
> volume. The original volume has to be mounted for this to happen.
[...]
> LVM2 version is 2.00.24 (Debian Sarge userland), kernel 2.6.10 from=20
> kernel.org. It has been reported that this affects 2.6.9 also, but I=20
> have not verified this myself.

I experienced the same with 2.6.9-rc2-mm4 (also running Sarge). The
system runs fine, but the lvrename process gets stuck and the lvm
subsystem isn't working properly after, a reboot is required.

LLAP, Martin

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBzYtzmGb6Npij0ewRAmA7AJwPr7c9zqZoL/W9EbCtK1L1zKWIMgCgj3yK
yQxwmEZ0NCoDJR2vJCobeqA=
=ickr
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
