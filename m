Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTHFLA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274882AbTHFLA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:00:28 -0400
Received: from einsteinium.btinternet.com ([194.73.73.147]:11485 "EHLO
	einsteinium.btinternet.com") by vger.kernel.org with ESMTP
	id S270712AbTHFLAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:00:19 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA problem with 2.6.0-test1
Date: Wed, 6 Aug 2003 12:00:13 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061200.14084.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following from my logs this morning, any ideas whats happening.
Both hda and hdb are IDE hard drives. hdb is only used for backups and wasn't being 
used at the time. 

Aug  6 08:30:52 gandalf -- MARK --
Aug  6 08:31:37 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:31:37 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:31:40 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:31:40 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:16 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:16 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:24 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:24 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Aug  6 08:32:26 gandalf kernel: hdb: DMA disabled
Aug  6 08:32:26 gandalf kernel: ide0: reset: success
Aug  6 08:50:52 gandalf -- MARK --

If you need anymore info then just say

Nick

