Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKMWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKMWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKMWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:52:16 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:64915 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750777AbVKMWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:52:15 -0500
Message-ID: <4377C39D.2080602@bigpond.net.au>
Date: Mon, 14 Nov 2005 09:52:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] plugsched - update Kconfig-1
References: <434F01EA.6060709@bigpond.net.au> <200511131637.40704.kernel@kolivas.org> <4377031F.5000902@bigpond.net.au> <200511132030.36777.kernel@kolivas.org>
In-Reply-To: <200511132030.36777.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 13 Nov 2005 22:52:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sun, 13 Nov 2005 20:10, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>On Sun, 13 Nov 2005 16:22, Peter Williams wrote:
>>>
>>>>Con Kolivas wrote:
>>>>
>>>>>On Sun, 13 Nov 2005 12:34, Peter Williams wrote:
>>>>>
>>>>>>1. Make the ability to select which schedulers are built in independent
>>>>>>of EMBEDDED.
>>>>>>2. Only offer builtin schedulers as choice for the default scheduler.
>>>>>>3. Only build in ingosched if PLUGSCHED is not configured.
>>>>>
>>>>>I disagree with 3. Surely people might want to build in only one
>>>>>scheduler that is not ingosched without other choices.
>>>>
>>>>Yes, and they would be able to do that by selecting PLUGSCHED and then
>>>>selecting only the scheduler that they want.  But this then leads to the
>>>>observation that PLUGSCHED is probably makes things unnecessarily
>>>>complex and all that is required is a means to select the schedulers to
>>>>be built in and a choice of default (much like for the IO schedulers)?
>>>
>>>Indeed it may be better to remove the "plugsched" option entirely. Once
>>>patched in it's not like you are building the kernel without the
>>>plugsched infrastructure. Provided each extra scheduler does not increase
>>>the kernel size too much (and a test build with/without all schedulers
>>>should tell you that), it may be best to just have the scheduler choice
>>>in the top menu and only expose the "schedulers to build in" under
>>>embedded.
>>
>>I can't see why this should be restricted to embedded systems?
> 
> 
> It's just convention that size options go in there; it's not really just for 
> embedded systems.

OK.  I guess I'm sometimes guilty of taking things too literally :-(

I'll read up on Kconfig again before I make any changes.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
