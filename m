Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275369AbTHGO5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275368AbTHGO5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:57:05 -0400
Received: from dhcp75.ists.dartmouth.edu ([129.170.249.155]:49792 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S275387AbTHGOzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:55:08 -0400
Message-Id: <200308071459.h77ExCVt001984@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@odsl.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML build updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Aug 2003 10:59:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/build-2.5

This update brings the UML build up to 2.6.0-test2.

				Jeff

 arch/um/Kconfig                 |   28 ++++++++++++++++
 arch/um/Kconfig_net             |   70 ----------------------------------------
 arch/um/Makefile                |   39 ++++++++++++++--------
 arch/um/Makefile-i386           |   20 +++++++----
 arch/um/Makefile-skas           |    6 +--
 arch/um/config.release          |    1 
 arch/um/defconfig               |    1 
 arch/um/drivers/Makefile        |    2 -
 arch/um/dyn.lds.S               |    8 +++-
 arch/um/kernel/Makefile         |    8 +---
 arch/um/kernel/config.c.in      |    4 --
 arch/um/kernel/skas/Makefile    |   22 +++++++-----
 arch/um/sys-i386/Makefile       |   10 +++--
 arch/um/uml.lds.S               |    8 +++-
 include/asm-um/common.lds.S     |   34 ++++++++++++++++++-
 include/asm-um/module-generic.h |    6 +++
 include/asm-um/module-i386.h    |   13 +++++++
 17 files changed, 158 insertions(+), 122 deletions(-)

ChangeSet@1.1455.16.1, 2003-07-25 09:30:48-04:00, jdike@uml.karaya.com
  Fixed the clash in Kconfig with the binfmt options being moved to
  fs/Kconfig.binfmt.

ChangeSet@1.1215.148.2, 2003-07-17 15:05:33-04:00, jdike@uml.karaya.com
  Added BINFMT_ELF until I catch up to whenever fs/Kconfig.binfmt
  appears.

ChangeSet@1.1215.148.1, 2003-07-17 10:06:21-04:00, jdike@uml.karaya.com
  Untangling my repositories.  Added back the build and config changes.

