Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUGRMoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUGRMoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGRMoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:44:17 -0400
Received: from mout1.freenet.de ([194.97.50.132]:60861 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263962AbUGRMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:44:02 -0400
Message-ID: <40FA7242.7050306@gmx.net>
Date: Sun, 18 Jul 2004 14:51:14 +0200
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc2
References: <2jcIK-73Q-5@gated-at.bofh.it>
In-Reply-To: <2jcIK-73Q-5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling Linux 2.6.8-rc2 I get the following error:

   SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: >>arch/i386/kernel/asm-offsets.s<< ist bereits aktualisiert.
   CHK     include/linux/compile.h
   GZIP    kernel/config_data.gz
   IKCFG   kernel/config_data.h
   CC      kernel/configs.o
   LD      kernel/built-in.o
   CC      drivers/video/console/fbcon.o
drivers/video/console/fbcon.c: In function `accel_putcs':
drivers/video/console/fbcon.c:489: warning: unused variable `dst0'
drivers/video/console/fbcon.c:472: warning: `move_unaligned' might be used uninitialized in this function
drivers/video/console/fbcon.c:475: warning: `move_aligned' might be used uninitialized in this function
drivers/video/console/fbcon.c: In function `fbcon_startup':
drivers/video/console/fbcon.c:733: error: `cursor_timer' undeclared (first use in this function)
drivers/video/console/fbcon.c:733: error: (Each undeclared identifier is reported only once
drivers/video/console/fbcon.c:733: error: for each function it appears in.)
drivers/video/console/fbcon.c: In function `fbcon_init':
drivers/video/console/fbcon.c:795: error: `SCROLL_YNOMOVE' undeclared (first use in this function)
drivers/video/console/fbcon.c:797: error: `SCROLL_YREDRAW' undeclared (first use in this function)
drivers/video/console/fbcon.c:748: warning: unused variable `cap'
drivers/video/console/fbcon.c: In function `fbcon_scroll':
drivers/video/console/fbcon.c:1601: error: `__SCROLL_YMASK' undeclared (first use in this function)
drivers/video/console/fbcon.c:1602: error: `__SCROLL_YMOVE' undeclared (first use in this function)
drivers/video/console/fbcon.c:1609: error: `__SCROLL_YWRAP' undeclared (first use in this function)
make[3]: *** [drivers/video/console/fbcon.o] Fehler 1
make[2]: *** [drivers/video/console] Fehler 2
make[1]: *** [drivers/video] Fehler 2
make: *** [drivers] Fehler 2


Any Idea?

Best regards
