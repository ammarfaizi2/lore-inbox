Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRGEWkJ>; Thu, 5 Jul 2001 18:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbRGEWj7>; Thu, 5 Jul 2001 18:39:59 -0400
Received: from intranet.resilience.com ([209.245.157.33]:9357 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S265277AbRGEWjv>; Thu, 5 Jul 2001 18:39:51 -0400
Message-ID: <3B44EDB7.ABD9D60A@resilience.com>
Date: Thu, 05 Jul 2001 15:44:07 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Small compile error with MTD driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I just downloaded the 2.4.6 kernel and got a compile error while
building the mtd driver as a module.  The following patch addresses the
issue and I apologize if someone has already sent this in.

-Jeff

--- 2.4.6.clean/include/linux/mtd/cfi.h   Thu Jul  5 15:03:47 2001
+++ 2.4.6/include/linux/mtd/cfi.h Thu Jul  5 15:30:43 2001
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 #include <linux/mtd/flashchip.h>
 #include
<linux/mtd/cfi_endian.h>                                                                        

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
