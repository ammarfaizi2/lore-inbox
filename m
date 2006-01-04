Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWADJLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWADJLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWADJLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:11:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33711 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751622AbWADJLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:11:00 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.15
Date: Wed, 04 Jan 2006 20:10:49 +1100
Message-ID: <13550.1136365849@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated for kernel 2.6.15.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.15-common-1.bz2
  kdb-v4.4-2.6.15-i386-1.bz2
  kdb-v4.4-2.6.15-ia64-1.bz2

Changelog extract since kdb-v4.4-2.6.14-common-1.

2006-01-04 Keith Owens  <kaos@sgi.com>

	* Print all buffers on a page in inode pages and update formatting to be
	  legible, too.  David Chinner, SGI.
	* Update page flags in kdbm_pg.
	* Remove inline from *.c files.
	* kdb v4.4-2.6.15-common-1.

2005-12-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc7-common-1.

2005-12-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc6-common-1.

2005-12-10 Keith Owens  <kaos@sgi.com>

	* Update mapping of flags to strings in kdbm_pg.c and kdbm_vm.c.
	* kdb v4.4-2.6.15-rc5-common-3.

2005-12-06 Keith Owens  <kaos@sgi.com>

	* Add RECOVERY flag to global KDB flags.
	* Add kdb_{save,restore}_flags.
	* kdb v4.4-2.6.15-rc5-common-2.

2005-12-05 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc5-common-1.

2005-12-02 Keith Owens  <kaos@sgi.com>

	* kdbm_vm.c: offsets of page macros should be unsigned long.  Reported
	  by Dean Nelson, SGI.
	* kdb v4.4-2.6.15-rc4-common-1.

2005-11-30 Keith Owens  <kaos@sgi.com>

	* New follow_page() API.
	* kdb v4.4-2.6.15-rc3-common-1.

2005-11-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc2-common-1.

2005-11-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc1-common-1.

2005-11-15 Keith Owens  <kaos@sgi.com>

	* Allow kdb_printf() to be used outside kdb, in preemptible context.
	* Build with CONFIG_SWAP=n.  Reported by Leo Yuriev.
	* kdb v4.4-2.6.14-common-2.


Changelog extract since kdb-v4.4-2.6.14-i386-1.

2006-01-04 Keith Owens  <kaos@sgi.com>

	* Remove some inlines and the last vestige of CONFIG_NUMA_REPLICATE.
	* Read the keyboard acknowledgment after sending a character.  SuSE
	  Bugzilla 60240.
	* kdb v4.4-2.6.15-i386-1.

2005-12-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc7-i386-1.

2005-12-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc6-i386-1.

2005-12-05 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc5-i386-1.

2005-12-02 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc4-i386-1.

2005-11-30 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc3-i386-1.

2005-11-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc2-i386-1.

2005-11-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc1-i386-1.


Changelog extract since kdb v4.4-2.6.14-ia64-1.

2006-01-04 Keith Owens  <kaos@sgi.com>

	* Remove some inlines and the last vestige of CONFIG_NUMA_REPLICATE.
	* Read the keyboard acknowledgment after sending a character.  SuSE
	  Bugzilla 60240.
	* kdb v4.4-2.6.15-ia64-1.

2005-12-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc7-ia64-1.

2005-12-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc6-ia64-1.

2005-12-06 Keith Owens  <kaos@sgi.com>

	* Use RECOVERY flag in MCA handler.
	* kdb v4.4-2.6.15-rc5-ia64-2.

2005-12-05 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc5-ia64-1.

2005-12-02 Keith Owens  <kaos@sgi.com>

	* Reinstate hook for debug trap, the patch chunk was accidentally
	  dropped in 2.6.15-rc1.
	* kdb v4.4-2.6.15-rc4-ia64-1.

2005-11-30 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc3-ia64-1.

2005-11-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc2-ia64-1.

2005-11-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.15-rc1-ia64-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFDu5EZi4UHNye0ZOoRAladAJ9dOrLAnfedShRieBScdUM4LKoXdgCfa14w
XkFg0U23y9XgZD64xu0iZ4Q=
=nYyJ
-----END PGP SIGNATURE-----

