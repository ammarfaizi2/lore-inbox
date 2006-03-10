Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWCJWGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWCJWGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWCJWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:06:55 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:37007 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S1751283AbWCJWGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:06:54 -0500
Message-ID: <4411F87B.2070902@mnsu.edu>
Date: Fri, 10 Mar 2006 16:06:51 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org> <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr> <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
In-Reply-To: <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Måns Rullgård wrote:

>Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>
>  
>
>>>Subject: can I bring Linux down by running "renice -20
>>>cpu_intensive_process"?
>>>
>>>      
>>>
>>Depends on what the cpu_intensive_process does. If it tries to allocate 
>>lots of memory, maybe. If it's _just_ CPU (as in `perl -e '1 while 1'`), 
>>you get a chance that you can input some commands on a terminal to kill it.
>>SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.
>>    
>>
>
>Sysrq+n changes all realtime tasks to normal priority.
>
>  
>

Patient: "Doctor When I poke myself in the eye it hurts."
Doctor "Don't do that then."

-- 
Jeffrey Hundstad

