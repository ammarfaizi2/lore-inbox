Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311585AbSCTNev>; Wed, 20 Mar 2002 08:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSCTNeg>; Wed, 20 Mar 2002 08:34:36 -0500
Received: from ns01.passionet.de ([62.153.93.33]:51855 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S311585AbSCTNeH>; Wed, 20 Mar 2002 08:34:07 -0500
Date: Wed, 20 Mar 2002 14:33:37 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: arrays@compaq.com
Cc: linux-kernel@vger.kernel.org, tytso@MIT.EDU,
        =?ISO-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
Subject: Hooks for random device entropy generation missing in cpqarray.c 
Message-ID: <4461574.1016634817@eva.dhcp.gimlab.org>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========04474375=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========04474375==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

All hooks for the random ganeration (add_blkdev_randomness() ) are ignored=20
in the cpqarray / ida  driver.
	Is a patch available ?
	or an other updated driver ?
	any hints where to put add_blkdev_randomness() in your driver ?
	
	is add_interrupt_randomness() called on an i386 SMP IO-APCI system ?


Thanks
Manon

PS: Folks on linux-kernel please CC to manon@manon.de I am not on the list



--==========04474375==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mI+xlp/TJR6NORURApE2AJ963YGv5uTFnfJGIPtmUC5cEIsFhACgiOdv
U0MLZPlfnNjYyy6MsYK/CwQ=
=+GD7
-----END PGP SIGNATURE-----

--==========04474375==========--

