Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRCZKDM>; Mon, 26 Mar 2001 05:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132397AbRCZKDC>; Mon, 26 Mar 2001 05:03:02 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14862 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132392AbRCZKCw>;
	Mon, 26 Mar 2001 05:02:52 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.4 is available 
Date: Mon, 26 Mar 2001 20:02:06 +1000
Message-ID: <27242.985600926@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Another small collection of bug fixes.  No new facilities.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.4.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.4-1.src.rpm        As above, in SRPM format
modutils-2.4.4-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.4.4-1.sparc64.rpm    Combined sparc 32/64.
modutils-2.4.4-1.ia64.rpm       Compiled with gcc 2.96-ia64-000717 snap 001117,
				libc-2.2.1.
patch-modutils-2.4.4.gz         Patch from modutils 2.4.3 to 2.4.4.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2.  Optional.

Changelog extract

	* Do not generate filenames when reading nested config files.
	* depmod ignored user prune commands, reported by Kristofer T. Karas.
	* Change error message for short ELF header.
	* Missing commas in alias list.  Urs Thuermann.
	* Print an error message when genksyms detects a bad kernel version.
	  Mark McLoughlin
	* modinfo default changed to filename, description, author, parameters.
	  Mark McLoughlin

I will not be supporting modutils, ksymoops or kdb for the next 4
weeks; time for a holiday, probably without net access.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6vxOdi4UHNye0ZOoRAvw+AKCK7IKCyxMEW8CqjXS4HLnKIQn2zgCguVIs
8Eu5DSDyqb4LfumqQ9ATTFQ=
=vg9V
-----END PGP SIGNATURE-----

