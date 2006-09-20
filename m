Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWITFhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWITFhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 01:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWITFhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 01:37:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8166 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751200AbWITFht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 01:37:49 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.18
Date: Wed, 20 Sep 2006 15:37:43 +1000
Message-ID: <9583.1158730663@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shiver me timbers, lads.

KDB (Linux Kernel Debugger) has been updated for kernel 2.6.18.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.18-common-1.bz2
  kdb-v4.4-2.6.18-i386-1.bz2
  kdb-v4.4-2.6.18-x86_64-1.bz2
  kdb-v4.4-2.6.18-ia64-1.bz2

Changelog extract since kdb-v4.4-2.6.17-common-1.

2006-09-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-common-1.

2006-09-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc7-common-1.

2006-08-29 Keith Owens  <kaos@sgi.com>

	* Rewrite all backtrace code.
	* kdb v4.4-2.6.18-rc5-common-2.

2006-08-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc5-common-1.

2006-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc4-common-1.

2006-08-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc3-common-1.

2006-07-18 Keith Owens  <kaos@sgi.com>

	* 8250.c locking has been fixed so there is no need to break spinlocks
	  for keyboard entry.
	* kdb v4.4-2.6.18-rc2-common-2.

2006-07-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc2-common-1.

2006-07-12 Keith Owens  <kaos@sgi.com>

	* Remove dead KDB_REASON codes.
	* The main kdb() function is now always entered with interrupts
	  disabled, so there is no need to disable bottom halves.
	* sparse cleanups.
	* kdb v4.4-2.6.18-rc1-common-2.

2006-07-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc1-common-1.

2006-07-04 Keith Owens  <kaos@sgi.com>

	* Add KDB_REASON_CPU_UP and callbacks for cpus coming online.
	* Relegate KDB_REASON_SILENT to KDB internal use only.
	* Backout the v4.4-2.6.15-common-3 change that made KDB_REASON_SILENT
	  wait for cpus, the Dell Xeon problem has been fixed.
	* notify_die() is not called for KDB_REASON_SILENT nor
	  KDB_REASON_CPU_UP, these events do not stay in KDB.
	* Export kdb_current_task for kdbm_x86.  SuSE patch
	  kdb-missing-export.diff
	* Scale kdb_wait_for_cpus_secs by the number of online cpus.
	* Delete kdb_enablehwfault, architectures now do their own setup.
	* Delete kdba_enable_mce, architectures now do their own setup.
	* Delete kdba_enable_lbr, kdba_disable_lbr, kdba_print_lbr,
	  page_fault_mca.  Only ever implemented on x86, difficult to maintain
	  and rarely used in the field.
	* Replace #ifdef KDB_HAVE_LONGJMP with #ifdef kdba_setjmp.
	* kdb v4.4-2.6.17-common-2.


Changelog extract since kdb-v4.4-2.6.17-i386-1.

2006-09-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-i386-1.

2006-09-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc7-i386-1.

2006-08-30 Keith Owens  <kaos@sgi.com>

	* Add warning for problems when following alternate stacks.
	* kdb v4.4-2.6.18-rc5-i386-3.

2006-08-29 Keith Owens  <kaos@sgi.com>

	* Rewrite all backtrace code.
	* kdb v4.4-2.6.18-rc5-i386-2.

2006-08-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc5-i386-1.

2006-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc4-i386-1.

2006-08-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc3-i386-1.

2006-07-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc2-i386-1.

2006-07-12 Keith Owens  <kaos@sgi.com>

	* Remove dead KDB_REASON codes.
	* sparse cleanups.
	* kdb v4.4-2.6.18-rc1-i386-2.

2006-07-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc1-i386-1.

