Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWE2Dlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWE2Dlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWE2Dlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:41:51 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:12504 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751151AbWE2Dlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:41:50 -0400
Message-ID: <447A6D7B.9090302@bigpond.net.au>
Date: Mon, 29 May 2006 13:41:47 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net>
In-Reply-To: <447A65EA.9020705@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 29 May 2006 03:41:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Peter Williams wrote:
> 
>>> This is correct.  Basically I read the LARTC.org (which explains Linux
>>> network schedulers etc) and the description of the Token Bucket
>>> Scheduler inspired me to write the same thing for CPU resources.  It was
>>> originally developed for the 2.4 Alan Cox series kernels.  The primary
>>> [...]
>>> I most recently described this at http://lkml.org/lkml/2006/3/29/59, a
>>> lot of that thread is probably worth catching up on.
>>> [...]
>>>    
>>>
>> Have you considered adding an implementation of these schedulers to 
>> PlugSched?
>>  
>>
> 
> No, I haven't; I'd be happy to do so, given appropriate pointers to a
> codebase I can produce commits for.  Is there a public git tree for the
> patches, or a series of split out patches?

Yes, but not yet publicly available.  I use quilt to keep the patch 
series up to date and do the change as a relatively large series (30 or 
so) to make it easier for me to cope with changes in the kernel.  When I 
do the next release I'll make a tar ball of the patch series available.

Of course, if your eager to start right away I could make the 
2.6.17-rc4-mm1 one available?

>  I see only combined patches
> on the SourceForge site.

Yes, I'm trying to be not too greedy in my disk space use :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
