Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTI1RTp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbTI1RTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:19:45 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.102]:43511 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262622AbTI1RTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:19:43 -0400
Message-ID: <3F771893.1020405@softhome.net>
Date: Sun, 28 Sep 2003 19:21:23 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch> <3F76DCEC.60508@softhome.net> <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
>>>Oh, it does matter. My workstation has 1 GB RAM and 2 GB swap and I hardly
>>>see any problems with paging <g>.
>>
>>   Because your workload doesn't hit the 1GB limit.
>>   Actually we just do not have fast enough I/O + CPU to utilize 1GB of
>>RAM efficiently.
>>
>>   But if you will go into 128MB of RAM - you will see difference, where
>>should be no difference.
>>
>>   Let's say (my personal exp.) cp'ing of kernel source with 0.5/0.25 GB
>>RAM dosn't differ. Aproximately the same time. 0.25GB little bit faster
>>- but it can be written off to noise. But try to do the same cp with
>>0.125GB - this cp (as of RH 2.4.20-20.9 +ext3 -swap) takes _*two*_ times
>>longer. Should it be?
> 
> Yes, it should. If you have 0.25GB, it can be copied into cache. If you
> have 0.125GB, it doesn't fit there.
> 

   So you want to say to effectively copy (or whatever) 40GB harddrive I 
have to have 40GB of RAM? Ridiculous.
   Especially if copying is done in 4k lumps. (cp's default buffer)

<sarcasm flavour=sad> Hopefully not everyone shares your opinion. </sarcasm>

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

