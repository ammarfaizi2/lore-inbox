Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTGCVbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbTGCVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:31:15 -0400
Received: from mx02.qsc.de ([213.148.130.14]:55451 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265403AbTGCVbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:31:14 -0400
Date: Thu, 3 Jul 2003 23:49:21 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703214921.GM4266@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk> <20030703151529.B20336@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Content-Disposition: inline
In-Reply-To: <20030703151529.B20336@flint.arm.linux.org.uk>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.73-bk7-O1int0307021808  i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2003 at 03:15:29PM +0100, Russell King wrote:
> Ok, Wiktor has tried removing these 6 patches, and his problem persists.
> According to bk revtool, these 6 patches are the only changes which
> went in for to pcmcia from .73 to .74.
>=20
> If anyone else is having similar problems, they need to report them so
> we can obtain more data points - I suspect some other change in some other
> subsystem broke PCMCIA for Wiktor.
>=20
> Wiktor - short of anyone else responding, you could try reversing each
> of the nightly -bk patches from .74 to .73 and work out which set of
> changes broke it.

it broke with the 2.5.73-rc2 patch. I assume it was:

ChangeSet@1.1348.20.5, 2003-06-23 23:52:55+01:00,
rmk@flint.arm.linux.org.uk
  [SERIAL] 8250_cs update - incorporate pcmcia-cs 3.1.34 serial_cs fixes

--=20
Regards,

Wiktor Wodecki

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BKTh6SNaNRgsl4MRAjzLAJ9jHz0hNLsG0PAK6Ve3R24Rep+yFQCgqpfG
DiE1N5dCut6ve3f51T9oflY=
=VGZX
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
