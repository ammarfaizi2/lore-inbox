Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUK1X4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUK1X4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUK1X4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:56:25 -0500
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:26501 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261605AbUK1X4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:56:21 -0500
Date: Mon, 29 Nov 2004 00:55:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041128235530.GB2856@elf.ucw.cz>
References: <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams> <20041126123847.GD1028@elf.ucw.cz> <1101680972.4343.300.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101680972.4343.300.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My machine suspends in 7 seconds, and that's swsusp1. According to
> > your numbers, suspend2 should suspend it in 1 second and LZE
> > compressed should be .5 second.
> 
> Seven seconds? How much memory is in use when you start, and how much is
> actually written to disk? If you're starting with 1GB of RAM in use,
> I'll sit up and listen, but I suspect you're talking about something
> closer to 20MB and init S :>

It was on .5GB machine, with X running, IIRC. Specify how should I
load the system and I'll try it here. swsusp1 got some speedups with
O(n^2) killing (not yet merged).

> These discussions are getting really unreasonable. "I don't want that
> feature, therefore it shouldn't be merged" isn't a valid argument.
> Neither is "Well, I can suspend in seven seconds with hardly any memory
> in use." If you just don't want suspend2 in the kernel, come out and say
> it. 

Ok, "I do not want suspend2 in kernel". Not what you'd call suspend2,
anyway. I thought that stripping down suspend2 then merging it is
reasonable way to go, but now it seems to me that enhancing swsusp1 is
easier way to go. At least I'll be able to do it incrementally.

I'm sorry about all the confusion, and you can still get that jpeg for
"put pavel into doom3".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
