Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVLWBHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVLWBHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLWBHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:07:42 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:34498 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751201AbVLWBHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:07:42 -0500
Message-ID: <43AB4DDC.90505@m1k.net>
Date: Thu, 22 Dec 2005 20:07:40 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "P. Christeas" <p_christ@hol.gr>
CC: Mauro Chehab <mchehab@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <1135291436.14685.7.camel@localhost> <43AB2EDF.6030207@linuxtv.org> <200512230121.48882.p_christ@hol.gr>
In-Reply-To: <200512230121.48882.p_christ@hol.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P. Christeas wrote:

>On Friday 23 December 2005 12:55 am, you wrote:
>  
>
>>>Christeas,
>>>
>>>	Between 2,6,13 and 2.6.14-rc1 we had about 220 v4l patches. It would
>>>help more if you get v4l CVS tree and try to identify the broken patch.
>>>there weren't so many patches for cx2388x. I suspect it might be some
>>>changes at tda9887, cx88-cards or cx88-tvaudio (the latest is the more
>>>likely).
>>>      
>>>
>>Actually, a -git bisection test is even easier, less work involved, and
>>will point you to the exact patch that caused the regression.
>>
>>http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bis
>>ect.txt
>>
>>Cheers,
>>Michael Krufky
>>
>>    
>>
>I just discovered 'bisect', too, and are using it.
>
>Andrew, it would be nice to have a 'limited' bisect when whe know which 
>subsystem we are narrowing to:
>git bisect start drivers/media/video/cx88/
>Theoretically speaking, I shouldn't even rebuild but the module alone..
>  
>
No, you're incorrect.  In many cases, modules from a given subsystem can 
break due to a change elsewhere in the kernel.

Did you drop the list cc's on purpose? (re-added)

Regards,

Mike Krufky
