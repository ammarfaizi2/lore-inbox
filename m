Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130759AbRA3UwG>; Tue, 30 Jan 2001 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRA3Uv4>; Tue, 30 Jan 2001 15:51:56 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:55311
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130759AbRA3Uvn>; Tue, 30 Jan 2001 15:51:43 -0500
Date: Tue, 30 Jan 2001 12:50:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephen Clark <sclark46@gte.net>
cc: Vojtech Pavlik <vojtech@suse.cz>, Tobias Ringstrom <tori@tellus.mine.nu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] No VIA IDE DMA unless configured
In-Reply-To: <3A7720C3.FFE5C981@gte.net>
Message-ID: <Pine.LNX.4.10.10101301250200.3259-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Stephen Clark wrote:

> Guys,
> 
> from .config on 2.4.1
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> 
> Shouldn' t the value be CONFIG_IDEDMA_PCI_AUTO instead of CONFIG_IDEDMA_AUTO
> in the code below?

No 'CONFIG_IDEDMA_AUTO' is a global config option across all platforms.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
