Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274237AbRIZK7F>; Wed, 26 Sep 2001 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRIZK64>; Wed, 26 Sep 2001 06:58:56 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:61703 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274237AbRIZK6e>;
	Wed, 26 Sep 2001 06:58:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.3 is available.
Date: Wed, 26 Sep 2001 20:58:48 +1000
Message-ID: <1470.1001501928@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.3 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.3.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changes from Release 1.2

  Upgrade to kernel 2.4.10.

  Split arch/$(ARCH)/Makefile.defs into Makefile.defs.noconfig and
  Makefile.defs.config, the latter can only be processed after .config
  has been read.  i386 and ia64 done, more to come.

  arch_core_subdirs is gone, it uses link_subdirs like everything else.

  Yet more aic7xxx fixes, I wish that Makefile followed the rules :(.

  Changing the number of source trees no longer forces a complete
  rebuild.  Changing the names of the source tree never forced a
  rebuild but adding or deleting a complete tree used to.

  Add $(obj_includelist) for generated include files.

  Offsets for Assembler code standardized to arch/$(ARCH)/asm-offsets.h.
  i386 and ia64 done, more to come.

  scripts/shadow.pl to report on which files are shadowed and at which
  levels.

  Ensure that make install uses the same KERNELRELEASE as the build,
  even if root forgets to specify any overrides.

  Assorted bug fixes.

Expect a kbuild 2.5 patch for 2.4.9-ia64-010820 in the next few days,
and a patch for 2.4.10-ac after 2.4.10-ac1 is released.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7sbTmi4UHNye0ZOoRAnM0AJ9xp0JtrolFU8ioWBKmj1HGZ0u79ACfeTLG
MLMOkn824x8+DNnNATZadxU=
=N3b6
-----END PGP SIGNATURE-----

