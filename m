Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHFOH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTHFOH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:07:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28887 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262439AbTHFOH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:07:56 -0400
Date: Wed, 6 Aug 2003 16:07:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nick Sanders <sandersn@btinternet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problem with 2.6.0-test1
In-Reply-To: <200308061200.14084.sandersn@btinternet.com>
Message-ID: <Pine.SOL.4.30.0308061605080.29509-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check your IDE cables.

On Wed, 6 Aug 2003, Nick Sanders wrote:

> Hi,
>
> I got the following from my logs this morning, any ideas whats happening.
> Both hda and hdb are IDE hard drives. hdb is only used for backups and wasn't being
> used at the time.
>
> Aug  6 08:30:52 gandalf -- MARK --
> Aug  6 08:31:37 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:31:37 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:31:40 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:31:40 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:16 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:16 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:24 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:24 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug  6 08:32:26 gandalf kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Aug  6 08:32:26 gandalf kernel: hdb: DMA disabled
> Aug  6 08:32:26 gandalf kernel: ide0: reset: success
> Aug  6 08:50:52 gandalf -- MARK --
>
> If you need anymore info then just say
>
> Nick

