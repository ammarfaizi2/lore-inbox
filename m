Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263513AbUKZTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUKZTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbUKZTuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:50:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262372AbUKZT0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:18 -0500
Date: Fri, 26 Nov 2004 14:37:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: hugang@soulinfo.com, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126133701.GC1687@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <20041126043203.GA2713@hugang.soulinfo.com> <1101456577.4343.121.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101456577.4343.121.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't see the point to saving LRU pages separately when you're still
> eating all the memory you can. You'll have the same number of pages to
> save, just fewer to copy (and copying takes far less time than saving).
> 
> > Pagecaches still in, but disable by default, active using sysctl, 
> > I'd like not merge it right now, Hope other chagnes can merge into. :)
> 
> Pavel's going to think you are trying to turn swsusp into suspend2!!

Pavel knows that already, but at least hugang is producing small
patches ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
