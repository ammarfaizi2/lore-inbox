Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWBNNBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWBNNBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWBNNBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:01:16 -0500
Received: from main.gmane.org ([80.91.229.2]:18570 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161030AbWBNNBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:01:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "news.gmane.org" <kubisuro@att.net>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
Date: Tue, 14 Feb 2006 21:45:45 +0900
Message-ID: <43F1D0F9.1040502@att.net>
References: <200602120141.46084.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: ck@vds.kolivas.org
X-Gmane-NNTP-Posting-Host: 210.120.111.10
User-Agent: Thunderbird 1.5 (X11/20051201)
In-Reply-To: <200602120141.46084.kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Con Kolivas wrote:
> Everything is working nicely now, surviving a serious thrashing.
> Overall the behaviour I would say has improved as a result of all the
> modifications.
> 
> Many thanks go to Nick and Andrew for suggestions.
> 
> Andrew please consider this version for -mm.
> 
> Cheers,
> Con

I'm what one would call a typical desktop user.  I also very much a 
layman with kernels.  The layman is very interested in believing, if not 
knowing, that the kernel is doing everything within its power to provide 
application responsiveness, especially during heavy application loads.

Swap Prefetch has quantifiable and visible results when an application 
is swapped out and then swapped back in after a idle period (a very 
logical time to do things).  That /is/ an obvious interaction benefit.

I play World of Warcraft daily and it forces many applications into 
swap.  That said, I now regularly experience desktop conditions that are 
_very_ favorable with the Swap Prefetch patch soon as WoW is cleared out 
and resources are regained for productive desktop use (browser, email, 
chat, media, etc).  Hard disk activity, after an idle period, almost 
never get in the way of interactivity (likely due to swapping out) -- 
because they're back in physical memory.  That is _very_ good use of 
time and resources.

I'm very interested in seeing this patch applied to MM for major 
testing, so that others with typical desktop demands can get an idea of 
how this patch is beneficial.

Thanks for your attention,

Best of regards,
Ryan M.


