Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKFMAv>; Tue, 6 Nov 2001 07:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRKFMAb>; Tue, 6 Nov 2001 07:00:31 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:16915 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279113AbRKFMA2>;
	Tue, 6 Nov 2001 07:00:28 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.5 is available
Date: Tue, 06 Nov 2001 23:00:11 +1100
Message-ID: <20208.1005048011@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.5 of kernel build for kernel 2.5 (kbuild 2.5) has been
released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
download release 1.5.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changelog:

  Generalize select() and objlink() to take a variable number of
  CONFIG_ entries, including zero.

  Remove the special case commands always(), always_mod() and
  objlink_cond(), they are all handled by the general case commands.

  Simplify selections with multiple criteria to use the general
  select() command.

  Add update_if_changed() as a micro optimization, mainly for
  asm-offsets.h.

  Add CONFIG_Y, CONFIG_M to handle special select() cases.

  Add CONFIG_KBUILD_GCC_VERSION.  Later releases will force a complete
  rebuild if this variable changes, work in progress.

  Add CONFIG_KBUILD_CRITICAL which lists the CONFIG_ variables that are
  critical to the build.  Later releases will force a complete rebuild
  if any of the listed config variables change, work in progress.

  Documentation changes (Documentation/kbuild/kbuild-2.5.txt is your
  friend) for above changes plus asm-offsets.h.

  Upgrade to kernel 2.4.14.

  This release does not fully support CML2, only use it with CML1.
  CML2 needs the extra CONFIG_ variables and menus added to support
  kbuild 2.5.  WIP.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE759DIi4UHNye0ZOoRAjOLAKDY5kDzB4IWIa7SGILX8ImmA+X8kQCdEmna
ROLiz7j1FbQfS48FCa7yu2s=
=R/22
-----END PGP SIGNATURE-----

