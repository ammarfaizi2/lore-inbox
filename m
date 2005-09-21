Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVIUGXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVIUGXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 02:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIUGXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 02:23:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17107 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932129AbVIUGXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 02:23:13 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.14-rc2
Date: Wed, 21 Sep 2005 16:21:11 +1000
Message-ID: <8905.1127283671@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.14-rc2-common-1.bz2
  kdb-v4.4-2.6.14-rc2-i386-1.bz2
  kdb-v4.4-2.6.14-rc2-ia64-1.bz2

The register display (rd, r) and register modify (rm) commands now work
for tasks that were running when MCA/INIT was delivered.

There is a small change in the behaviour of rd/rm after you use the
pid, btt, btp and btc commands.  I recommend that you read the rd and
bt man pages in Documentation/kdb, pay attention to KDB's notion of the
"current task" when working with registers.

Changelog extract since kdb-v4.4-2.6.13-common-1.

2005-09-21 Keith Owens  <kaos@sgi.com>

	* Support kdb_current_task in register display and modify commands.
	* Document what changes kdb's notion of the current task.
	* Update rd documentation for IA64.
	* Move some definitions to kdbprivate.h and remove some unused symbol
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

2005-09-21 Keith Owens  <kaos@sgi.com>

	* Support kdb_current_task in register display and modify commands.
	* kdb v4.4-2.6.14-rc2-i386-1.

2005-09-20 Keith Owens  <kaos@sgi.com>

	* Remove use of __STDC_VERSION__ in ansidecl.h.
	* kdb v4.4-2.6.14-rc1-i386-1.


Changelog extract since kdb v4.4-2.6.13-ia64-1.

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

iD8DBQFDMPvXi4UHNye0ZOoRAkEtAKCj7n5RUJ31iP3xjPFx1M1rZAemUQCePHiL
Fgaq2p2ceW8p771aCY5OIQQ=
=CiVw
-----END PGP SIGNATURE-----

