Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTGNFG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTGNFG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:06:26 -0400
Received: from zok.sgi.com ([204.94.215.101]:21717 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265653AbTGNFGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:06:24 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.3 is available for kernels 2.4.20, 2.4.21 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jul 2003 15:21:00 +1000
Message-ID: <1441.1058160060@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are kdb-v4.3-2.4.21-common-7.bz2,
kdb-v4.3-2.4.21-i386-4.bz2, kdb-v4.3-2.4.21-ia64-030702-1.bz2.
Changelog extracts.


common

2003-07-14 Keith Owens  <kaos@sgi.com>

	* Correct ll command.
	* kdb v4.3-2.4.21-common-7.

2003-07-08 Keith Owens  <kaos@sgi.com>

	* Export more kdb symbols.  Vamsi Krishna S., IBM.
	* kdb v4.3-2.4.21-common-6.

2003-07-07 Keith Owens  <kaos@sgi.com>

	* Tweak 'waiting for cpus' message.
	* kdb v4.3-2.4.21-common-5.

2003-07-07 Keith Owens  <kaos@sgi.com>

	* 2.4.21-ia64-030702 patches common code that affects kdb.  Workaround
	  this nuisance.
	* kdb v4.3-2.4.21-common-4.

2003-06-24 Keith Owens  <kaos@sgi.com>

	* Add task and sigset commands.  Mark Goodwin, SGI.
	* kdb v4.3-2.4.21-common-3.

2003-06-23 Keith Owens  <kaos@sgi.com>

	* Sync with XFS 2.4.21 tree.
	* kdb v4.3-2.4.21-common-2.


i386

2003-07-08 Keith Owens  <kaos@sgi.com>

	* Add new x86 commands - rdv, gdt, idt, ldt, ldtp, ptex.
	  Vamsi Krishna S., IBM.
	* kdb v4.3-2.4.21-i386-4.

2003-07-01 Keith Owens  <kaos@sgi.com>

	* Convert kdba_find_return() to two passes to reduce false positives.
	* Correct jmp disp8 offset calculation for out of line lock code.
	* Use NMI for kdb IPI in clustered APIC mode.  Sachin Sant, IBM.
	* kdb v4.3-2.4.21-i386-3.

2003-06-23 Keith Owens  <kaos@sgi.com>

	* Sync with XFS 2.4.21 tree.
	* kdb v4.3-2.4.21-i386-2.


ia64

2003-07-08 Keith Owens  <kaos@sgi.com>

	* print_symbol() in mca.c does something useful when kdb is installed.
	* Unwind and SAL changes removed from kdb, they are in the base kernel.
	* kdb v4.3-2.4.21-ia64-030702-1.

