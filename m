Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933032AbWKLRfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbWKLRfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933033AbWKLRfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:35:13 -0500
Received: from pool-72-66-199-5.ronkva.east.verizon.net ([72.66.199.5]:11463
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S933032AbWKLRfL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:35:11 -0500
Message-Id: <200611121735.kACHZ9SX030881@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: RFC - 2.6.19-rc5-mm1 Documentation/Changes cleanup
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163352909_6400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Nov 2006 12:35:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163352909_6400P
Content-Type: text/plain; charset=us-ascii

Bringing Documentation/Changes into sync with scripts/ver_linux

Anybody want to submit values for ??? (or justifu leaving the field blank)
for any of these?  I suspect that some will require footnotes, like
'glibc [note 1] Need 2.foo or later for proper NTPL, 2.bar or later for futex".

Not ready for application, so no signed-off-by:

--- linux-2.6.19-rc5-mm1/Documentation/Changes.dist	2006-11-09 15:42:09.000000000 -0500
+++ linux-2.6.19-rc5-mm1/Documentation/Changes	2006-11-12 11:56:26.000000000 -0500
@@ -32,6 +32,7 @@
 o  Gnu make               3.79.1                  # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
+o  mount                  ???                     # mount --version
 o  module-init-tools      0.9.10                  # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.1.3                   # fsck.jfs -V
@@ -39,13 +40,22 @@
 o  reiser4progs           1.0.0                   # fsck.reiser4 -V
 o  xfsprogs               2.6.0                   # xfs_db -V
 o  pcmciautils            004                     # pccardctl -V
+o  pcmcia-cs              ???                     # cardmgr -V
 o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  nfs-utils              1.0.5                   # showmount --version
+o  Linuc C Library        ???                     # ldd /bin/sh
+o  Dynamic linker (ldd)   ???                     # ldd -v or ldd --version
+o  Linux C++ Library      ???                     # ls -l /usr/lib/libstd++.so
 o  procps                 3.2.0                   # ps --version
+o  net-tools              ???                     # ifconfig --version
+o  kbd                    ???                     # loadkeys -h
+o  console-tools          ???                     # loadkeys -v
 o  oprofile               0.9                     # oprofiled --version
+o  sh-utils               ???                     # expr --v
 o  udev                   081                     # udevinfo -V
+o  wireless-tools         ???                     # iwconfig --version
 
 Kernel compilation
 ==================



--==_Exmh_1163352909_6400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFV1tNcC3lWbTT17ARAt5LAJ4okypl3Y7ezhMQdiJM0/7SfyheCgCghTBp
vCSZQ8idOPxmvka943oUyw8=
=FP8P
-----END PGP SIGNATURE-----

--==_Exmh_1163352909_6400P--
