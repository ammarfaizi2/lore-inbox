Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTI3PpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTI3PpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:45:02 -0400
Received: from [199.45.143.209] ([199.45.143.209]:54276 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261570AbTI3Po6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:44:58 -0400
Subject: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
From: Zan Lynx <zlynx@acm.org>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r1HQBvrTExP1IElwpBDT"
Organization: 
Message-Id: <1064936688.4222.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Sep 2003 09:44:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r1HQBvrTExP1IElwpBDT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was interested in the contents of the files in /proc/fs/reiserfs/sda1,
so I did these commands:

cd /proc/fs/reiserfs/sda1
grep . *

(I like using the grep . * because it labels the contents of each file
with the filename.)

I did this as a regular user and also as root.  Both times the system
crashed and immediately rebooted.  I tried it again as root and the
system froze instead.

The system is basically RedHat 9.  The kernel was compiled with GCC
3.2.2.  I attached a compressed lsmod and kernel configuration to this
message.

The CPU is an Athlon XP 2000+, the SCSI adapter is a LSI Logic 53c1010
Ultra3 64 bit adapter running on a 32 bit bus.  (lspci output is also
attached.)  The SCSI drive is a Seagate X15.3.

Thanks for looking at this.
--=20
Zan Lynx <zlynx@acm.org>

--=-r1HQBvrTExP1IElwpBDT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/eaTwG8fHaOLTWwgRAtBhAJ9B7hV/Cm4BVKi4bLRsC3z1u0weoQCgm75K
vCRg8U0NKIhbfrYytfmiifs=
=kG+K
-----END PGP SIGNATURE-----

--=-r1HQBvrTExP1IElwpBDT--

