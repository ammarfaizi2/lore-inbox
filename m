Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265476AbRF1ByI>; Wed, 27 Jun 2001 21:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbRF1Bx7>; Wed, 27 Jun 2001 21:53:59 -0400
Received: from secure.hostnoc.net ([66.96.192.200]:50439 "EHLO
	secure.hostnoc.net") by vger.kernel.org with ESMTP
	id <S265476AbRF1Bxv>; Wed, 27 Jun 2001 21:53:51 -0400
Date: Wed, 27 Jun 2001 21:53:04 -0400
From: "J. Nick Koston" <nick@burst.net>
To: linux-kernel@vger.kernel.org
Subject: Asus CUV4X-DLS
Message-ID: <20010627215304.D28795@burst.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.hostnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1003 1004] / [1003 1004]
X-AntiAbuse: Sender Address Domain - secure.hostnoc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


There seems to be a major problem with this board and 2.4.x kernels.
I consistantly get SCSI Input/Output errors on multiple drives that I
know are good when running a SMP kernel.  These errors do no happen
with a UP kernel.  This is happening on multiple systems and with
multiple know good scsi drives of all speeds and sizes.

Test#1:

2.4.2 (redhat 7.1 version)

dd if=3D/dev/sda of=3D/dev/null
(fails with input/output error)

Test #2:

2.4.2 (redhat 7.1 version)
noapic on boot

dd if=3D/dev/sda of=3D/dev/null
(fails with input/output error)

Test #3:

2.4.2 (redhat 7.1 edition)

dd if=3D/dev/sda of=3D/dev/null
PASS!


               Nick







--=20

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Oo3/T5huNxcQLWARAs1hAKCJgvgDJDqY6UyrUvEUfq9CZK0QJQCeMK4f
donpIpDbKLDj34KFr5i3v6g=
=7T8N
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
