Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSLGSfL>; Sat, 7 Dec 2002 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLGSfL>; Sat, 7 Dec 2002 13:35:11 -0500
Received: from mnh-1-09.mv.com ([207.22.10.41]:37892 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264697AbSLGSfK>;
	Sat, 7 Dec 2002 13:35:10 -0500
Message-Id: <200212071846.NAA02017@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update UML to 2.5.50
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 07 Dec 2002 13:46:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/updates-2.5
or	http://jdike.stearns.org:5000/updates-2.5

The only functional UML changes are those that are left over from my
last pull request:

	build cleanups
	an updated defconfig
	bug fixes in the console and serial line drivers
	the block driver again supports partitions
	more symbols exported
	SMP fixes
	interrupt handling fixes
	hook in the new system calls

				Jeff

 arch/um/Kconfig                 |    1 +
 arch/um/drivers/line.c          |    1 +
 arch/um/kernel/process_kern.c   |    2 +-
 arch/um/kernel/ptrace.c         |    3 +--
 arch/um/kernel/sys_call_table.c |   16 ++++++++--------
 arch/um/kernel/syscall_kern.c   |    6 +++---
 arch/um/kernel/sysrq.c          |    8 ++++----
 arch/um/sys-i386/Makefile       |   36 +++++++++++++++++-------------------
 arch/um/uml.lds.S               |    1 +
 include/asm-um/pgtable.h        |    6 +++---
 include/asm-um/uaccess.h        |    2 +-
 11 files changed, 41 insertions(+), 41 deletions(-)

ChangeSet@1.930, 2002-12-06 21:29:24-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.929, 2002-12-06 21:23:55-05:00, jdike@uml.karaya.com
  Updated to 2.5.50.

ChangeSet@1.927.1.1, 2002-12-06 19:15:18-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.928, 2002-11-30 14:18:23-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.842.47.2, 2002-11-23 19:25:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.49, which involved fixing the calls to do_fork.

ChangeSet@1.842.6.4, 2002-11-21 23:21:41-05:00, jdike@uml.karaya.com
  Removed the checksum.S symlink from arch/um/sys-i386/Makefile.

ChangeSet@1.842.6.3, 2002-11-21 14:05:13-05:00, jdike@uml.karaya.com
  Changed the config to pull in zlib.

ChangeSet@1.842.6.2, 2002-11-18 20:03:13-05:00, jdike@uml.karaya.com
  A few more fixes to get 2.4.48 to boot.

ChangeSet@1.842.6.1, 2002-11-18 15:57:00-05:00, jdike@uml.karaya.com
  Updated to 2.5.48


