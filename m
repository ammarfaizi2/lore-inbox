Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGUJgl>; Sun, 21 Jul 2002 05:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSGUJgk>; Sun, 21 Jul 2002 05:36:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2567 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311025AbSGUJgh>;
	Sun, 21 Jul 2002 05:36:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.17 is available 
Date: Sun, 21 Jul 2002 19:39:15 +1000
Message-ID: <20746.1027244355@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.17.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.17-1.src.rpm       As above, in SRPM format
modutils-2.4.17-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
patch-modutils-2.4.17.gz        Patch from modutils 2.4.15 to 2.4.17.

Changelog extract

	* struct obj_symbol needs target specific value for 32/64 bit modutils.
	  Will Schmidt.
	* New binutils no longer uses '?' for kstrtab in System.map.
	  Alan Modra.
	* Only warn for unknown parameters on insmod.  This used to be an error
	  which caused migration problems when a parameter was removed from a
	  module.  Requested by Matt Domsch.
	* Change default TAINT_URL to http://www.tux.org/lkml/#export-tainted.
	* Upgrade for bison > 1.31.  Reported by Akim Demaille.
	* Add license string "GPL v2".  Reported by Pavel Roskin.
	* PPC64 updates for new relocation types.  Alan Modra.
	* Revert depmod to pre-2.4.13 behaviour.  Unresolved symbols should not
	  cause a non-zero return code unless depmod -u is explicitly set.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9OoFBi4UHNye0ZOoRAk4sAKDLl/eL1GxIsUi+0EKEganhM4dXAgCfR2tL
4wKUbD1u1ZEV2V0/Dqp/elw=
=vQWh
-----END PGP SIGNATURE-----

