Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSLMPNC>; Fri, 13 Dec 2002 10:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSLMPNC>; Fri, 13 Dec 2002 10:13:02 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:3968 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S264743AbSLMPNB>;
	Fri, 13 Dec 2002 10:13:01 -0500
Message-ID: <3DF9FAB1.5070504@walrond.org>
Date: Fri, 13 Dec 2002 15:20:17 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <3DF9F780.1070300@walrond.org> <200212131611.04355.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marc

5 is very low isn't it? Certainly marginal for an application I have in 
mind.

What's the reasoning behind it being a) 5 and b) so low?

Marc-Christian Petersen wrote:
> On Friday 13 December 2002 16:06, Andrew Walrond wrote:
> 
> Hi Andrew,
> 
> 
>>Is the number of allowed levels of symlink indirection (if that is the
>>right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
>>kernel, or libc ? Where is it defined, and can it be changed?
> 
> 
> fs/namei.c
> 
>  if (current->link_count >= 5)
> 
> change to a higher value.
> 
> So, the answer is: Kernel :)
> 
> ciao, Marc
> 


