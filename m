Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292620AbSBZB1n>; Mon, 25 Feb 2002 20:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292629AbSBZB1T>; Mon, 25 Feb 2002 20:27:19 -0500
Received: from rj.SGI.COM ([204.94.215.100]:49372 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S292604AbSBZB0S>;
	Mon, 25 Feb 2002 20:26:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.1 is available for kernel 2.4.18
Date: Tue, 26 Feb 2002 12:25:07 +1100
Message-ID: <16206.1014686707@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.1/

  kdb-v2.1-2.4.18-common-1.bz2
  kdb-v2.1-2.4.18-i386-1.bz2

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
- -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
        -rc or whatever numbering system the kernel keepers have thought up this
        week.
- -common The common kdb code.  Everybody needs this.
- -i386   Architecture dependent code for i386.
- -ia64   Architecture dependent code for ia64, etc.
- -n      If there are multiple kdb patches against the same kernel version then
        the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb v2.1 for i386 on kernel 2.4.18, apply
  kdb-v2.1-2.4.18-common-1
  kdb-v2.1-2.4.18-i386-1
in that order.

Changelog extracts.

common

2002-02-26 Keith Owens <kaos@sgi.com>

	* Upgrade to 2.4.18.
	* Add Paul Dorwin (IBM) magicpoint slides on using kdb as
	  Documentation/kdb/slides.
	* kdb v2.1-2.4.18-common-1.

i386

2002-02-26 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.4.18.
	* kdb v2.1-2.4.18-i386-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8euPxi4UHNye0ZOoRAripAKD4BWcFuI+B8+LhMrI9RjZns70rEwCfd8tW
WVayGpbo/Z66po15ejVV7dU=
=taHW
-----END PGP SIGNATURE-----

