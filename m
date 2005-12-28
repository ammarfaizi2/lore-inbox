Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVL1HrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVL1HrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVL1HrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:47:11 -0500
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:31865 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932495AbVL1HrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:47:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CnyhN2WsLQ8g63hXZQCa6L6/sMjDSpE1vISTKhMcB8cDHG5L9iQiwVcfibbsG1ru6MNwbMR2nohL4zjYi5lg91+0+sgOdlwiehJ8Ujk52zyErWJ8O7NiZt8uGiUs1UC0csAY7UFdhXJOJk2WNE3MKhn000mmCfUrmA2FoCHtcmg=  ;
Message-ID: <43B242F4.3050004@yahoo.com.au>
Date: Wed, 28 Dec 2005 18:47:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
References: <43B22FBA.5040008@bigpond.net.au> <200512281735.00992.kernel@kolivas.org>
In-Reply-To: <200512281735.00992.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 28 Dec 2005 05:24 pm, Peter Williams wrote:
> 
>>This patch implements a prototype version of a simplified interactive
>>bonus mechanism.  The mechanism does not attempt to identify interactive
> 
> 
>>---
>>
>>Your comments on this proposal are requested.
>>
>>---
> 
> 
> If we're going to redo the interactivity estimator I happen to have a whole 
> cpu scheduler design that is interactive by design without being a state 
> machine that I've been hacking / maintining / debugging for 2 years that many 
> people are already using in production...
> 

What do you mean interactive by design (presumably as opposed
to the current scheduler which is not interactive by design)?

And what do you mean by not being a state machine?

Back on topic: I don't think that this patch isn't clearly
better than what currently exists, nor would require less
testing than any other large scale changes to the scheduler
behaviour.

So, as Con seems to imply, it is JASW (just another scheduler
rewrite). Not that there's anything wrong with that... except
it is not really a good fix for a problem with the current
scheduler.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
