Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSGIXh5>; Tue, 9 Jul 2002 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSGIXh4>; Tue, 9 Jul 2002 19:37:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:51462 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317457AbSGIXhz>;
	Tue, 9 Jul 2002 19:37:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.2 is available for kernel 2.4.19-rc1 
Date: Wed, 10 Jul 2002 09:40:28 +1000
Message-ID: <31535.1026258028@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.2/

  kdb-v2.2-2.4.19-rc1-common-1.bz2
  kdb-v2.2-2.4.19-rc1-i386-1.bz2

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

For example, to use kdb v2.2 for i386 on kernel 2.4.19-rc1, apply
  kdb-v2.2-2.4.19-rc1-common-<n>	(use highest value of <n>)
  kdb-v2.2-2.4.19-rc1-i386-<n>		(use highest value of <n>)
in that order.

Changelog extracts.

common

2002-07-09 Keith Owens <kaos@sgi.com>

       * Upgrade to 2.4.19-rc1.
       * Add dmesg command.
       * Clean up copyrights, Eric Sandeen.
       * kdb v2.2-2.4.19-rc1-common-1.

i386

2002-07-09 Keith Owens  <kaos@sgi.com>

       * Upgrade to 2.4.19-rc1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9K3Rri4UHNye0ZOoRAggaAJ4le5YLWqMju1okBHGZFYlI5CeyvACg6c8x
EcJU6z5UptMlTt332yZAOlc=
=Vhs9
-----END PGP SIGNATURE-----

