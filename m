Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUFHFvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUFHFvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUFHFvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:51:49 -0400
Received: from web51805.mail.yahoo.com ([206.190.38.236]:1467 "HELO
	web51805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264826AbUFHFvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:51:47 -0400
Message-ID: <20040608055147.22680.qmail@web51805.mail.yahoo.com>
Date: Mon, 7 Jun 2004 22:51:47 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Cc: Phy Prabab <phyprabab@yahoo.com>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, wli@holomorphy.com
In-Reply-To: <40C52CFF.4080207@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the results I published also included 2.4.23 runs
which do not have the stair step scheduler.

Also, I have run this on 2.6-1->2.6.7-rc<x>, all the
2.6.x series are slower than the 2.4 series.

Thank you for your time.
Phy

--- Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Andrew Morton wrote:
> 
> > At a guess I'd say either a) you're hitting some
> path in the kernel which
> > is going for a giant and bogus romp through
> memory, trashing CPU caches or
> > b) your workload really dislikes
> run-child-first-after-fork or c) the page
> > allocator is serving up pages which your access
> pattern dislikes or d)
> > something else.
> > 
> 
> e) it's the staircase scheduler patch?


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
