Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319068AbSIDFvJ>; Wed, 4 Sep 2002 01:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSIDFvJ>; Wed, 4 Sep 2002 01:51:09 -0400
Received: from rj.SGI.COM ([192.82.208.96]:24299 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319068AbSIDFvI>;
	Wed, 4 Sep 2002 01:51:08 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.20 is available 
Date: Wed, 04 Sep 2002 15:55:33 +1000
Message-ID: <27470.1031118933@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.20.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.20-1.src.rpm       As above, in SRPM format
modutils-2.4.20-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.20-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
modutils-2.4.20-1.sparc.rpm	Compiled for combined 32/64 sparc, with gcc
				2.95.4, glibc-2.2.5.
patch-modutils-2.4.20.gz        Patch from modutils 2.4.19 to 2.4.20.

Changelog extract

	* Do not rely on timestamps for keywords.c

Just a Makefile tweak to workaround repositories that mangle timestamps
on checkout.  The problem only affects users who check modutils into
such a repository _and_ do not have gperf installed (you know who you
are).  Nobody else need bother upgrading.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9daBTi4UHNye0ZOoRAuDtAJ4u34xo0xb6wTX3+8fdAXhbdKeGhACg0bku
v4OkwIPXiOsRsuhiE3iyIrE=
=uSa5
-----END PGP SIGNATURE-----

