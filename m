Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTDCWFu 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263587AbTDCWFt 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 17:05:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263586AbTDCWFs 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 17:05:48 -0500
Subject: Compile warning in 2.5.66-bk latest
From: Stephen Hemminger <shemminger@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1049408232.22772.1.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Apr 2003 14:17:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcc 3.2 with latest 2.5.66-bk

gcc -Wp,-MD,drivers/block/.elevator.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=elevator -DKBUILD_MODNAME=elevator -c -o drivers/block/.tmp_elevator.o drivers/block/elevator.c
fs/jbd/transaction.c:670:53: warning: pasting "KERN_ERR" and ""Possible IO failure.\n"" does not give a valid preprocessing token



