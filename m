Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVAIWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVAIWnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAIWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:43:49 -0500
Received: from gprs215-6.eurotel.cz ([160.218.215.6]:30592 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261914AbVAIWnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:43:37 -0500
Date: Sun, 9 Jan 2005 23:43:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [1/6]
Message-ID: <20050109224325.GE1353@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128165835.GA1214@elf.ucw.cz> <20041129154307.GC4616@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129154307.GC4616@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I can not merge anything before 2.6.10. As you have seen, I have quite
> > a lot of patches in my tree, and I do not want mix them with these...
> > 
> > >  device-tree.diff 
> > >    base from suspend2 with a little changed.
> > 
> > I do not want this one.
> > 
> > >  core.diff
> > >   1: redefine struct pbe for using _no_ continuous as pagedir.
> > 
> > Can I get this one as a separate diff?
> 
> Here is it.

Do you have any updates? It would be nice to separate non-continuous
pagedir from speeding up check_pagedir?

...plus check_pagedir should really use PageNosaveFree flag instead of
allocating there own (big!) bitmaps. It should also make the code
simpler...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
