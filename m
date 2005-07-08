Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVGHQRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVGHQRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVGHQRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:17:11 -0400
Received: from dude3.usprocom.net ([69.222.0.8]:26631 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S262696AbVGHQRK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:17:10 -0400
Date: Fri,  8 Jul 2005 11:17:31 -0500
Message-Id: <200507081117.AA241041554@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <mingo@elte.hu>
Subject: 2.6.13-rc2 compilation errors with linux1394.org rev.1296
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.13-rc2 compilation errors with linux1394.org rev.1

[....]$ make && make modules
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC [M]  drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_core.c: In function ‘hpsbpkt_thread’:
drivers/ieee1394/ieee1394_core.c:1048: error: too many arguments to function ‘refrigerator’
drivers/ieee1394/ieee1394_core.c: In function ‘ieee1394_init’:
drivers/ieee1394/ieee1394_core.c:1127: warning: implicit declaration of function ‘class_simple_create’
drivers/ieee1394/ieee1394_core.c:1127: warning: assignment makes pointer from integer without a cast
drivers/ieee1394/ieee1394_core.c:1165: warning: implicit declaration of function ‘class_simple_destroy’
make[2]: *** [drivers/ieee1394/ieee1394_core.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2


