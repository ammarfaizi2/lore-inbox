Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbTDBTSa>; Wed, 2 Apr 2003 14:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbTDBTSa>; Wed, 2 Apr 2003 14:18:30 -0500
Received: from [207.61.129.108] ([207.61.129.108]:20144 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S263126AbTDBTS3>; Wed, 2 Apr 2003 14:18:29 -0500
From: Shawn Starr <spstarr@sh0n.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109 spinlock notice
Date: Wed, 2 Apr 2003 14:29:49 -0500
User-Agent: KMail/1.5
Cc: desai@mcs.anl.gov, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304021429.49589.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>List:     linux-kernel
>Subject:  2.5.66-bk5 spinlock warnings/errors
From:     Narayan Desai <desai () mcs ! anl ! gov>
>Date:     2003-04-02 4:01:02

>hda: dma_timer_expiry: dma status == 0x24
>drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c037abe8) already 
>locked by drivers/ide/ide-io.c/948 drivers/ide/ide-io.c:990: 
>spin_unlock(drivers/ide/ide.c:c037abe8) not locked
>hda: lost interrupt
>hda: dma_intr: bad DMA status (dma_stat=30)
>hda: dma_intr: status=0x50 { DriveReady SeekComplete }

I had this problem last night while making a huge debian package (tar.bz2 
stage). It occured once.

Switching to Debian unstable and already two new interesting kernel notices 
and one 3c59x  NETDEV Watchdog - eth0 transmit timeout bug.




