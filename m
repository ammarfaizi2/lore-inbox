Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUEAU6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUEAU6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEAU6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 16:58:13 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:32957 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262380AbUEAU6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 16:58:11 -0400
In-Reply-To: <17110000.1083444468@[10.10.2.4]>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <6900000.1083388078@[10.10.2.4]> <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> <17110000.1083444468@[10.10.2.4]>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <40B152E3-9BB2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Sat, 1 May 2004 16:58:09 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 1, 2004, at 4:47 PM, Martin J. Bligh wrote:

>>>> All bugs can be debugged or fixed, it's a matter of how hard it is
>>>> to do (generally easier with open-source) and *who* is responsible
>>>> for doing it (i.e. supporting the modules).
>>>
>>> Yes, exactly. The tainted mechanism is there to tell us that it's not
>>> *our* problem to support it. And you deliberately screwed that up,
>>> which is why everybody is pissed at you.
>>
>> It was already screwed up, and causing unnecessary support burdens
>> both on the community ("help! what does tainted mean") and vendors.
>> This thread and previous ones have shown ample evidence of that.
>> Let's deal with the root problem and fix the messages, as Rik van Riel
>> has suggested.
>>
>> Most third-party module suppliers have been confronted with the same 
>> issue
>> and forced to work around it (in other imperfect and sometimes clumsy 
>> ways).
>
> Odd that none of them just submitted a patch to fix the "real problem" 
> then.
> Sorry, I don't believe that was your only intent.

So what do you think it was? I swear to god, there was no other intent 
nor purpose.

We have just submitted a patch to address the issue. Hopefully it (or 
something
similar) will make it in and the matter will become history.

Marc

--
Marc Boucher
Linuxant inc.

