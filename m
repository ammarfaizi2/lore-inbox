Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUBKEQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 23:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUBKEQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 23:16:58 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29651 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262888AbUBKEQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 23:16:54 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernel 2.4.25-rc1
Date: Wed, 11 Feb 2004 15:16:18 +1100
Message-ID: <4730.1076472978@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are :-
  kdb-v4.3-2.4.25-rc1-common-1.bz2
  kdb-v4.3-2.4.25-rc1-i386-1.bz2
  kdb-v4.3-2.4.25-rc1-ia64-cset-1.1069.246.14-to-1.1166-1.bz2

Before applying kdb for ia64, you must apply the 2.4.25-rc1 BK patch,
the first link on
ftp://ftp.kernel.org/pub/linux/kernel/ports/ia64/v2.4/testing/cset/index.html.

Changelog extracts since 2.4.23.

common

2004-02-11 Keith Owens  <kaos@sgi.com>

	* Convert longjmp buffers from static to dynamic allocation, for large
	  cpu counts.
	* Tweak kdbm_task for SMP/UP.
	* Update to 2.4.25-rc1.
	* Simplify coexistence with NPTL patches.
	* Support kill command on new scheduler.
	* Do not refetch data when printing a value as characters.
	* Document the pid command.
	* kdb v4.3-2.4.25-rc1-common-1.


i386

2004-02-11 Keith Owens  <kaos@sgi.com>

	* Adjust for LDT changes in i386 mainline.
	* kdb v4.3-2.4.25-rc1-i386-1.


ia64

2004-02-11 Keith Owens  <kaos@sgi.com>

	* Convert longjmp buffers from static to dynamic allocation, for large
	  cpu counts.
	* Update to 2.4.25-rc1 bk, including rework of mca.c patch after the
	  major clean up of mca.c.
	* Redo KDBA_MCA_TRACE to get more diagnostics for MCA/INIT events.
	* Handle recoverable MCA/INIT events, kdb traces them but does not drop
	  into kdb.
	* kdb v4.3-2.4.25-rc1-ia64-cset-1.1069.246.14-to-1.1166-1.


Porting kdb v4.3 to 2.6.[23] is now in progress.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFAKaySi4UHNye0ZOoRAvEtAJ0fP2WvSAaT91nfbUdpFrbKQegMWwCgt1TR
8mTZeytw7+nch3FEe+wsFJc=
=KATc
-----END PGP SIGNATURE-----

