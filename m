Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbTCGIQm>; Fri, 7 Mar 2003 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbTCGIQm>; Fri, 7 Mar 2003 03:16:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31482 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261443AbTCGIQl>;
	Fri, 7 Mar 2003 03:16:41 -0500
Message-ID: <3E6857CC.5040307@mvista.com>
Date: Fri, 07 Mar 2003 00:26:52 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A0
References: <1046996126.16608.509.camel@w-jstultz2.beaverton.ibm.com>	 <3E67F6C6.6090708@mvista.com> <1047001687.16614.522.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1047001687.16614.522.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2003-03-06 at 17:32, george anzinger wrote:
> 
>>IMHO I solved this problem in the high-res timers patch.  I have 
>>posted the core of the conversion stuff as a path (last night at 
>>23:24) with this subject "[PATCH] Functions to do easy scaled math." 
>>It consists of a header file containing a handful of inline asm code 
>>to do the messy stuff (i.e. the stuff C can't do due to standard 
>>restrictions).  I also provided an asm-generic version to fill the gap 
>>on other archs.  Oh, and there is even a text file to explain it all.
> 
> 
> Well... that's absurdly convenient. :)
> 
> I'll start looking at your code immediately. 
> 
If it looks useful, may be we can get it in...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

