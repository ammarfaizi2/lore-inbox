Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVEJQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEJQVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEJQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:21:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:52126 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261697AbVEJQVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:21:09 -0400
Message-ID: <4280DF80.9010409@tmr.com>
Date: Tue, 10 May 2005 12:21:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org, Jim Nance <jlnance@sdf.lonestar.org>,
       Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050507172005.GB26088@redhat.com><20050507172005.GB26088@redhat.com> <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com> <427FC366.1000506@nortel.com>
In-Reply-To: <427FC366.1000506@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Bill Davidsen wrote:
> 
>> Might I suggest that if you like the "we know best just trust us" 
>> approach, there is another OS to use. Making information available to 
>> good applications will improve system performance, or at least allow 
>> better limitation of requests for resources
> 
> 
> What will you do with the information?  The kernel is doing all the 
> resource allocation and scheduling.
> 
>  From a higher-level, the application wants the best performance. 
> Doesn't it make more sense to have an API that lets you query things 
> like: how many cores do I have, how many separate memory interfaces do I 
> have, how many cores handle interrupts, etc.
> 
> Based on that information you tell the system: "I've got 4 processes, 
> please put them all on cores with separate memory connectivity since 
> they're all memory-intensive. Now please put these other two threads on 
> the same cpu since they share memory but serialize each other by design."

Unless you actually have such a feature, saying "let's not make what we 
have useful because we could have something better someday" seems to be 
a needless sacrifice of electrons.
