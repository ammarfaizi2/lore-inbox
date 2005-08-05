Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVHEEIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVHEEIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 00:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVHEEIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 00:08:06 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:49004 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262850AbVHEEH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 00:07:56 -0400
Message-ID: <42F2E61B.2000502@m1k.net>
Date: Fri, 05 Aug 2005 00:07:55 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       frank.peters@comcast.net, vojtech@suse.cz
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
References: <20050624113404.198d254c.frank.peters@comcast.net>	<20050804162812.29a3f2b2.akpm@osdl.org>	<20050804230947.36c24139.frank.peters@comcast.net>	<200508042220.27480.dtor_core@ameritech.net> <20050804205441.0a90f637.akpm@osdl.org>
In-Reply-To: <20050804205441.0a90f637.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>  
>
>>On Thursday 04 August 2005 22:09, Frank Peters wrote:
>>    
>>
>>>I'll use bugzilla to report any problems with 2.6.13-rc6.
>>>
>>>But since I've included the "usb-handoff" option at boot time,
>>>all my problems (except the long dhcp/eth0 connect time) are
>>>now gone.  Right now I'm using 2.6.13-rc5.
>>>
>>>I understand the need to pinpoint the kernel version, but the
>>>"usb-handoff" option has even corrected some problems that
>>>started in linux-2.4.x.  For example, my PS/2 mouse now functions
>>>normally.  It has not worked with this motherboard since some time
>>>in the 2.4.x series.  Also, my keyboard lights were malfunctioning
>>>under X-Window since early 2.6.x, but with the "usb-handoff" option
>>>they are working normally now.
>>>
>>>If I had known about the "usb-handoff" option earlier, this thread 
>>>probalby would not even have come into existence.  As long as "usb-handoff"
>>>keeps working, I would consider the issue closed.
>>>
>>We really really need to make usb-handoff default. Even if there known boxes
>>that don't like it the blacklist would be rather short, much shorter than
>>a whitelist.
>>    
>>
>Sounds like a fun thing for post-2.6.13.
>
>What does usb-handoff do, precisely?
>
I just did a series tests.  This is necessary, because the problem was 
intermittent for me.  usb-handoff fixes all of my problems!!!

without using usb-handoff, my ps/2 mouse works 1/10 times
using usb-handoff, my ps/2 mouse works 10/10 times

I consider the problem solved... If Dmitry wants to make usb-handoff the 
default, he has my support :-).

-- 
Michael Krufky

