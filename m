Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276779AbRJHHIk>; Mon, 8 Oct 2001 03:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276781AbRJHHIb>; Mon, 8 Oct 2001 03:08:31 -0400
Received: from rj.sgi.com ([204.94.215.100]:22162 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276779AbRJHHIW>;
	Mon, 8 Oct 2001 03:08:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.4 is available.
Date: Mon, 08 Oct 2001 17:08:43 +1000
Message-ID: <3169.1002524923@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.34

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changes from Release 1.3

  Upgrade to kernel 2.4.11-pre5.

  As suggested by Christoph Hellwig, ensure that the kernel does not
  depend on user space include files.

  Yet more aic7xxx fixes, I wish that Makefile followed the rules :(.

  Expand $(ARCH) in pp_makefile, reduces special cases.

  Tweaks to arch/i386/asm-offsets.h.

  vmlinux.lds* (linkage editor scripts) are now called vmlinux.lds.S
  (input) and vmlinux.lds.i (post-processed output, input to linker).
  Using .S and .i let me plug it into the full dependency system
  instead of being a special case.

  Add expsyms() for several objects that are not in 2.4 export-objs.

  Add -DEXPORT_SYMTAB for expsyms(), to check for entries missing from
  expsyms().

  Add CONFIG_KBUILD_2_5, always defined for kbuild 2.5.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7wVD5i4UHNye0ZOoRAo+nAKC9DqTKD/79PB38doGgG+d4nUTWBQCgvqgi
FYmuheRQX9iw2RCQg0/s0ZE=
=R5en
-----END PGP SIGNATURE-----

