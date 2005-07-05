Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVGEXuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVGEXuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGEXuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:50:12 -0400
Received: from dude3.usprocom.net ([69.222.0.8]:22290 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S262019AbVGEXt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:49:57 -0400
Date: Tue,  5 Jul 2005 18:50:19 -0500
Message-Id: <200507051850.AA6685496@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.13-rc1-git7 and ieee1394 rev.1294 compilation errors
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel 2.6.13-rc1-git7 and ieee1394 rev.1294 from ieee1394.org compilation errors

[....]$ make && make modules
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  LD      drivers/ieee1394/built-in.o
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

any clue???

thanx

xboom

