Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271705AbTGXQNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271706AbTGXQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:13:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6321 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271705AbTGXQNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:13:32 -0400
Date: Thu, 24 Jul 2003 18:28:07 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] 2.6.0-test1: (__ide_dma_test_irq) called while not waiting
In-Reply-To: <87r84g5huh.wl%deepfire@ibe.miee.ru>
Message-ID: <Pine.SOL.4.30.0307241817200.3009-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please try -bk tree or 2.6.0-test1-bk2 snapshot.

On Thu, 24 Jul 2003, Samium Gromoff wrote:

> That is an intel i443bx ide controller, with a rather dated 2gb
> quantum pioneer attached to it.
>
> That i get rather repeatable, sometimes:
>
> Jul 22 19:57:17 betelheise kernel: hda: dma_timer_expiry: dma status == 0x21
> Jul 22 19:57:27 betelheise kernel: hda: timeout waiting for DMA
> Jul 22 19:57:27 betelheise kernel: hda: timeout waiting for DMA
> Jul 22 19:57:27 betelheise kernel: hda: (__ide_dma_test_irq) called while not waiting
> Jul 22 19:57:27 betelheise kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> Jul 22 19:57:27 betelheise kernel:
> Jul 22 19:57:27 betelheise kernel: hda: drive not ready for command
> Jul 22 19:57:49 betelheise kernel: hda: dma_timer_expiry: dma status == 0x21
> hda: timeout waiting for DMA
> hda: timeout waiting for DMA
> hda: (__ide_dma_test_irq) called while not waiting
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>
> hda: drive not ready for command
> Jul 22 19:57:59 betelheise kernel: hda: timeout waiting for DMA
> Jul 22 19:57:59 betelheise kernel: hda: timeout waiting for DMA
> Jul 22 19:57:59 betelheise kernel: hda: (__ide_dma_test_irq) called while not waiting
> Jul 22 19:57:59 betelheise kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> Jul 22 19:57:59 betelheise kernel:
> Jul 22 19:57:59 betelheise kernel: hda: drive not ready for command

