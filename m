Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263996AbTCWXXa>; Sun, 23 Mar 2003 18:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263995AbTCWXXa>; Sun, 23 Mar 2003 18:23:30 -0500
Received: from mail134.mail.bellsouth.net ([205.152.58.94]:38789 "EHLO
	imf46bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S263996AbTCWXX2>; Sun, 23 Mar 2003 18:23:28 -0500
Subject: USB compile error with latest 2.5-bk
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048462471.1739.1.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 23 Mar 2003 18:34:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running RH phoebe beta

 gcc -Wp,-MD,drivers/usb/core/.hcd.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=hcd
-DKBUILD_MODNAME=usbcore -c -o drivers/usb/core/.tmp_hcd.o
drivers/usb/core/hcd.c
drivers/usb/core/hcd.c:124: parse error before '>>' token
drivers/usb/core/hcd.c:124: initializer element is not constant
drivers/usb/core/hcd.c:124: (near initialization for
`usb2_rh_dev_descriptor[12]')
drivers/usb/core/hcd.c:124: parse error before '>>' token
drivers/usb/core/hcd.c:124: initializer element is not constant
drivers/usb/core/hcd.c:124: (near initialization for
`usb2_rh_dev_descriptor[13]')
drivers/usb/core/hcd.c:147: parse error before '>>' token
drivers/usb/core/hcd.c:147: initializer element is not constant
drivers/usb/core/hcd.c:147: (near initialization for
`usb11_rh_dev_descriptor[12]')
drivers/usb/core/hcd.c:147: parse error before '>>' token
drivers/usb/core/hcd.c:147: initializer element is not constant
drivers/usb/core/hcd.c:147: (near initialization for
`usb11_rh_dev_descriptor[13]')
make[4]: *** [drivers/usb/core/hcd.o] Error 1
make[3]: *** [drivers/usb/core] Error 2
make[2]: *** [drivers/usb] Error 2
make[1]: *** [drivers] Error 2
make: *** [all] Error 2


