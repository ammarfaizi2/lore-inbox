Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbREFGDD>; Sun, 6 May 2001 02:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbREFGCx>; Sun, 6 May 2001 02:02:53 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19475 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132958AbREFGCk>;
	Sun, 6 May 2001 02:02:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.6 is available 
Date: Sun, 06 May 2001 16:02:35 +1000
Message-ID: <819.989128955@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.6.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.6-1.src.rpm        As above, in SRPM format
modutils-2.4.6-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.4.6-1.sparc64.rpm    Not available yet, waiting for a sparc machine.
modutils-2.4.6-1.ia64.rpm       Compiled with gcc 2.96-ia64-000717 snap 001117,
				libc-2.2.1.
patch-modutils-2.4.6.gz         Patch from modutils 2.4.5 to 2.4.6.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Replace uint64_t with u_int64_t for glibc 2.0.  Luis Carlos Yamamoto.
	* /dev/rtc can be a module.  Urs Thuermann.
	* Do not assume that malloc(0) returns a pointer.  Bug report by
	  Kiichiro Naka, different fix by Keith Owens.
	* Cross compile changes.  Maciej W. Rozycki.
	* Better explanation for rmmod -a.   Marc Herbert.
	* Remove modules(2) references.  Debian #69398.
 	* hppa dp is $global$, not data_start.  Richard Hirst.
 	* hppa64 stub for millicode calls must not use dp.  Richard Hirst.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE69Oj4i4UHNye0ZOoRAl/cAJ9Sppko57LNUHb92z01+CUDW7vMHQCff8kF
jOxArOcYlyk9MHHa7vRUS18=
=mWGA
-----END PGP SIGNATURE-----

