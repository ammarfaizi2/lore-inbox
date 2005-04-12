Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVDLQ7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVDLQ7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVDLQ5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:57:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51901 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262494AbVDLQzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:55:45 -0400
Message-ID: <425BFEE5.8080702@austin.ibm.com>
Date: Tue, 12 Apr 2005 12:01:25 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>	<20050411220013.23416d5f.akpm@osdl.org>	<425B61DD.60700@yahoo.com.au> <20050411231941.1b8548bb.akpm@osdl.org>
In-Reply-To: <20050411231941.1b8548bb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>  
>
>>>- The effects of tcq on AS are much less disastrous than I thought they
>>>      
>>>
>> >  were.  Do I have the wrong workload?  Memory fails me.  Or did we fix the
>> >  anticipatory scheduler?
>> >
>> >
>>
>> Yes, we did fix it ;)
>> Quite a long time ago, so maybe you are thinking of something else
>> (I haven't been able to work it out).
>>    
>>
>
>Steve Pratt's ols2004 presentation made AS look pretty bad.  However the
>numbers in the proceedings
>(http://www.finux.org/proceedings/LinuxSymposium2004_V2.pdf) are much less
>stark.
>
>Steve, what's up with that?  The slides which you talked to had some awful
>numbers.  Was it the same set of tests?
>  
>
I highlighted a few cases where AS went really wrong during the 
presentation, like on really large RAID 0 arrays, but in general 
(referring back to slides) AS trailed other schedulers by 5-10% on ext3, 
but had real trouble with XFS, losing by as much as %145 on 5disk raid5 
system for a mix of workloads.  Perhaps this is the piece you remember.


Steve
