Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSEANx2>; Wed, 1 May 2002 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSEANx1>; Wed, 1 May 2002 09:53:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:29197 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312414AbSEANx0>;
	Wed, 1 May 2002 09:53:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 2.3 is available
Date: Wed, 01 May 2002 23:53:12 +1000
Message-ID: <20199.1020261192@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 2.3 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 2.3.

kbuild-2.5-core-9.bz2.
  Changes from core-8.

    Handle Config.help as well as Configure.help.

    Track config changes for generated .[is] files.

kbuild-2.5-common-2.5.12-1.bz2.
  Changes from common-2.5.10-2.

    Upgrade to kernel 2.5.12.

    Add Config.help entries for kbuild 2.5.

    Force uname date to LANG=C.

    Clean up logic for finding the initial .config.

    Add installable target tftpboot.img.
   
kbuild-2.5-i386-2.5.12-1.bz2.
  Changes from i386-2.5.10-1.

    Upgrade to kernel 2.5.12.

kbuild-2.5-sparc64-2.5.12-1.bz2

  Originally a patch by Tom Duffy against 2.5.11.  There were no arch
  Makefile changes from 2.5.11 to 2.5.12 and a quick build on sparc64
  found no problems so I used the 2.5.11 sparc64 patch for 2.5.12.

  Because sparc64 does not compile in 2.5.1[12] (even using the old
  kernel build), you need some extra sparc64 patches.  Read the patch
  for details.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8z/NGi4UHNye0ZOoRAiutAJ9Qz7PY0/X2hy4Lv+bHEl2nyOpKhQCg2VN1
zrhRk2PHILEvpBFQT2raQp0=
=aSHw
-----END PGP SIGNATURE-----

