Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbULYMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbULYMSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 07:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbULYMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 07:18:13 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:52419 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261277AbULYMR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 07:17:58 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.10 
Date: Sat, 25 Dec 2004 23:17:39 +1100
Message-ID: <18921.1103977059@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Current versions are :-

  kdb-v4.4-2.6.10-common-1.bz2
  kdb-v4.4-2.6.10-i386-1.bz2
  kdb-v4.4-2.6.10-ia64-1.bz2
  kdb-v4.4-2.6.9-rc2-x86-64-1.bz2 (may or may not work with 2.6.10).


Changelog extract since kdb-v4.4-2.6.9-common-1.

2004-12-25 Keith Owens  <kaos@sgi.com>

	* Add kobject command.
	* Ignore low addresses and large offsets in kdbnearsym().
	* Console updates for sn2 simulator.
	* kdb v4.4-2.6.10-common-1.

2004-12-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.10-rc3-common-1.

2004-11-23 Keith Owens  <kaos@sgi.com>

	* Remove warning message from kdb_get_one_user_page(), it was too noisy.
	* kdb v4.4-2.6.10-rc2-common-1.

2004-11-02 Keith Owens  <kaos@sgi.com>

	* Build with kdb patch applied but CONFIG_KDB=n.
	* kdb v4.4-2.6.10-rc1-common-2.

2004-10-29 Keith Owens  <kaos@sgi.com>

	* Handle new compression scheme for kallsyms.
	* Handle move of DEAD and ZOMBIE for task->state to task->exit_state.
	* Tweak the concept of a valid kernel address to get all symbols,
	  including the symbols in the ia64 gate page.
	* kdb v4.4-2.6.10-rc1-common-1.

2004-10-21 Keith Owens  <kaos@sgi.com>

	* Handle variable size for the kernel log buffer.
	* kdb v4.4-2.6.9-common-2.


Changelog extract since kdb-v4.4-2.6.9-i386-1.

2004-12-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.10-i386-1.

2004-12-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.10-rc3-i386-1.

2004-11-23 Keith Owens  <kaos@sgi.com>

	* Coexist with asmlinkage/fastcall changes.
	* kdb v4.4-2.6.10-rc2-i386-1.

2004-10-29 Keith Owens  <kaos@sgi.com>

	* Handle change defintions for hard and soft irq context.
	* Make stack switch in kdb backtrace look more like the oops output.
	* kdb v4.4-2.6.10-rc1-i386-1.



Changelog extract since kdb v4.4-2.6.9-ia64-1.

2004-12-25 Keith Owens  <kaos@sgi.com>

	* Add cpuinfo command.
	* kdb-v4.4-2.6.10-ia64-1.

2004-12-07 Keith Owens  <kaos@sgi.com>

	* Clean up error path in kdba_mca_init.
	* kdb-v4.4-2.6.10-rc3-ia64-1.

2004-11-15 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.10-rc2-ia64-1.

2004-10-29 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.10-rc1-ia64-1.


ps.  Bah, Hum{de}bug!

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFBzVpji4UHNye0ZOoRAmy+AJ4iSaztTqGLjr+Ck0X8+TMdXB41IQCghc/P
p7GtfCEOmVPDj/SVHdecFyw=
=oO+Z
-----END PGP SIGNATURE-----

