Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWALCXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWALCXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWALCXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:23:15 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:53185 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932483AbWALCXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:23:14 -0500
Message-ID: <43C5BD8F.3000307@bigpond.net.au>
Date: Thu, 12 Jan 2006 13:23:11 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601121218.47744.kernel@kolivas.org> <43C5B0F6.5090500@bigpond.net.au> <200601121236.07522.kernel@kolivas.org>
In-Reply-To: <200601121236.07522.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 12 Jan 2006 02:23:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 12 Jan 2006 12:29 pm, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>This is a shot in the dark. We haven't confirmed 1. there is a problem 2.
>>>that this is the problem nor 3. that this patch will fix the problem.
>>
>>I disagree.  I think that there is a clear mistake in my original patch
>>that this patch fixes.
> 
> 
> I agree with you on that. The real concern is that we were just about to push 
> it upstream. So where does this leave us?  I propose we delay merging the
> "improved smp nice handling" patch into mainline pending your further 
> changes.

I think that they're already in 2.6.15 minus my "move load not tasks" 
modification which I was expecting to go into 2.6.16.  Is that what you 
meant?

If so I think this is a small and obvious fix that shouldn't delay the 
merging of "move load not tasks" into the mainline.  But it's not my call.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
