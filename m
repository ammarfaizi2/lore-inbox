Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVL2Dfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVL2Dfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVL2Dfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:35:38 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:58085 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964997AbVL2Dfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:35:37 -0500
Message-ID: <43B35986.90408@bigpond.net.au>
Date: Thu, 29 Dec 2005 14:35:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<43B1D551.5050503@bigpond.net.au> <20051228112058.2c0c1137@localhost> <43B29540.1030904@bigpond.net.au> <43B3545D.3010508@yahoo.com.au>
In-Reply-To: <43B3545D.3010508@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 29 Dec 2005 03:35:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Paolo Ornati wrote:
> 
> 
>>>     1) nicksched: perfect! This is the behaviour I want.
>>>
> ...
> 
>>>
>>> transcode get recognized for what it is, and I/O bounded processes
>>> don't even notice that it is running :)
>>
>>
>>
>> Interesting.  This one's more or less a dead scheduler and hasn't had 
>> any development work done on it for some time.  I just keep porting 
>> the original version to new kernels.
>>
> 
> It isn't a dead scheduler any more than any of the other out of tree
> schedulers are (which isn't saying much, unfortunately).

Ingosched, staircase and my SPA schedulers are all evolving slowly.
  Are there any out there that I don't have in PlugSched that you think 
should be?

> 
> I've probably got a small number of cleanups and microoptimisations
> relative to what you have (I can't remember exactly what you sucked up)
> ... but other than that there hasn't been much development work done for
> some time because there is not much wrong with it.
> 

I was starting to think that you'd lost interest in this which is why I 
said it was more or less dead.  Sorry.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
