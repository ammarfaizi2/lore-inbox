Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSBUXiH>; Thu, 21 Feb 2002 18:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSBUXh6>; Thu, 21 Feb 2002 18:37:58 -0500
Received: from [65.169.83.229] ([65.169.83.229]:1920 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S287862AbSBUXhu>; Thu, 21 Feb 2002 18:37:50 -0500
Date: Thu, 21 Feb 2002 17:37:00 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rc1
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I tried Dave Jones' version of the kernel to see if it would compile, as I
haven't been able to the regular 2.5 kernel to compile since I have the
new binutils package.=20

It compiled fine. When I booted up everything looked normal with the
exception of a=20
eth1: going OOM=20
message that kept scrolling down the screen. My eth1 is a natsemi card.

Eventually that stopped and gdm came up. For some reason my keyboard and
mouse wouldn't work.  However, I could ssh into the machine and both
ethernet cards were functional. I noticed I had left SMP support
selected in the configuration, so I turned that off and tried
recompiling. It got to check.c in fs/partitions before stopping with an
error.=20

So, it looks like the binutils problems are fixed, but there are some
other issues apparently. If you need configuration information or for me
try something please let me know.

Ben Pharr


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dYScROE+HmhZeSwRAoJvAKDRXBuENcQAMe82YUk4ITzBUEJ4XwCfdKs9
AdhZb8od9YddLT3+wi7Hjak=
=rcej
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
