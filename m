Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbTCMNPh>; Thu, 13 Mar 2003 08:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbTCMNPh>; Thu, 13 Mar 2003 08:15:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:51981 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262298AbTCMNPf>;
	Thu, 13 Mar 2003 08:15:35 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.23 is available
Date: Fri, 14 Mar 2003 00:26:10 +1100
Message-ID: <10620.1047561970@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.23.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.23-1.src.rpm       As above, in SRPM format
modutils-2.4.23-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.23-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.23.gz        Patch from modutils 2.4.22 to 2.4.23.

Changelog extract

	* Correct s390[x] relocations for position independent code.
	  Bill Nottingham/Amit S. Kale.
	* Add alias for the tun/tap device.  Bill Nottingham.
	* Fix insmod for ppc64 MODULE_PARM(foo, "l").  Peter Bergner.
	* Add DESTDIR to man_kerneld, change man pages from 444 to 644.
	  Peter Breitenlohner.
	* libz must be static for --enable-zlib.  Bill Nottingham, reworked
	  by Keith Owens.
	* Add note about refusing patches that change behaviour to man pages.
	* Alpha now uses srel32 in the exception handling macros.
	  Richard Henderson.
	* Support ia64 brl relocations.

Modutils 2.4.24 will be out in the next few days.  The only change
planned for 2.4.24 is to complain about modules using the default
behaviour of "export all symbols" on architectures that use function
descriptors.  Such architectures must explicitly export symbols,
otherwise gcc does not generate function descriptors and inter-module
references break spectacularly.  

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+cIbxi4UHNye0ZOoRAtUcAKDB5K4wb+3/unAOTJQ66xl1EaPhRQCgqFKz
mTaRAx9pufzo68wP8rjMORc=
=utno
-----END PGP SIGNATURE-----

