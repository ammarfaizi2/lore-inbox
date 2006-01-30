Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWA3Nf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWA3Nf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWA3Nf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:35:26 -0500
Received: from smtpout.mac.com ([17.250.248.88]:32740 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932268AbWA3NfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:35:24 -0500
In-Reply-To: <200601301621.24051.a1426z@gawab.com>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601301621.24051.a1426z@gawab.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Mon, 30 Jan 2006 08:35:21 -0500
To: Al Boldi <a1426z@gawab.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 08:21, Al Boldi wrote:
> Bryan Henderson wrote:
>>>> So we know it [single level storage] works, but also that people  
>>>> don't seem to care much for it
>>
>>> People didn't care, because the AS/400 was based on a proprietary  
>>> solution.
>>
>> I don't know what a "proprietary solution" is, but what we had was  
>> a complete demonstration of the value of single level storage, in  
>> commercial use and everything,  and other computer makers (and  
>> other business units of IBM) stuck with their memory/disk split  
>> personality.  For 25 years, lots of computer makers developed lots  
>> of new computer architectures and they all (practically speaking)  
>> had the memory/disk split.  There has to be a lesson in that.
>
> Sure there is lesson here.  People have a tendency to resist  
> change, even though they know the current way is faulty.

Is it necessarily faulty?  It seems to me that the current way works  
pretty well so far, and unless you can prove a really strong point  
the other way, there's no point in changing.  You have to remember  
that change introduces bugs which then have to be located and removed  
again, so change is not necessarily cheap.

>>> With todays generically mass-produced 64bit archs, what's not to  
>>> care about a cost-effective system that provides direct mapped  
>>> access into  linear address space?
>>
>> I don't know; I'm sure it's complicated.
>
> Why would you think that the shortest path between two points is  
> complicated, when you have the ability to fly?

Bad analogy.  This is totally irrelevant to the rest of the discussion.

>> But unless the stumbling block since 1980 has been that it was too  
>> hard to get/make a CPU with a 64 bit address space, I don't see  
>> what's different today.
>
> You are hitting the nail right on it's head here. Nothing moves the  
> masses like mass-production.

Uhh, no, you misread his argument: If there were other reasons that  
this was not done in the past than lack of 64-bit CPUS, then this is  
probably still not practical/feasible/desirable.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


