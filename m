Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266931AbSK2CO2>; Thu, 28 Nov 2002 21:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSK2CO2>; Thu, 28 Nov 2002 21:14:28 -0500
Received: from zok.sgi.com ([204.94.215.101]:10441 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S266931AbSK2CO0>;
	Thu, 28 Nov 2002 21:14:26 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.5 is available for kernel 2.4.20
Date: Fri, 29 Nov 2002 13:20:22 +1100
Message-ID: <4644.1038536422@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.5/

  kdb-v2.5-2.4.20-common-1.bz2
  kdb-v2.5-2.4.20-i386-1.bz2
  No kdb ia64-2.4.20 patch yet, waiting for base 2.4.20-ia64 patch.

Changelog extracts since 2.4.19.

2.4.20-common-1

2002-11-29 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.4.20.
	* Correct Documentation/kdb/kdb_sr.man.
	* Remove leading zeroes from pids, they are decimal, not octal.
	* kdb v2.5-2.4.20-common-1.

2002-11-14 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.4.20-rc1.
	* kdb v2.5-2.4.20-rc1-common-1.

2.4.20-i386-1

2002-11-29 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.4.20.
	* kdb v2.5-2.4.20-i386-1.

2002-11-14 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.4.20-rc1.
	* kdb v2.5-2.4.20-rc1-i386-1.

v2.5/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
	 -rc or whatever numbering system the kernel keepers have thought up this
	 week.
 -common The common kdb code.  Everybody needs this.
 -i386   Architecture dependent code for i386.
 -ia64   Architecture dependent code for ia64, etc.
 -n      If there are multiple kdb patches against the same kernel version then
	 the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.4.20, apply
  kdb-v2.5-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v2.5-2.4.20-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-020821 on kernel 2.4.20, apply
  kdb-v2.5-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v2.5-2.4.20-ia64-020821-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE95s7ji4UHNye0ZOoRAqduAJ0ZJssTNckBsAW8/BE+XV3OOKf3hwCfXRcf
W0NSiZlxuul/dAiONBleKhw=
=Tge0
-----END PGP SIGNATURE-----

