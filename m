Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWF0Lox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWF0Lox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWF0Lox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:44:53 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:28199 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932248AbWF0Lov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:44:51 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.17
Date: Tue, 27 Jun 2006 21:45:15 +1000
Message-ID: <16552.1151408715@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated for kernel 2.6.17.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.17-common-1.bz2
  kdb-v4.4-2.6.17-i386-1.bz2
  kdb-v4.4-2.6.17-x86_64-1.bz2
  kdb-v4.4-2.6.17-ia64-1.bz2

SGI is now supporting KDB for x86_64.  Thanks go to Jack Vogel for
looking after the x86_64 patch in the past.

Changelog extract since kdb-v4.4-2.6.16-common-1.

2006-06-19 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-common-1.

2006-05-31 Keith Owens  <kaos@sgi.com>

	* Break spinlocks for keyboard entry.  Hopefully a temporary hack while
	  I track down why keyboard entry to KDB is hanging.
	* kdb v4.4-2.6.17-rc5-common-2.

2006-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc5-common-1.

2006-05-15 Keith Owens  <kaos@sgi.com>

	* Refresh bfd related files from binutils 2.16.91.0.2.
	* kdb v4.4-2.6.17-rc4-common-2.

2006-05-12 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc4-common-1.

2006-04-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc3-common-1.

2006-04-22 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc2-common-1.

2006-04-11 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc1-common-1.

2006-04-05 Keith Owens  <kaos@sgi.com>

	* More fixes for the timing race with KDB_ENTER_SLAVE.
	* kdb v4.4-2.6.16-common-5.

2006-03-30 Keith Owens  <kaos@sgi.com>

	* Some code was testing KDB_IS_RUNNING() twice, which left it open to
	  races.  Cache the result instead.
	* kdb v4.4-2.6.16-common-4.

2006-03-30 Keith Owens  <kaos@sgi.com>

	* Change CONFIG_LKCD to CONFIG_LKCD_DUMP.
	* kdb v4.4-2.6.16-common-3.

2006-03-22 Keith Owens  <kaos@sgi.com>

	* Add some more xpc flags.  Dean Nelson, SGI.
	* Replace open coded counter references with atomic_read().
	* Pass early_uart_console to early_uart_setup().  Francois
	  Wellenreiter, Bull.
	* Replace open code with for_each_online_cpu().
	* If cpus do not come into kdb after a few seconds then let
	  architectures send a more forceful interrupt.
	* Close a timing race with KDB_ENTER_SLAVE.
	* kdb v4.4-2.6.16-common-2.


Changelog extract since kdb-v4.4-2.6.16-i386-1.

2006-06-19 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-i386-1.

2006-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc5-i386-1.

2006-05-15 Keith Owens  <kaos@sgi.com>

	* Refresh bfd related files from binutils 2.16.91.0.2.
	* kdb v4.4-2.6.17-rc4-i386-2.

2006-05-12 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc4-i386-1.

2006-04-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc3-i386-1.

2006-04-22 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc2-i386-1.

2006-04-11 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc1-i386-1.

2006-03-30 Keith Owens  <kaos@sgi.com>

	* Change CONFIG_LKCD to CONFIG_LKCD_DUMP.
	* kdb v4.4-2.6.16-i386-3.

2006-03-24 Keith Owens  <kaos@sgi.com>

	* Define a dummy kdba_wait_for_cpus().
	* kdb v4.4-2.6.16-i386-2.

2006-03-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.16-i386-1.


Changelog extract since kdb-v4.4-2.6.16-x86_64-1.

2006-06-19 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-x86_64-1.

2006-05-31 Keith Owens  <kaos@sgi.com>

	* Define arch/x86_64/kdb/kdb_cmds.
	* kdb v4.4-2.6.17-rc5-x86_64-2.

2006-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc5-x86_64-1.

2006-05-15 Keith Owens  <kaos@sgi.com>

	* Refresh bfd related files from binutils 2.16.91.0.2.
	* kdb v4.4-2.6.17-rc4-x86_64-2.

2006-05-12 Keith Owens <kaos@sgi.com>

	* kdb v4.4-2.6-17-rc4-x86_64-1.

2006-04-22 Keith Owens <kaos@sgi.com>

	* kdb v4.4-2.6-17-rc2-x86_64-1.

2006-04-13 Keith Owens <kaos@sgi.com>

	* Remove trailing white space.
	* kdb v4.4-2.6-17-rc1-x86_64-1.


Changelog extract since kdb v4.4-2.6.16-ia64-1.

2006-06-19 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-ia64-1.

2006-05-25 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc5-ia64-1.

2006-05-15 Keith Owens  <kaos@sgi.com>

	* Refresh bfd related files from binutils 2.16.91.0.2.
	* kdb v4.4-2.6.17-rc4-ia64-2.

2006-05-12 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc4-ia64-1.

2006-04-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc3-ia64-1.

2006-04-22 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc2-ia64-1.

2006-04-11 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.17-rc1-ia64-1.

2006-03-30 Keith Owens  <kaos@sgi.com>

	* Change CONFIG_LKCD to CONFIG_LKCD_DUMP.
	* kdb v4.4-2.6.16-ia64-3.

2006-03-24 Keith Owens  <kaos@sgi.com>

	* Use INIT to interrupt cpus that do not respond to a normal kdb IPI.
	* Remove KDBA_MCA_TRACE from arch/ia64/kernel/mca.c.
	* kdb v4.4-2.6.16-ia64-2.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFEoRpLi4UHNye0ZOoRAhG1AJ0XUg1rd8KAStkeCUOoHV+ycUM2MACgjwiu
imsfNOlUoNZDgqwhsrzBjDA=
=KMkV
-----END PGP SIGNATURE-----

