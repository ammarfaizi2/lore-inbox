Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVILUEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVILUEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVILUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:04:43 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:26336 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751120AbVILUEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:04:42 -0400
Message-ID: <20280934.1126555480946.JavaMail.ngmail@webmail-07.arcor-online.net>
Date: Mon, 12 Sep 2005 22:04:40 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-git 2ade81473636b33aaac64495f89a7dc572c529f0 -
 acpi/earlyquirk.c doesn't compile
Cc: 76306.1226@compuserve.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.58.169.117
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/i386/kernel/acpi/earlyquirk.o
arch/i386/kernel/acpi/earlyquirk.c: In function `check_bridge':
arch/i386/kernel/acpi/earlyquirk.c:24: error: `disable_timer_pin_1' undeclared (first use in this function)
arch/i386/kernel/acpi/earlyquirk.c:24: error: (Each undeclared identifier is reported only once
arch/i386/kernel/acpi/earlyquirk.c:24: error: for each function it appears in.)
make[2]: *** [arch/i386/kernel/acpi/earlyquirk.o] Error 1
make[1]: *** [arch/i386/kernel/acpi] Error 2
make: *** [arch/i386/kernel] Error 2

author  Chuck Ebbert <76306.1226@compuserve.com>
   Mon, 12 Sep 2005 16:49:25 +0000 (18:49 +0200)
  committer  Linus Torvalds <torvalds@g5.osdl.org>
   Mon, 12 Sep 2005 17:50:58 +0000 (10:50 -0700)
  commit  66759a01adbfe8828dd063e32cf5ed3f46696181
  tree  9d34afafa1e4e5371a0e732a3f949ef8ac533ab5
  parent  049cdefe19f95b67b06b70915cd8e4ae7173337a

