Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbUCYXA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUCYW57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:57:59 -0500
Received: from 66-194-152-191.gen.twtelecom.net ([66.194.152.191]:40912 "EHLO
	pico.surpasshosting.com") by vger.kernel.org with ESMTP
	id S263664AbUCYWzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:55:00 -0500
Date: Thu, 25 Mar 2004 16:54:23 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: debian-devel@lists.debian.org
Cc: Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040325225423.GT9248@cheney.cx>
Mail-Followup-To: debian-devel@lists.debian.org,
	Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de> <20040325082949.GA3376@gondor.apana.org.au> <20040325220803.GZ16746@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bxF9Dep5HzwGj9mC"
Content-Disposition: inline
In-Reply-To: <20040325220803.GZ16746@fs.tum.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bxF9Dep5HzwGj9mC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2004 at 11:08:03PM +0100, Adrian Bunk wrote:
> There's another issue with these files:
>=20
<--  snip  -->
>=20
> The GPL says that you must give someone receiving a binary the source=20
> code, and it says:
>   The source code for a work means the preferred form of the work for
>   making modifications to it.
>=20
>=20
> This is perhaps a bit besides the main firmware discussion and IANAL,=20
> but is this file really covered by the GPL?

IMHO code that can be compiled would probably be the preferred form
of the work. The source to the firmware in many cases and probably even
this one is very unlikely to be able to be compiled under Linux at all.
Also, unless the driver is written by the company producing the hardware
itself even the author will likely not have the source code to the
firmware and will only have a binary form (think reverse engineering).
IMHO a driver for a piece of hardware does not include the software that
the hardware itself is running, just the software that the primary CPU
itself is running. YMMV.

Chris

--bxF9Dep5HzwGj9mC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY2Mf0QZas444SvIRAt/RAJ4wmdbSFqS0+T+bxYMBuPSHYvlAcACeJMJQ
oOO838b5qQG2dugQV2sEu28=
=BTod
-----END PGP SIGNATURE-----

--bxF9Dep5HzwGj9mC--
