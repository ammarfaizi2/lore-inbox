Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUIXRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUIXRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIXRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:25:15 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:54931 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S268881AbUIXRYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:24:13 -0400
Date: Fri, 24 Sep 2004 10:24:05 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Esben Nielsen <simlo@phys.au.dk>
cc: "David S. Miller" <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
In-Reply-To: <Pine.OSF.4.05.10409232336180.21511-100000@da410.ifa.au.dk>
Message-ID: <Pine.LNX.4.61.0409241015330.29848@twin.uoregon.edu>
References: <Pine.OSF.4.05.10409232336180.21511-100000@da410.ifa.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Esben Nielsen wrote:

> ArcNet can't compete with ethernet as LAN: It can only run 10 Mbit whereas
> 100 Mbit ethernet can run roughly 50 Mbit in practice.

most 100Mb/s ethernet card/switch combo's will happily push 90+ Mb/s 
bi-directionally between two hosts.

> But ArcNet doesn't degrade in performance when you try to fill it up as
> ethernet does. Thus ArcNet is very good for real-time applications - and
> is used for such in the industry. But that is not an area where people
> usually use Linux.

well maybe your "realtime" application doesn't run on linux.

if you want non-degrading ethernet performance buy a switch, if you want 
bandwidth reservation, buy an l3 switch.

There just isn't anyone using arcnet or arcnet+ anymore, the writing was 
on the wall for thomas conrad more than a decade ago, and my datapoint 
mainframe days are far behind me, and I don't miss them.

> But don't worry, the windoze drivers aren't good either. The official
> driver for the PCMCIA card crashed Windows XP - with no chance of fixing
> them as I have with the Linux one :-)
>
> Esben
>
>
>
>
> On Thu, 23 Sep 2004, David S. Miller wrote:
>
>> On Thu, 23 Sep 2004 22:59:58 +0200 (METDST)
>> Esben Nielsen <simlo@phys.au.dk> wrote:
>>
>>> After I got the arcnet device running labtop computer froze up. I have
>>> turned off preemtion and SMP. It seems to make it more stable but I can't
>>> be conclusive.
>>
>> Based upon the fact that most Arcnet drivers set hw.open() to NULL,
>> and you're the first person to report this, I doubt arcnet is
>> getting any serious use or testing at all these days.  Sorry :-/
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-net" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

