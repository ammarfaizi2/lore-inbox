Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKIODP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKIODP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKIODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:03:15 -0500
Received: from smtp.rdslink.ro ([193.231.236.97]:33258 "EHLO smtp.rdslink.ro")
	by vger.kernel.org with ESMTP id S1750735AbVKIODO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:03:14 -0500
X-Mail-Scanner: Scanned by qSheff 1.0 (http://www.enderunix.org/qsheff/)
Date: Wed, 9 Nov 2005 16:03:06 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: jerome lacoste <jerome.lacoste@gmail.com>
cc: Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
In-Reply-To: <5a2cf1f60511090430y63db5473we40f077070ecb43a@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0511091547080.15950@grinch.ro>
References: <436C7E77.3080601@ed-soft.at>  <20051105122958.7a2cd8c6.khali@linux-fr.org>
  <436CB162.5070100@ed-soft.at>  <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
  <436DEEFC.4020301@ed-soft.at>  <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
  <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
 <5a2cf1f60511090430y63db5473we40f077070ecb43a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, jerome lacoste wrote:

> On 11/9/05, caszonyi@rdslink.ro <caszonyi@rdslink.ro> wrote:
> [...]
>>
>> There are other reasons for using a new kernel. One of them is
>> interactivity. In the days of 2.4 one could achieve decent interactivity
>> for the desktop using preempt and low latency patches. For 2.6
>> interactivity was a real issue (possibly because of the new development
>> model).
>
> I don't get it. You say that with 2.4 + patches you had good
> interactivity and with 2.6 you don't? Why did you switch then?
>

Because i like to test new kernels. On 2.4 I run the vanila kernel and a 
test kernel. When something went wrong on a test kernel was always a 
stable kernel to use.
2.6 looks a lot like 2.5. New features are added very quickly without much 
testing. Of course there is Andrew's -mm tree but this one sometimes 
is too broken.
For me linux looks now like it has one unstable tree (2.6) which is 
something like -ac was in days of 2.4 and  -mm was in the days of 2.4 
-2.5 and -mm which looks like it became very unstable.
This is what i saw ok lkml (maybe my view is distorted).
I'll stop ranting and try both of them because i have some bugs to report.

>>>> And why should dirstribution makers always backport new security fixes ?
>>>
>>> Because they want to ensure maximum stability. That's what users are
>>> (sometimes) paying for.
>>>
>>
>> Maximum stability of what ? If the distribution kernels are based on
>> vanila kernel (i.e. are based on unstable kernel) how stable will they be
>> ?
>
> Maximum stability of the kernel they deliver. When you fix a
> vulnerability, you fix a vulnerability. You don't just happen to add a
> new bunch of features, and a new bunch of bugs. Otherwise you are
> going to piss off your users a lot.
>

That's what's happening on 2.6. Every 2.6.x release is different.
The 2.6.x.y kernels sometimes are almost no different from 2.6.x


--


