Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSFCCf1>; Sun, 2 Jun 2002 22:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFCCf1>; Sun, 2 Jun 2002 22:35:27 -0400
Received: from zok.SGI.COM ([204.94.215.101]:17318 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317257AbSFCCf0>;
	Sun, 2 Jun 2002 22:35:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, release 3.0 is available
Date: Mon, 03 Jun 2002 12:35:05 +1000
Message-ID: <27953.1023071705@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 3.0.

kbuild-2.5-core-15
  Changes from core-14.

    Replace mdbm with kbuild specific database engine to increase
    performance.

    Remove CML2 support, Dominik Brodowski, Keith Owens.

    Remove the restriction on symlinked sources and targets.  Aegis
    users should be able to use kbuild 2.5 now.

kbuild-2.5-common-2.5.19-1.
  Changes from common-2.5.15-4.

    Upgrade to kernel 2.5.19.
   
kbuild-2.5-i386-2.5.19-1.
  Changes from i386-2.5.15-2.

    Upgrade to kernel 2.5.19.


Larry McVoy provided the mdbm database engine from BitKeeper for use in
kbuild 2.5 release 2.0-2.4, and was extremely helpful in answering my
questions about mdbm.  Unfortunately some of the processing required by
kbuild 2.5 did not fit well with the mdbm model.  Since an application
specific database will always outperform a generic database, I took
advantage of knowledge about the kbuild data and wrote an application
specific database engine.

This is not a criticism of mdbm - it is a good generic database engine.
I could squeeze a few more seconds out of the build time by using
application specific knowledge.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8+tXYi4UHNye0ZOoRAp+5AJ9evi07/7D1+xHRRnxA8xdpeqY3hgCeMcrH
kgNAIKaGHE1Fy8BKByBZqXs=
=EamL
-----END PGP SIGNATURE-----

