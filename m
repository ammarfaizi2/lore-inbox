Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275789AbRJBD1R>; Mon, 1 Oct 2001 23:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275805AbRJBD1H>; Mon, 1 Oct 2001 23:27:07 -0400
Received: from zok.SGI.COM ([204.94.215.101]:48859 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275789AbRJBD0x>;
	Mon, 1 Oct 2001 23:26:53 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.10 is available 
Date: Tue, 02 Oct 2001 13:26:55 +1000
Message-ID: <19641.1001993215@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.10.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.10-1.src.rpm       As above, in SRPM format
modutils-2.4.10-1.i386.rpm      Compiled with gcc 2.96 20000731,
				glibc 2.2.2.
modutils-2.4.10-1.ia64.rpm      Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.10.gz        Patch from modutils 2.4.9 to 2.4.10.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Remove duplicate patch for sh, Tom Rini.
	* Handle empty multi-line modinfo fields, reported by Bill Nottingham.
	* Add obj_find_relsym(), standard method of finding relocation symbols.
	* Default char-major-4 (tty) to off for s390.  S390 group via Redhat.
	* Support GPL only exported symbols (EXPORT_SYMBOL_GPL).

That last addition goes with the new EXPORT_SYMBOL_GPL() macro in
kernels 2.4.10-ac2 and 2.4.11-pre2 onwards.  If your code uses
EXPORT_SYMBOL_GPL() then you *must* use modutils >= 2.4.10.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7uTP+i4UHNye0ZOoRArzrAJ0QgzGu/JzWtrfD2jtCArLIBhZYjQCfTJHt
qDAa6krIptE5BqREUMBU2dY=
=accJ
-----END PGP SIGNATURE-----

