Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVJ1H35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVJ1H35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVJ1H35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:29:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49356 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965162AbVJ1H34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:29:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.14
Date: Fri, 28 Oct 2005 17:29:43 +1000
Message-ID: <5859.1130484583@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated for kernel 2.6.14.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.14-common-1.bz2
  kdb-v4.4-2.6.14-i386-1.bz2
  kdb-v4.4-2.6.14-ia64-1.bz2

The register display (rd, r) and register modify (rm) commands now work
for tasks that were running when MCA/INIT was delivered.

There is a small change in the behaviour of rd/rm after you use the
pid, btt, btp and btc commands.  I recommend that you read the rd and
bt man pages in Documentation/kdb, pay attention to KDB's notion of the
"current task" when working with registers.

Changelog extract since kdb-v4.4-2.6.13-common-1.

2005-10-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-common-1.

2005-10-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc5-common-1.

2005-10-11 Keith Owens  <kaos@sgi.com>

	* Handle removal of USB keyboard.  Aaron Young, SGI.
	* kdb v4.4-2.6.14-rc4-common-1.

2005-10-05 Keith Owens  <kaos@sgi.com>

	* Extend kdb_notifier_list() codes to include dumping.
	* Use emergency_restart() for reboot, it can be called from interrupt
	  context, unlike machine_restart().
	* kdb v4.4-2.6.14-rc3-common-1.

2005-09-21 Keith Owens  <kaos@sgi.com>

	* Support kdb_current_task in register display and modify commands.
	* Document what changes kdb's notion of the current task.
	* Update rd documentation for IA64.
	* Move some definictions to kdbprivate.h and remove some unused symbol
	  exports.
	* kdb v4.4-2.6.14-rc2-common-1.

2005-09-20 Keith Owens  <kaos@sgi.com>

	* Document IA64 handlers command.
	* Add more fields to the task command.
	* Cope with MCA/INIT handlers in the ps command.
	* Namespace cleanup, delete unused exports, make some functions static.
	* Add a kdb_notifier_list callback when kdb is about to reboot the
	  system.
	* kdb v4.4-2.6.14-rc1-common-1.


Changelog extract since kdb-v4.4-2.6.13-i386-1.

2005-10-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-i386-1.

2005-10-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc5-i386-1.

2005-10-11 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc4-i386-1.

2005-10-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc3-i386-1.

2005-09-21 Keith Owens  <kaos@sgi.com>

	* Support kdb_current_task in register display and modify commands.
	* kdb v4.4-2.6.14-rc2-i386-1.

2005-09-20 Keith Owens  <kaos@sgi.com>

	* Remove use of __STDC_VERSION__ in ansidecl.h.
	* kdb v4.4-2.6.14-rc1-i386-1.


Changelog extract since kdb v4.4-2.6.13-ia64-1.

2005-10-28 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-ia64-1.

2005-10-21 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc5-ia64-1.

2005-10-11 Keith Owens  <kaos@sgi.com>

	* Handle removal of USB keyboard.  Aaron Young, SGI
	* kdb v4.4-2.6.14-rc4-ia64-1.

2005-10-04 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.14-rc3-ia64-1.

2005-09-21 Keith Owens  <kaos@sgi.com>

	* Support kdb_current_task in register display and modify commands.
	* kdb v4.4-2.6.14-rc2-ia64-1.

2005-09-20 Keith Owens  <kaos@sgi.com>

	* Coexist with kprobes.
	* Coexist with MCA/INIT rewrite.
	* Add KDB_ENTER_SLAVE to handle concurrent entry to kdb from multiple
	  cpus.
	* Add handlers command to control whether the MCA/INIT task or the
	  original task is displayed.
	* Namespace clean up, remove unused kdba_sw_interrupt.
	* kdb v4.4-2.6.14-rc1-ia64-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFDYdNni4UHNye0ZOoRAjsBAJ9c65ND3qM321G48CD/rl8Py5+h7ACfdc28
r4niIGhux3YL7d6Blqv7RBA=
=vEhG
-----END PGP SIGNATURE-----

