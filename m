Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUK3CDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUK3CDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUK3CBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:01:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:62848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261931AbUK3B7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:59:21 -0500
Date: Mon, 29 Nov 2004 17:58:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
Message-Id: <20041129175851.0b7ed213.akpm@osdl.org>
In-Reply-To: <41A84875.2030505@freemail.hu>
References: <41A84875.2030505@freemail.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>
> Hi,
> 
> I get sometimes these kind of errors reading continously from CDs:
> 
> Nov 26 13:38:09 wl-193 kernel: hda: dma_timer_expiry: dma status == 0x24
> Nov 26 13:38:19 wl-193 kernel: hda: DMA interrupt recovery
> Nov 26 13:38:19 wl-193 kernel: hda: lost interrupt
> 
> and
> 
> Nov 26 16:16:50 wl-193 kernel: hdc: DMA interrupt recovery
> Nov 26 16:16:50 wl-193 kernel: hdc: lost interrupt
> 
> This happens when I use Xine playing AVIs from CDs.
> When it happens, it happens frequently, like once in every 5-10 minutes.
> When I play an SVCD then it's less frequent than on data CDs,
> like once in 30 minutes.
> 
> Drive is:
> 
> hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
> 
> I haven't seen these kind of errors on my previous FC1/i386 system with
> 2.6.x kernels, I installed FC3/x86-64 recently. The original and the
> second errata kernel both show this errors.
> 
> I also don't get this error on my harddisk.

Could we see the full boot log please?  (ie: the dmesg output)
