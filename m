Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270155AbRH1CQp>; Mon, 27 Aug 2001 22:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRH1CQf>; Mon, 27 Aug 2001 22:16:35 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:32231
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S270155AbRH1CQY>; Mon, 27 Aug 2001 22:16:24 -0400
Date: Tue, 28 Aug 2001 14:16:34 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crashing with Abit KT7, 2.2.19+ide patches
Message-ID: <20010828141633.C14714@cone.kiwa.co.nz>
In-Reply-To: <20010827200106.A26175@cone.kiwa.co.nz> <3B8AD463.C196B9B6@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8AD463.C196B9B6@bigfoot.com>; from timothymoore@bigfoot.com on Mon, Aug 27, 2001 at 04:14:43PM -0700
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I managed to catch one of these crash the system messages:

Aug 28 14:07:51 hoppa kernel: hda: timeout waiting for DMA
Aug 28 14:07:51 hoppa kernel: hda: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x20
Aug 28 14:07:51 hoppa kernel: hda: DMA disabled
Aug 28 14:07:51 hoppa kernel: hda: irq timeout: status=0x80 { Busy }
Aug 28 14:07:51 hoppa kernel: hda: DMA disabled
Aug 28 14:07:51 hoppa kernel: hda: ide_set_handler: handler not null; old=c018f67c, new=c018f67c
Aug 28 14:07:51 hoppa kernel: bug: kernel timer added twice at c018f526.
Aug 28 14:07:53 hoppa kernel: ide0: reset: success


Note the second the last line: "bug: kernel timer added twice at
c018f526"


This occured 4 mintues after a system reboot and some rsync activity. 
It occured this time when I was in the shell doing a cd [tab].

Other times the HDD might have just crashed again.


Note: this box is also acting as a router between three interfaces at
the same time with IPSec on one of these interfaces.   


Is this likely to make the situation worse?


Nicholas
