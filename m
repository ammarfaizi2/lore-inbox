Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSKYEee>; Sun, 24 Nov 2002 23:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSKYEee>; Sun, 24 Nov 2002 23:34:34 -0500
Received: from zok.SGI.COM ([204.94.215.101]:5810 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262416AbSKYEed>;
	Sun, 24 Nov 2002 23:34:33 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.8 is available
Date: Mon, 25 Nov 2002 15:41:34 +1100
Message-ID: <6748.1038199294@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.8.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.8-1.src.rpm	As above, in SRPM format
ksymoops-2.4.8-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.5
ksymoops-2.4.8-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731, glibc-2.2.3
ksymoops-2.4.8-1.sparc.rpm	Compiled as 32 bit user space, it supports 64 bit kernels.
patch-ksymoops-2.4.8.gz		Patch from ksymoops 2.4.7 to 2.4.8.

Changelog extract

	* Fix regex for ia64 'Bank nn' message.
	* Strip leading '+' from lines.

Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE94an9i4UHNye0ZOoRArf8AKCtypB4hkWrmD7+D/xu7TgusuR4ZwCgogQS
BTOdaWvu4bTt93txmFeUqbg=
=ow/0
-----END PGP SIGNATURE-----

