Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRKWIEg>; Fri, 23 Nov 2001 03:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281873AbRKWIE0>; Fri, 23 Nov 2001 03:04:26 -0500
Received: from zok.sgi.com ([204.94.215.101]:16859 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281861AbRKWIER>;
	Fri, 23 Nov 2001 03:04:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.9 is available
Date: Fri, 23 Nov 2001 19:04:03 +1100
Message-ID: <19293.1006502643@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.9 of kernel build for kernel 2.5 (kbuild 2.5) has been
released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
download release 1.9.

kbuild 2.5 currently supports i386 (2.4.15), ia64 and sparc32 (2.4.14)
with sparc64 in progress.  ia64, sparc32 and sparc64 patches against
kernel 2.4.15 to follow.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changelog:

  Upgrade to kernel 2.4.15, this release will also work on kernel 2.5.0.

  Rewrite pipelined commands that might fail so make can detect any
  failure.

  Add $(tmpfile), mainly used in commands that used to be pipelined.

  Correct shipped() to handle same source and object directory.

  Add missing .tmp cleanups.

  Check UTS_ fields for length, KERNELRELEASE must not exceed 64
  characters, other UTS_ fields are silenly truncated.

  After a failure, tell the user to read the FAQ before sending a bug
  report (hi, Richard :).

  Some i386 Assembler needs -traditional because of unbalanced ' in
  comments.

  Correct the link order code.  Earlier versions of kbuild 2.5 were
  linking vmlinux in the wrong order.  Nobody noticed, which shows how
  horribly over specified the link order is.

  This release does not support CML2, only use it with CML1.  CML2
  support in progress.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7/gLxi4UHNye0ZOoRAl/kAJ0UVQLgIY61xcvGYK/1wiVxcQBUywCdEtsl
VQdVd7xdPnbA3IJnCD8+UKY=
=ZtT+
-----END PGP SIGNATURE-----

