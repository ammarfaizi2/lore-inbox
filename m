Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVAFWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVAFWXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVAFWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:23:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:33975 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263126AbVAFWXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:23:11 -0500
Date: Thu, 6 Jan 2005 23:34:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: No swap can be dangerous (was Re: swap on RAID (was Re: swp -
 Re: ext3 journal on software raid))
In-Reply-To: <200501062208.39563.andrew@walrond.org>
Message-ID: <Pine.LNX.4.61.0501062333260.3430@dragon.hygekrogen.localhost>
References: <41DC9420.5030701@h3c.com> <20050106093811.GB99565@caffreys.strugglers.net>
 <41DD798F.8030902@h3c.com> <200501062208.39563.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andrew Walrond wrote:

> On Thursday 06 January 2005 17:46, Mike Hardy wrote:
> >
> > You are correct that I was getting at the zero swap argument - and I
> > agree that it is vastly different from simply not expecting it. It is
> > important to know that there is no inherent need for swap in the kernel
> > though - it is simply used as more "memory" (albeit slower, and with
> > some optimizations to work better with real memory) and if you don't
> > need it, you don't need it.
> >
> 
> If I recollect a recent thread on LKML correctly, your 'no inherent need for 
> swap' might be wrong.
> 
> I think the gist was this: the kernel can sometimes needs to move bits of 
> memory in order to free up dma-able ram, or lowmem. If I recall correctly, 
> the kernel can only do this move via swap, even if there is stacks of free 
> (non-dmaable or highmem) memory.
> 
> I distinctly remember the moral of the thread being "Always mount some swap, 
> if you can"
> 
> This might have changed though, or I might have got it completely wrong. - 
> I've cc'ed LKML incase somebody more knowledgeable can comment...
> 

http://kerneltrap.org/node/view/3202


-- 
Jesper Juhl


