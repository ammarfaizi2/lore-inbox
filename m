Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRIYHs0>; Tue, 25 Sep 2001 03:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274554AbRIYHsQ>; Tue, 25 Sep 2001 03:48:16 -0400
Received: from zok.SGI.COM ([204.94.215.101]:32663 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274549AbRIYHsD>;
	Tue, 25 Sep 2001 03:48:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.9 is available 
Date: Tue, 25 Sep 2001 17:48:22 +1000
Message-ID: <765.1001404102@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.9.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.9-1.src.rpm        As above, in SRPM format
modutils-2.4.9-1.i386.rpm       Compiled with gcc 2.96 20000731,
				glibc 2.2.2.
modutils-2.4.9-1.ia64.rpm       Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.9.gz         Patch from modutils 2.4.8 to 2.4.9.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Update to latest config.guess/sub from ftp.gnu.org:/pub/gnu/config.
	* Add sh (super-h) support from Niibe Yutaka.
	* IEEE1394 support by Kristian Hogsberg, cleaned up by KAO.
	* Add support for Alpha GPREL16, GPRELHIGH, GPRELLOW relocs.
	  Fix short data section allocation order for Alpha and IA-64.
	  Don't relocate non-allocated sections.  Richard Henderson.
	* Mark the kernel as tainted for non-GPL modules or insmod -f.

That last addition goes with the MODULE_LICENSE patch from Alan Cox and
my patch for /proc/sys/kernel/tainted, mailed to linux-kernel on
September 25, 07:00 GMT.  If /proc/sys/kernel/tainted exists and you
load a module with no license you will get a warning and the kernel
will be tainted, expect a lot of warnings until AC has all modules
patched.  Even if /proc/sys/kernel/tainted does not exist, loading a
module that has MODULE_LICENSE other than GPL or using insmod -f will
result in a warning.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7sDbFi4UHNye0ZOoRAqVVAKC3W5oq/RGiLbIUCbq2/w7jxMepagCfZclF
RSchf8gvfuTJXRhfHg0I5q0=
=F3yN
-----END PGP SIGNATURE-----

