Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUKUBuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUKUBuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUKUBuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:50:25 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:15044 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261724AbUKUBuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:50:18 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.10 is available
Date: Sun, 21 Nov 2004 12:50:07 +1100
Message-ID: <32545.1101001807@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.10.tar.gz           Source tarball, includes RPM spec file
ksymoops-2.4.10-1.src.rpm        As above, in SRPM format
ksymoops-2.4.10-1.i386.rpm       Compiled with gcc 3.4.2, glibc 2.3.3
patch-ksymoops-2.4.10.gz         Patch from ksymoops 2.4.9 to 2.4.10.

Changelog extract

        * Fix typo in man page.
        * Unlike syslogd, syslog-ng does not prefix lines with ' kernel:'.
          Handle both formats.  Reported by gentoo.
        * Explictly pass --target on calls to nm and objdump.  Resolves
          cases where objdump/nm complain 'File format is ambiguous'.
          Robin Johnson.


Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFBn/RPi4UHNye0ZOoRAj/FAJ46l4CPjHAcxx1aq2EeKl+eS83nrwCeLwq3
0uSJypb6rMhqxctZOErRzqg=
=uPT2
-----END PGP SIGNATURE-----

