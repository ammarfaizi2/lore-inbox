Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUCCXgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUCCXgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:36:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:28381 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261257AbUCCXgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:36:43 -0500
Date: Wed, 3 Mar 2004 15:38:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: 2.6.3-mm4 / 2.5 Gb memory / sym53c8xx_2 won't boot
Message-Id: <20040303153830.7ae00ba3.akpm@osdl.org>
In-Reply-To: <20040303191514.GA6998@middle.of.nowhere>
References: <20040302185518.GA2886@middle.of.nowhere>
	<20040302144757.60a0630c.akpm@osdl.org>
	<20040303191514.GA6998@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> > Could you test Linus's current tree?  The first link at
> > http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.
> > 
> > If this bug hasn't hit Linus's tree yet, it will soon do so...
> > 
> It probably will, since it's not in Linus's tree as of
> 
> cset-20040303_0509.txt
> 
> ie 2.6.4-rc1-mm1 + cset-20040303_0509 does boot with

     You meant 2.6.4-rc1, I assume?

> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1, and 2.6.3-mm4 doesn't.

I continue to be stumped.  Could you please test a Linus tree, plus

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/broken-out/bk-scsi.patch

and

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/broken-out/dma_sync_for_device-cpu.patch

?
