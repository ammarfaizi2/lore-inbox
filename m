Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVAXPVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVAXPVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVAXPVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:21:54 -0500
Received: from corpeumxic2.corp.emc.com ([152.62.121.26]:17679 "EHLO
	corpeumxic2.corp.emc.com") by vger.kernel.org with ESMTP
	id S261522AbVAXPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:21:21 -0500
Message-ID: <50C05B7AA7D6924FB5E384EF14BC647BC451EE@inba1mx2.corp.emc.com>
From: gowda_avinash@emc.com
To: kaos@sgi.com, kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Announce: kdb v4.4 is available for kernel 2.6.10 
Date: Mon, 24 Jan 2005 15:21:08 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All:
I tried to get Kdb working on SuSe 9 ia64 box (kernel version
2.6.5-7.111.19). Turns out that the keyboard/machine goes into a hang state.
I have a usb keyboard!

Googling around I found that Keith had disabled the USB keyboard support
some time back due to changes in some APIs (kernel version
linux-2.6.5-SLES9_SP1_BRANCH).

Is this something that could be a cause for my problem? Should I think about
upgrading my kernel to 2.6.10 (hoping that the issue's been fixed in this
version)?

Thanks,
avinash

-----Original Message-----
From: linux-ia64-owner@vger.kernel.org
[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Keith Owens
Sent: Saturday, December 25, 2004 5:48 PM
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.10 

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

	* Remove warning message from kdb_get_one_user_page(), it was too
noisy.
	* kdb v4.4-2.6.10-rc2-common-1.

2004-11-02 Keith Owens  <kaos@sgi.com>

	* Build with kdb patch applied but CONFIG_KDB=n.
	* kdb v4.4-2.6.10-rc1-common-2.

2004-10-29 Keith Owens  <kaos@sgi.com>

	* Handle new compression scheme for kallsyms.
	* Handle move of DEAD and ZOMBIE for task->state to
task->exit_state.
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

-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
