Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSECOTZ>; Fri, 3 May 2002 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSECOTY>; Fri, 3 May 2002 10:19:24 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:42508 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313199AbSECOTX>;
	Fri, 3 May 2002 10:19:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Date: Sat, 04 May 2002 00:19:10 +1000
Message-ID: <13468.1020435550@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 2.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 2.4.

kbuild-2.5-core-13-1.
  Changes from core-9.

    Update documentation for asm-offsets.h.

    Remove the requirement that arch/$(ARCH)/Makefile.defs.*config had
    to be in the base tree.  Now a new architecture can be a completely
    separate drop in tree.

    Really force CONFIG_MODVERSIONS=n.  Modversions will not be
    supported until after kbuild 2.5 is in the main kernel.

    Change phase 4 message, it does a lot of integrity checks as well
    as generating the global makefile.  Will that shut up people who
    think that we don't need integrity checks?  Probably not :(.

    Correct bug in symlink message.

kbuild-2.5-common-2.5.13-1.
  Changes from common-2.5.12-1.

    Upgrade to kernel 2.5.13.
   
kbuild-2.5-i386-2.5.13-1.
  Changes from i386-2.5.12-1.

    Upgrade to kernel 2.5.13.

    Correct CC/CC_real in arch/$(ARCH)/Makefile.defs.*config.


You should be able to use kbuild-2.5-sparc64-2.5.12-1 with this
release.  ia64 is probably out of date by now and is not recommended
for use with 2.5.13.  I will do the kbuild 2.5 update for ia64 after we
get a new ia64 kernel patch.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE80pxci4UHNye0ZOoRAvYBAJ9eaE5JxM3vH3pmzI8ho6q3VsrRlACbBspY
u7SNlyBjmhgTD4YnSxw+Jas=
=Ek9t
-----END PGP SIGNATURE-----

