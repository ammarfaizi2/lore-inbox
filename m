Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGIESz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGIESz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUGIESy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:18:54 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:37312 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263818AbUGIESx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:18:53 -0400
References: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com> <40EDD980.4040608@bigpond.net.au> <40EDF8F5.2060808@yahoo.com.au> <20040708185726.1c375176.akpm@osdl.org>
Message-ID: <cone.1089346699.970398.12519.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, pwil3058@bigpond.net.au,
       Alexander.Povolotsky@marconi.com, linux-kernel@vger.kernel.org,
       efault@gmx.de, rml@tech9.net, mingo@elte.hu, elladan@eskimo.com,
       cks@utcc.utoronto.ca
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum ) que
         stio n
Date: Fri, 09 Jul 2004 14:18:19 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>> However well tested your scheduler might be, it needs several
>>  orders of magnitude more testing ;) Maybe the best we can hope
>>  for is compile time selectable alternatives.
> 
> At this stage in the kernel lifecycle, for something as fiddly as the CPU
> scheduler we really should be 100% driven by problem reporting.
> 
> If someone can identify a particular misbehaviour in the CPU scheduler then
> they should put their editor away and work to produce a solid testcase. 
> Armed with that, we can then identify the source of the particular problem.
> 
> It is at this point, and no earlier, that we can decide what an appropriate
> solution is.  We then balance the risk of that solution against the severity
> of the problem which it solves and make a decision as to whether to proceed.
> 
> Right now, the ratio of quality bug reporting to scheduler patching is
> bizarrely small.

Is "for fun" not reason enough?

I'm still keeping an eye out for firm "behavioural" bug reports on 2.6 and 
would discuss or address them.

Seriously the only reason I went down the rewrite path was to address 
complaints about the complexity of the current design. It was also an 
opportunity to start implementing some requested features. I certainly have 
never suggested it should even be considered for 2.6.

Con

