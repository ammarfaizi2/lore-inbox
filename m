Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTEMTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbTEMTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:35:29 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:13273 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262324AbTEMTf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:35:28 -0400
Date: Tue, 13 May 2003 21:48:13 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Message-ID: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on 2.5.69-dj1 (so it's a 2.5.69-bk5 kernel) i found these two in my kernel
log, which i have not seen before. There are just 2 occurences of that.
Is that something about a hardware failure, or something else?


15:04:01 pysiak kernel: hdb: dma_timer_expiry: dma status == 0x64
15:04:01 pysiak kernel: hdb: lost interrupt
15:04:01 pysiak kernel: hdb: dma_intr: bad DMA status (dma_stat=70)
15:04:01 pysiak kernel: hdb: dma_intr: status=0x50 { DriveReady SeekComplete }
15:04:01 pysiak kernel:
17:14:04 pysiak kernel: hdb: dma_timer_expiry: dma status == 0x64
17:14:04 pysiak kernel: hdb: lost interrupt
17:14:04 pysiak kernel: hdb: dma_intr: bad DMA status (dma_stat=70)
17:14:04 pysiak kernel: hdb: dma_intr: status=0x50 { DriveReady SeekComplete }


/dev/hdb:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 38792/16/63, sectors = 39102336, start = 0

Regards,
Maciej

