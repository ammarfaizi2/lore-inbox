Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274405AbRIYB7v>; Mon, 24 Sep 2001 21:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274417AbRIYB7l>; Mon, 24 Sep 2001 21:59:41 -0400
Received: from zok.SGI.COM ([204.94.215.101]:26762 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274405AbRIYB7a>;
	Mon, 24 Sep 2001 21:59:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v1.9 is available for kernel 2.4.10
Date: Tue, 25 Sep 2001 11:58:47 +1000
Message-ID: <16353.1001383127@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.9-2.4.10.bz2

kdb v1.8 has just been keeping track of Linus and -ac kernels.  kdb
v1.9 flushes my folder of outstanding kdb patches.  Thanks to everybody
who sent patches and apologies for the delay in including them.

There is also a kdb v1.8 patch against 2.4.10 in that directory, as
well as v1.8 patches for 2.4.9-ac.  I will not be releasing kdb v1.9
against 2.4.9-ac or 2.4.9-ia64, I am waiting for -ac and -ia64 to sync
to 2.4.10.  The XFS CVS tree is up to kernel 2.4.10 but is still using
kdb v1.8, I will update XFS to kdb v1.9 in two days time.

Changelog extract.

2001-09-25 Keith Owens  <kaos@melbourne.sgi.com>

	* Update kdb v1.8 to kernel 2.4.10.

	* kdbm_pg patch from Hugh Dickens.

	* DProbes patch from Bharata B Rao.

	* mdWcn and mmW patch from Vamsi Krishna S.

	* i386 disasm layout patch from Jean-Marc Saffroy.

	* Work around for 64 bit binutils, Simon Munton.

	* kdb.mm doc correction by Chris Pascoe.

	* Enter repeats the last command, IA64 disasm only prints one
	  instruction.  Don Dugger.

	* Allow kdb/modules to be linked into vmlinux.

	* Remove obsolete code from kdb/modules/kdbm_{pg,vm}.c.

	* Warn when commands are entered at more prompt.

	* Add MODULE_AUTHOR, DESCRIPTION, LICENSE.

	* Release as kdb v1.9.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7r+TWi4UHNye0ZOoRAsXhAJ4jPFWrw9LSXtz0sK+QTgoZg0KPPgCfRLdM
qynYadSlN/72+3AkNiASe50=
=titQ
-----END PGP SIGNATURE-----

