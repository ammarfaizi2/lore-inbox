Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267824AbRGUUa3>; Sat, 21 Jul 2001 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267814AbRGUUaJ>; Sat, 21 Jul 2001 16:30:09 -0400
Received: from zeus.kernel.org ([209.10.41.242]:19389 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267811AbRGUUaH>;
	Sat, 21 Jul 2001 16:30:07 -0400
Date: Sat, 21 Jul 2001 22:28:26 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Another 2.4.7 build failure
Message-ID: <20010721222826.A1953@lucretia.debian.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Building fails for me with following error:

make[4]: Entering directory
`/home/admin/mechanix/srcd/linux/linux/drivers/block'
gcc -D__KERNEL__ -I/home/admin/mechanix/srcd/linux/linux/include -Wall -Wst=
rict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin=
g -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di586    -DEXPOR=
T_SYMTAB -c ll_rw_blk.c
ll_rw_blk.c:25: linux/completion.h: No such file or directory
ll_rw_blk.c: In function `attempt_merge':
ll_rw_blk.c:630: structure has no member named `waiting'
ll_rw_blk.c: In function `__make_request':
ll_rw_blk.c:815: structure has no member named `waiting'
ll_rw_blk.c: In function `ll_rw_block':
ll_rw_blk.c:1051: `end_buffer_io_sync' undeclared (first use in this functi=
on)
ll_rw_blk.c:1051: (Each undeclared identifier is reported only once
ll_rw_blk.c:1051: for each function it appears in.)
ll_rw_blk.c: In function `end_that_request_last':
ll_rw_blk.c:1144: structure has no member named `waiting'
ll_rw_blk.c:1145: warning: implicit declaration of function `complete'
ll_rw_blk.c:1145: structure has no member named `waiting'
make[4]: *** [ll_rw_blk.o] Error 1
make[4]: Leaving directory `/home/admin/mechanix/srcd/linux/linux/drivers/b=
lock'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/home/admin/mechanix/srcd/linux/linux/drivers/b=
lock'
make[2]: *** [_subdir_block] Error 2
make[2]: Leaving directory `/home/admin/mechanix/srcd/linux/linux/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/home/admin/mechanix/srcd/linux/linux'
make: *** [stamp-build] Error 2


Regards,

Filip

--=20
"The only stupid question is the unasked one."
	-- Martin Schulze

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7WeXqEjn3CY6VDgARAr0gAKDr4OV6N6Bbs/OuDRo7yD9oIgJ/qQCgh8tl
VLvfzcuZGiV6QxyNGN+AouY=
=KgVu
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
