Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271706AbRIDPNn>; Tue, 4 Sep 2001 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRIDPNe>; Tue, 4 Sep 2001 11:13:34 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:11651 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271706AbRIDPNZ>; Tue, 4 Sep 2001 11:13:25 -0400
Date: Tue, 4 Sep 2001 10:13:18 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Wrong BogoMIPS on alpha
Message-ID: <20010904101318.B1458@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Recently the bogomips measurement has gone all haywire.  Every once in a
while when I boot up the bogomips measurement will be absurly high (i.e.
5 Terahertz), with obvious associated problems.  This happens in recent
kernels with both gcc-2.96-81 (redhat) and egcs-2.91.66.  It does not
happen with early 2.4 kernels or 2.2 kernels.  It does not happen all
the time.  It never happens from a cold boot, and (almost) always
happens in a warm reboot.  In particular, MILO (which is a stripped-down
linux 2.0 kernel that loads the real kernel) always measures the
bogomips correctly immediately before loading a new kernel that measures
it incorrectly.

The system is:
Alpha LX164 (21164 chip) at 600MHz
Kernels 2.4.7-2.4.9.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuU744ACgkQjwioWRGe9K2wzgCfa0S/hH67KBfT4HrBoa1w25Lz
NoMAnRj7n6+fcFxjWEzLNz8aZpp02hPT
=WuqW
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
