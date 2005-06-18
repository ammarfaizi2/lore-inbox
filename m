Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVFRGUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVFRGUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 02:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVFRGUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 02:20:41 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:54214 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262096AbVFRGUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 02:20:04 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.12
Date: Sat, 18 Jun 2005 16:19:40 +1000
Message-ID: <22161.1119075580@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Current versions are :-

  kdb-v4.4-2.6.12-common-1.bz2
  kdb-v4.4-2.6.12-i386-1.bz2
  kdb-v4.4-2.6.12-ia64-1.bz2
  kdb-v4.4-2.6.11-x86-64-1.bz2 (may or may not work with 2.6.12).


Changelog extract since kdb-v4.4-2.6.11-common-1.

2005-06-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-common-1.

2005-06-08 Keith Owens  <kaos@sgi.com>

	* Correct early exit from bd *.
	* kdb v4.4-2.6.12-rc6-common-1.

2005-05-25 Keith Owens  <kaos@sgi.com>

	* Delete Documentation/kdb/dump.txt.  lkcd now has reasonable
	  integration with kdb.
	* kdb v4.4-2.6.12-rc5-common-1.

2005-05-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc4-common-1.

2005-04-21 Keith Owens  <kaos@sgi.com>

	* Add rpte command (find the pte for a physical page).
	* kdb v4.4-2.6.12-rc3-common-1.

2005-04-06 Keith Owens  <kaos@sgi.com>

	* Add rq and rqa commands.  John Hawkes, SGI.
	* kdb v4.4-2.6.12-rc2-common-1.

2005-03-29 Keith Owens  <kaos@sgi.com>

	* Use register_sysctl_table() instead of patching kernel/sysctl.c.
	* Non-ASCII characters are not printable.
	* kdb v4.4-2.6.12-rc1-common-1.

2005-03-15 Keith Owens  <kaos@sgi.com>

	* More coexistence patches for lkcd.  Jason Uhlenkott, SGI.
	* kdb v4.4-2.6.11-common-3.

2005-03-08 Keith Owens  <kaos@sgi.com>

	* Coexistence patches for lkcd.  Jason Uhlenkott, SGI.
	* kdb v4.4-2.6.11-common-2.


Changelog extract since kdb-v4.4-2.6.11-i386-1.

2005-06-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-i386-1.

2005-06-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc6-i386-1.

2005-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc5-i386-1.

2005-05-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc4-i386-1.

2005-04-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc3-i386-1.

2005-04-06 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc2-i386-1.

2005-03-29 Keith Owens  <kaos@sgi.com>

	* Replace __copy_to_user with __copy_to_user_inatomic.
	* kdb v4.4-2.6.12-rc1-i386-1.

2005-03-08 Keith Owens  <kaos@sgi.com>

	* Coexistence patches for lkcd.
	* kdb v4.4-2.6.11-i386-2.


Changelog extract since kdb v4.4-2.6.11-ia64-1.

2005-06-18 Keith Owens  <kaos@sgi.com>

	* Standard IA64 code now works around break.b setting cr.iim to 0
	  instead of the break number.  Remove the kdb workaround.
	* kdb v4.4-2.6.12-ia64-1.

2005-06-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc6-ia64-1.

2005-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc5-ia64-1.

2005-05-24 Keith Owens  <kaos@sgi.com>

	* break.b sets cr.iim to 0 instead of the break number.  Deal with it.
	* kdb v4.4-2.6.12-rc4-ia64-3.

2005-05-14 Keith Owens  <kaos@sgi.com>

	* Correct MCA path after calling kdba_mca_bspstore_fixup().
	  Mark Larson, SGI.
	* Tell the user that MCA/INIT is recoverable so kdb is not entered.
	* kdb v4.4-2.6.12-rc4-ia64-2.

2005-05-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc4-ia64-1.

2005-04-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc3-ia64-1.

2005-04-06 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.12-rc2-ia64-1.

2005-04-04 Keith Owens  <kaos@sgi.com>

	* More tweaks to cope with invalid old bspstore in MCA handler.
	* kdb v4.4-2.6.12-rc1-ia64-2.

2005-03-29 Keith Owens  <kaos@sgi.com>

	* Replace __copy_to_user with __copy_to_user_inatomic.
	* MCA handler, do not use old_bspstore if it is in region 4 or below.
	* kdb v4.4-2.6.12-rc1-ia64-1.

2005-03-08 Keith Owens  <kaos@sgi.com>

	* Coexistence patches for lkcd.  Jason Uhlenkott, SGI.
	* kdb v4.4-2.6.11-ia64-2.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFCs7z8i4UHNye0ZOoRAs5IAKDiQW/sXUhPouVtpbvZjVn9G5P6gACfdWAz
Agp0JZbtUvmrS074UEvYygw=
=z5/a
-----END PGP SIGNATURE-----

