Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271852AbRH1Q4o>; Tue, 28 Aug 2001 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRH1Q4f>; Tue, 28 Aug 2001 12:56:35 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:34548 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S271821AbRH1Q41>; Tue, 28 Aug 2001 12:56:27 -0400
Message-ID: <3B8BCD46.27D01C99@bigfoot.com>
Date: Tue, 28 Aug 2001 09:56:38 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Lee <nj.lee@plumtree.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crashing with Abit KT7, 2.2.19+ide patches
In-Reply-To: <20010827200106.A26175@cone.kiwa.co.nz> <3B8AD463.C196B9B6@bigfoot.com> <20010828141633.C14714@cone.kiwa.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Lee wrote:
> 
> I managed to catch one of these crash the system messages:
> 
> Aug 28 14:07:51 hoppa kernel: hda: timeout waiting for DMA
> Aug 28 14:07:51 hoppa kernel: hda: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x20
> Aug 28 14:07:51 hoppa kernel: hda: DMA disabled
> Aug 28 14:07:51 hoppa kernel: hda: irq timeout: status=0x80 { Busy }
> Aug 28 14:07:51 hoppa kernel: hda: DMA disabled
> Aug 28 14:07:51 hoppa kernel: hda: ide_set_handler: handler not null; old=c018f67c, new=c018f67c
> Aug 28 14:07:51 hoppa kernel: bug: kernel timer added twice at c018f526.
> Aug 28 14:07:53 hoppa kernel: ide0: reset: success

It might be a side effect.  Never try to resolve more than one issue at
a time.

Remove all non-critical PCI cards and drives except the system disk,
then play with swapping IDE cables and generating disk I/O till no more
timeouts.
--
