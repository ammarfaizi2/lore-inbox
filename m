Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTBFDJF>; Wed, 5 Feb 2003 22:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTBFDJF>; Wed, 5 Feb 2003 22:09:05 -0500
Received: from mnh-1-13.mv.com ([207.22.10.45]:64260 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265262AbTBFDJE>;
	Wed, 5 Feb 2003 22:09:04 -0500
Message-Id: <200302060312.WAA04448@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updated to 2.5.59
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Feb 2003 22:12:55 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This makes a number of small changes that bring UML up to date to 2.5.59.

				Jeff

 arch/um/Kconfig                 |   11 +++
 arch/um/defconfig               |  128 ++++++++++++++++++++--------------------
 arch/um/kernel/ksyms.c          |    1 
 arch/um/kernel/process.c        |   18 ++---
 arch/um/kernel/smp.c            |    5 -
 arch/um/kernel/sys_call_table.c |    2 
 arch/um/sys-i386/Makefile       |    3 
 arch/um/sys-i386/extable.c      |   30 +++++++++
 arch/um/sys-i386/fault.c        |    2 
 arch/um/vmlinux.lds.S           |   11 +++
 include/asm-um/bug.h            |   18 +++++
 include/asm-um/module.h         |    9 ++
 include/asm-um/page.h           |   17 -----
 13 files changed, 159 insertions(+), 96 deletions(-)

ChangeSet@1.962, 2003-01-19 11:31:54-05:00, jdike@uml.karaya.com
  Added vmlinux.lds.S which is now necessary for linking the vmlinux
  object file.

ChangeSet@1.960, 2003-01-18 13:10:06-05:00, jdike@uml.karaya.com
  Changed some CONFIG_* names to UML_CONFIG_* names.

ChangeSet@1.959, 2003-01-17 22:23:36-05:00, jdike@uml.karaya.com
  Some SMP fixes.

ChangeSet@1.958, 2003-01-17 14:54:10-05:00, jdike@uml.karaya.com
  Fixed asm/modules.h to update UML to 2.5.59.

ChangeSet@1.914.15.1, 2003-01-16 10:44:25-05:00, jdike@uml.karaya.com
  Updates to bring UML up to 2.5.58.

