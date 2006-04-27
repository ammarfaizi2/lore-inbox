Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWD0QDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWD0QDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWD0QDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:03:23 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:5393 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S965142AbWD0QDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:03:22 -0400
Message-ID: <4450EB43.1080505@argo.co.il>
Date: Thu, 27 Apr 2006 19:03:15 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il> <200604271756.30679.vda@ilport.com.ua>
In-Reply-To: <200604271756.30679.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 16:03:18.0784 (UTC) FILETIME=[1996C800:01C66A14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 27 April 2006 17:27, Avi Kivity wrote:
>   
>>> Where do you see goto-heavy code in kernel?
>>>
>>>   
>>>       
>> [avi@cleopatra linux]$ grep -rw goto . | wc -l
>> 37448
>>
>> Repeat without 'wc' to get a detailed listing.
>>     
>
> In 1999 Dave 'Barc0de' Jones, Paranoid wierdo noize making geek,
> wrote this:
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/9901.2/0939.html
>
> I failed to find a link, but in 2004 Dave Jones, a well-known
> kernel hacker, wrote something like "Wow, it's fun to read
> my own old mail, how naive I was back then :)"
>   

:)

I'll refer you to the 4-line vs 14-line examples. To the C++ trained 
mind, the 4 line segment is much clearer.

> Feel free to get your hards dirty with kernel development,
> and maybe you will say something similar a few years from now.
>   

I have some experience with kernel code (mucking about the asynchronous 
I/O implementation) and a lot of experience in C++ system code (both 
ring 0 and userspace). What I've written in this thread is a result of 
20+ (can't believe I'm writing that number) years of coding, not 
theoretical studies (I've studied aeronautical engineering but practiced 
it very little; if I talk about that maybe you can use the theory vs 
practice argument).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

