Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289995AbSBADPK>; Thu, 31 Jan 2002 22:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290155AbSBADO7>; Thu, 31 Jan 2002 22:14:59 -0500
Received: from rj.sgi.com ([204.94.215.100]:55441 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289995AbSBADOy>;
	Thu, 31 Jan 2002 22:14:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.13 is available 
Date: Fri, 01 Feb 2002 14:14:45 +1100
Message-ID: <24889.1012533285@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.13.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.13-1.src.rpm       As above, in SRPM format
modutils-2.4.13-1.i386.rpm      Compiled with gcc 2.96 20000731,
				glibc 2.2.2.
modutils-2.4.13-1.ia64.rpm      Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.13.gz        Patch from modutils 2.4.12 to 2.4.13.

No sparc binary yet, the build machine is down.

Changelog extract

	* ppc64 changes by Alan Modra.
          insmod/insmod.c (add_symbols_from): Add function descriptor syms for
          ppc64.
	  (create_module_ksymtab): Tweak module base for ppc64.
	  obj/obj_ppc64.c (arch_new_file): Update comment.
	  (ppc64_process_syms): Look for kernel and module base addresses.
	  (arch_create_got): Accept more relocs.
          (apply_addr16_lo, apply_addr16_lo_ds, apply_addr16_hi,
          apply_addr16_ha, apply_toc16): New.
	  (apply_toc16_ds): Use apply_addr16_lo_ds.
	  (arch_apply_relocation): Perform more relocs.
	* Add --quick to depmod (equivalent to -A).
	* Clean up multiple man pages.  Barry Rountree.
	* Fix a relocation problem in insmod for IA64 IMM64 types.
	  Asit K Mallick.
	* Make obj_gpl_license combined 32/64 bit aware.  Tom Duffy and
	  Ben Collins (identical patches :)
	* Build correctly with 32/64 and separate insmod/kallsyms.
	  Bill Nottingham.
	* fdatasync() after writing to /var/log/ksymoops to improve the chance
	  of the log surviving an oops.  Suggested by Urban Widmark.
	* Do not abort if insmod option is longer than 2000 characters.
	  Reported by Gary Lerhaupt.
	* Do not exit early on depmod problems, do as much work as possible.
	  Requested by Christian Lademann.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8Wggki4UHNye0ZOoRAjgsAJwNVfTXRCH6jaQeFh62H5Mmg/JU2gCfRZUQ
WJe5ODtBVpQdFJWP0T84OPo=
=mZqq
-----END PGP SIGNATURE-----

