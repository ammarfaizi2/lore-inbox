Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGYWil>; Thu, 25 Jul 2002 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGYWil>; Thu, 25 Jul 2002 18:38:41 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39950 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316623AbSGYWii>;
	Thu, 25 Jul 2002 18:38:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.6 is available (reissue)
Date: Fri, 26 Jul 2002 08:41:42 +1000
Message-ID: <2770.1027636902@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Reissued to add note about binutils problems.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.6.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.6-1.src.rpm	As above, in SRPM format
ksymoops-2.4.6-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
patch-ksymoops-2.4.6.gz		Patch from ksymoops 2.4.5 to 2.4.6.

Changelog extract

	* m68k call trace does not have trailing ' '.  Reported by
	  Richard Zidlicky.
	* MIPS has a hole in the register dump, skip $26 and $27 (k0, k1).
	  Maciej W. Rozycki.
	* Only print decoded registers if they resolve to kernel symbols.

Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9QH6li4UHNye0ZOoRAkZUAJ0QKS7WBytWlttPqoE0ZdMy9RvN9wCgk4+J
XfAo0yeBJDKa4Q0iDL4ZKn4=
=bUSD
-----END PGP SIGNATURE-----

