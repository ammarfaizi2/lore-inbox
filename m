Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbUKZWsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUKZWsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbUKZTuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:50:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262373AbUKZT0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:19 -0500
Date: Fri, 26 Nov 2004 14:25:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126132509.GA1687@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <20041126082109.GA842@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126082109.GA842@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For swsusp2, you need drivers to stop the DMA, NMI not interfering,
> > sync may not happen after you have saved LRU, memory may not be
> > alocated from slab after you have saved LRU. (something else? This
> > needs to be written down somewhere, and all kernel hackers will need
> > to be carefull not to break these rules. Do you see why it wories me?)
> > 
> > swsusp1 is more self-contained. As long as drivers stop the DMA and
> > NMI does nothing wrong, atomic snapshot will indeed be atomic.
> 
> Here is a grabed memory allocate patch from suspend2, useful for shrink memory
> in high memory using system.

Sorry, I do not understand. What problem is this solving?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
