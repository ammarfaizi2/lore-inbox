Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTH2SwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTH2SvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:51:13 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:49062 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261649AbTH2StM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:49:12 -0400
Date: Fri, 29 Aug 2003 11:49:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20030829184910.GB10336@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.GSO.4.44.0308182205400.17736-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308182205400.17736-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2003 at 10:12:43PM +0300, Meelis Roos wrote:

> I tried 2.6.0-test3 + todays BK on a Motorola Powerstack (Utah II, 300
> MHz 604e). It's basically a PReP machine from Motorola.
>=20
> 2.4.22-rc2 works well. 2.6.0-test3+latest bk fails in 2 places.
>=20
> 1. Network interface is detected correctly but first ifconfig command
> (even if it fails because of wrong arguments) hangs the machine. This is
> with both tulip driver (new io+mmio or mmio or just plain pio, 3 modes
> tried) and de4x5 driver (the card is a onboard 21140).
>=20
> 2. 2.4 detects full 64M of RAM, 2.6 detects only 32M of RAM.

Interesting.  Can you try the linuxppc_2_4_devel
(http://penguinppc.org/dev/kernel.shtml) tree and let me know if that
finds 32mb or 64mb of RAM?

--=20
Tom Rini
http://gate.crashing.org/~trini/

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/T6AmdZngf2G4WwMRAiLGAJ4i38P4GVBATLDs3yOvkgdYYLgAwACeLSpf
QzY2t5b5GcCARMfNqhCdsjo=
=zcn5
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
