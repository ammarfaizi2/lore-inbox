Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUI1TV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUI1TV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUI1TV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:21:26 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37095 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267705AbUI1TVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:21:23 -0400
Subject: Re: IRQ blocking when reading audio CDs
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: gundolfk@web.de, Christoph Bartelmus <lirc@bartelmus.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927055234.GA2288@suse.de>
References: <20040926120849.GG3134@lilienthal>
	 <20040927055234.GA2288@suse.de>
Content-Type: text/plain
Message-Id: <1096399282.2852.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 15:21:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 01:52, Jens Axboe wrote:
> On Sun, Sep 26 2004, Gundolf Kiefer wrote:
> > Dear Jens (& Christoph),
> > 
> > on my media PC (a Pentium II 350 MHz running Debian Woody with Kernel 
> > 2.4.25), I have problems using LIRC 0.6.6 with a serial IR reveiver when at 
> > the same time some application (cdparanoia, xmms/Audio CD reader) is 
> > reading audio data from a CD.
>
> Upgrade to 2.6, it can use DMA for cdda extraction. If you cannot for
> some reason, Andrew had an ide-cd hack to enable dma in 2.4 for this.

Seems like it should also work in PIO mode as long as unmask_irq is set.

Lee

