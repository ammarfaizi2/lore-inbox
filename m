Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGYICk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGYICk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 04:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGYICk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 04:02:40 -0400
Received: from smtpout3.compass.net.nz ([203.97.97.135]:65504 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S263736AbUGYICi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 04:02:38 -0400
Date: Sun, 25 Jul 2004 20:03:10 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-rc3 with gcc-3.4.0 compile error (even with the fix patch)
Message-ID: <Pine.LNX.4.53.0407251959350.12579@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I got the error when compiling ...

The kernel has the gcc-3.4 fix patch

make[3]: Entering directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=net2280  -DEXPORT_SYMTAB -c net2280.c
net2280.c: In function `write_fifo':
net2280.c:540: error: `typeof' applied to a bit-field
net2280.c: In function `handle_ep_small':
net2280.c:2194: error: `typeof' applied to a bit-field
make[3]: *** [net2280.o] Error 1
make[3]: Leaving directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
make[1]: *** [_subdir_usb/gadget] Error 2
make[1]: Leaving directory `/home/linux-2.4.27-rc3/drivers'
make: *** [_dir_drivers] Error 2

with gcc-3.3.3 all were okay.

Best regards,

Steve Kieu
