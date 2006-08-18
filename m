Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWHRNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWHRNtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWHRNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:49:53 -0400
Received: from main.gmane.org ([80.91.229.2]:40138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030374AbWHRNtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:49:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Page cache using B-trees benchmark results
Date: Fri, 18 Aug 2006 09:52:59 -0400
Message-ID: <44E5C63B.4080000@tmr.com>
References: <4745278c0608171843j5b3d28bbx16ddf472e1bdb329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Andrea Arcangeli <andrea@suse.de>
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
In-Reply-To: <4745278c0608171843j5b3d28bbx16ddf472e1bdb329@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Patil wrote:
> Folks
> 
> I am attaching the benchmark results for Page Cache Implementation
> using B-trees. I basically ran the tio (threaded i/o) benchmark
> against my kernel (with the B-tree implementation) and the Linux
> kernel shipped with FC5. Radix tree implementation is definately
> better however the B-tree implementation did not suck that bad :)
> 
> Also I attaching a new patch which was used for measuring the
> benchmarks. Also henceforth changes to the page will be tracked using
> the projected hosted at http://code.google.com/p/btreepc
> 
Thanks for this. I guess a purist would say that you need to run against 
the base kernel and base kernel plus your patches, but these numbers are 
certainly enough to support your conclusion.

What's next?

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

