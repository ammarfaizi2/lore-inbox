Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSFVBGf>; Fri, 21 Jun 2002 21:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSFVBGe>; Fri, 21 Jun 2002 21:06:34 -0400
Received: from pD9E235A7.dip.t-dialin.net ([217.226.53.167]:7854 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316629AbSFVBGd>; Fri, 21 Jun 2002 21:06:33 -0400
Date: Fri, 21 Jun 2002 19:06:22 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: [PATCH][2.5] This won't work in ide-pmac.c
Message-ID: <Pine.LNX.4.44.0206211902590.25621-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, you forgot to comment out the last line of this printk!

Index: thunder-2.5/drivers/ide/ide-pmac.c
===================================================================
RCS file: thunder-2.5/drivers/ide/ide-pmac.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-pmac.c
--- thunder-2.5/drivers/ide/ide-pmac.c      21 Jun 2002 15:52:00 -0000      1.1.1.1
+++ thunder-2.5/drivers/ide/ide-pmac.c      22 Jun 2002 01:04:45 -0000
@@ -1491,7 +1491,7 @@
        set_bit(IDE_DMA, drive->channel->active);
 //     if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
 //             printk(KERN_WARNING "ide%d, timeout waiting \
-                               for dbdma command stop\n", ix);
+//                             for dbdma command stop\n", ix);
                return 1;
        }
        udelay(1);

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

