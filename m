Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTKQErx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 23:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTKQErx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 23:47:53 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:33276 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263181AbTKQErv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 23:47:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Date: Sun, 16 Nov 2003 23:47:48 -0500
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, Gawain Lynch <gawain@freda.homelinux.org>,
       prakashpublic@gmx.de, linux-kernel@vger.kernel.org, cat@zip.com.au
References: <20031116192643.GB15439@zip.com.au> <200311162254.23043.gene.heskett@verizon.net> <3FB84C5A.3000705@cyberone.com.au>
In-Reply-To: <3FB84C5A.3000705@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311162347.48739.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.12.17] at Sun, 16 Nov 2003 22:47:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 November 2003 23:19, Nick Piggin wrote:
>
>I think you might have confused Andrew a bit more ;)
>
>To start with, you are talking about IO schedulers, while the thread
>is about CPU interactivity.

I wasn't aware that such performance issues were divorced.  In my 
admitted limited view, a laggy mouse is a laggy mouse, and its due to 
irq latency in achieving the context switch to service the mouses 
data.  To me, its sorta like 2=2. :)

>The problem here looks like something that is caused by something in
> mm3, not in mm2, not linus.patch, and not
> context-switch-accounting-fix.patch.
>
>
>Off topic: it would be good if you could try the as disk scheduler
> in mm3. I recall you had some problems with it earlier, but they
> should be fixed in mm3. Thanks.

Ok Nick.  I'll reboot tomorrow without the elevator argument.  Right 
now, amanda is fixin to be fired off in about 25 minutes and I want 
to see how badly its estimate phase hogs the machine using the cfq 
scheduler.  With the -mm2 as, it was almost psychedelic to watch the 
mouse move.

Also off topic re mouse performance, and I expect this is an X issue, 
but when its been blanked because I'm typing, it takes about a full 
seconds worth of hand waving before it becomes visible again.  This 
is an X issue and I should go away, right?

>
>>We need a test suite for this :)
>
>Subjective reports from our base of beta testers has proven to be
> the best thing.

So beit.  I guess I must be one of those. (-:

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

