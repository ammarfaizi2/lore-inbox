Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUAON4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUAON4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:56:16 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:40461 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265101AbUAON4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:56:12 -0500
Date: Thu, 15 Jan 2004 07:56:10 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: more on UMSDOS
Message-ID: <20040115135610.GA19462@dbz.icequake.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I did some more experimenting along the lines of my previous post ("some
UMSDOS issues").

I verified that the 2.2.19 kernel from ZipSlack 8.0 at least finds init
and starts running startup scripts like it should within the 9.1 setup,
so there is nothing wrong with the installation.

I also verified that the files 2.4.24 claims is missing (/etc/rc.d/rcS,
/sbin/agetty, et.al) actually do exist in the filesystem.

Slack 9.1 ships with 2.4.18, which I tried first, and it as well as
2.4.24 produce the same results; unable to find files that clearly exist
in the UMSDOS filesystem.

I find it hard to believe that ZipSlack 9.1 would have shipped broken.
More likely, some strange interaction with my system is happening:
AMD 386DX-40
16MB RAM
2G Quantum ATA HD
ISA IDE & I/O controller
S3 928 2MB ISA video
1.44MB & 360k fdds
SB16 SCSI-2 w/2X SCSI CD
NE2000 at 0x280 irq 3

It all works fine with ZipSlack 8.0 which ships with a 2.2.19 kernel,
and that 2.2.19 kernel used in ZipSlack 9.1 gets the boot process past
the part where it can't find files with the 2.4.18 and 2.4.24 kernels.

any ideas?

--=20
Ryan Underwood, <nemesis@icequake.net>

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABpv6IonHnh+67jkRAoGKAJ4zTzUy+vWijYggzfCWpZIq+3ke7QCgqlfv
Yg1BBa8zFGm9e6Xtik5bJeY=
=8KP5
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
