Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVCZPBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVCZPBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCZPBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:01:02 -0500
Received: from smtp08.web.de ([217.72.192.226]:17325 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261803AbVCZPAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:00:54 -0500
From: Chuck <chunkeey@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Date: Sat, 26 Mar 2005 17:01:08 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503261701.08774.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
> Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
> Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
> Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Mar 25 22:42:55 evenflow kernel:
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
> Mar 25 22:42:55 evenflow kernel:
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command

(something) like the same problem here:  

I get lots of:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown


The disk (WDC WD800JB) is about 1/2 year old. 
I've checked the drive in my old system... nothing!
Also WD's diagnostic kit doesn't report any problems like bad sectors,
or other troubles...  

(Please CC me, I'm not on the list)