2006-07-04 Keith Owens  <kaos@sgi.com>

	* Make KDB rendezvous on i386 a two stage approach.
	* Clean up generation of KDB interrupt code.
	* Move smp_kdb_stop() and smp_kdb_interrupt() to kdbasupport.c.
	* Move setting of interrupt traps to kdbasupport.c.
	* Remove KDB hooks from arch/i386/kernel smp.c, smpboot.c, i8259.c,
	  io_apic.c.
	* Add KDB_REASON_CPU_UP support.
	* Move per cpu setup to kdba_cpu_up().
	* Rework support for 4K stacks to make backtrace more accurate.
	* Add BTSP option to get the full backtrace, including kdb routines.
	* Delete kdba_enable_mce, architectures now do their own setup.
	* Delete kdba_enable_lbr, kdba_disable_lbr, kdba_print_lbr,
	  page_fault_mca.  Only ever implemented on x86, difficult to maintain
	  and rarely used in the field.
	* Replace #ifdef KDB_HAVE_LONGJMP with #ifdef kdba_setjmp.
	* kdb v4.4-2.6.17-i386-2.


Changelog extract since kdb-v4.4-2.6.17-x86_64-1.

2006-09-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-x86_64-1.

2006-09-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc7-x86_64-1.

2006-08-30 Keith Owens  <kaos@sgi.com>

	* Do not print debugstackptr in cpu_pda, it will be deleted soon.
	* Add KDB_ENTER().
	* Add warning for problems when following alternate stacks.
	* kdb v4.4-2.6.18-rc5-x86_64-3.

2006-08-29 Keith Owens  <kaos@sgi.com>

	* Rewrite all backtrace code.
	* Add pt_regs and cpu_pda commands.
	* Include patch to define orig_ist, to be removed once that patch is in
	  the community tree.
	* kdb v4.4-2.6.18-rc5-x86_64-2.

2006-08-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc5-x86_64-1.

2006-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc4-x86_64-1.

2006-08-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc3-x86_64-1.

2006-07-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc2-x86_64-1.

2006-07-12 Keith Owens  <kaos@sgi.com>

	* sparse cleanups
	* kdb v4.4-2.6.18-rc1-x86_64-2.

2006-07-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc1-x86_64-1.

2006-07-04 Keith Owens  <kaos@sgi.com>

	* Make KDB rendezvous on x86_64 a two stage approach.
	* Move smp_kdb_stop() and smp_kdb_interrupt() to kdbasupport.c.
	* Move setting of interrupt traps to kdbasupport.c.
	* Add KDB_REASON_CPU_UP support.
	* Move per cpu setup to kdba_cpu_up().
	* Delete kdba_enable_mce, architectures now do their own setup.
	* Delete kdba_enable_lbr, kdba_disable_lbr, kdba_print_lbr,
	  page_fault_mca.  Only ever implemented on x86, difficult to maintain
	  and rarely used in the field.
	* Replace #ifdef KDB_HAVE_LONGJMP with #ifdef kdba_setjmp.
	* kdb v4.4-2.6.17-x86_64-2.


Changelog extract since kdb v4.4-2.6.17-ia64-1.

2006-09-20 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-ia64-1.

2006-09-15 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc7-ia64-1.

2006-08-29 Keith Owens  <kaos@sgi.com>

	* Rewrite all backtrace code.
	* kdb v4.4-2.6.18-rc5-ia64-2.

2006-08-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc5-ia64-1.

2006-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc4-ia64-1.

2006-08-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc3-ia64-1.

2006-07-18 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc2-ia64-1.

2006-07-12 Keith Owens  <kaos@sgi.com>

	* Remove dead KDB_REASON codes.
	* sparse cleanups.
	* kdb v4.4-2.6.18-rc1-ia64-2.

2006-07-07 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.18-rc1-ia64-1.

2006-07-04 Keith Owens  <kaos@sgi.com>

	* Delete kdba_enable_lbr, kdba_disable_lbr, kdba_print_lbr,
	  page_fault_mca.  Only ever implemented on x86, difficult to maintain
	  and rarely used in the field.
	* Replace #ifdef KDB_HAVE_LONGJMP with #ifdef kdba_setjmp.
	* kdb v4.4-2.6.17-ia64-2.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFFENOmi4UHNye0ZOoRAie6AJ4qUi/SOPxkZpNmx5R2KaiiMajlPACeJ3Kq
jVB5YpQzXhIPGxsGhAlvl24=
=TEzl
-----END PGP SIGNATURE-----

