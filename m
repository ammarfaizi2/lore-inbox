Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVGBJQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGBJQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 05:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGBJQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 05:16:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64516 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261835AbVGBJQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 05:16:02 -0400
Date: Sat, 2 Jul 2005 11:16:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc1-mm1: git-mtd.patch breaks i386 compile
Message-ID: <20050702091600.GF3592@stusta.de>
References: <20050701044018.281b1ebd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701044018.281b1ebd.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  CC      drivers/mtd/chips/cfi_cmdset_0002.o
In file included from drivers/mtd/chips/cfi_cmdset_0002.c:41:
include/linux/mtd/xip.h:78:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support"
include/linux/mtd/xip.h:79:2: warning: #warning "some of the XIP MTD support code will be disabled"
include/linux/mtd/xip.h:80:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash"
drivers/mtd/chips/cfi_cmdset_0002.c:584:26: asm/hardware.h: No such file or directory
...
make[3]: *** [drivers/mtd/chips/cfi_cmdset_0002.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

