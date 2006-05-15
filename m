Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWEOTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWEOTHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWEOTHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:07:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16516 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932453AbWEOTH0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:07:26 -0400
Message-Id: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4-mm1 klibc build misbehavior
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147720043_2500P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:07:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147720043_2500P
Content-Type: text/plain; charset=us-ascii

Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?

Oddly enough, it *didn't* force a rebuild of all the *.ko files.




--==_Exmh_1147720043_2500P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEaNFrcC3lWbTT17ARAjpoAKCUTH5Krt4WPysBg9GVDgmRQsLmkwCeMUXf
/GQ2W2aO/FnohN93EZbgS3A=
=ZX3s
-----END PGP SIGNATURE-----

--==_Exmh_1147720043_2500P--
