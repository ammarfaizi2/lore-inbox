Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTI1NJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTI1NIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:08:23 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:13471 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S262556AbTI1NFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:05:25 -0400
Message-ID: <3F76DCEC.60508@softhome.net>
Date: Sun, 28 Sep 2003 15:06:52 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch>
In-Reply-To: <20030927202148.GA31080@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Sat, 27 Sep 2003 21:59:55 +0200, Ihar 'Philips' Filipau wrote:
> 
>>  Better than with swap. This is production workstation - I cannot test 
>>something on it :-(
> 
> 
> I don't think there's much risk involved in running 2.[56]. If it doesn't
> boot, you can go back to 2.4. If it does boot, it won't eat your data.
> YMMV, of course.
> 

   Data corruption? My back-up of work?
   I cannot back-up my data since my comp by itself is backup :-)

> 
>>   <rant>'Paging like crazy' became for me a synonym of Linux. It 
>>doesn't matter how much memory you have. Less == worse. Developers 
> 
> 
> Oh, it does matter. My workstation has 1 GB RAM and 2 GB swap and I hardly
> see any problems with paging <g>.
> 

   Because your workload doesn't hit the 1GB limit.
   Actually we just do not have fast enough I/O + CPU to utilize 1GB of 
RAM efficiently.

   But if you will go into 128MB of RAM - you will see difference, where 
should be no difference.

   Let's say (my personal exp.) cp'ing of kernel source with 0.5/0.25 GB 
RAM dosn't differ. Aproximately the same time. 0.25GB little bit faster 
- but it can be written off to noise. But try to do the same cp with 
0.125GB - this cp (as of RH 2.4.20-20.9 +ext3 -swap) takes _*two*_ times 
longer. Should it be?

> 
>>stopped testing VMM regression on low-memory computers long time ago. 
> 
> Many of the best Linux devs these days work for companies and organizations
> that are in the business of selling or using big iron. They have people on

   Indeed.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

