Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267481AbUHEElK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267481AbUHEElK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHEElK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:41:10 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:45951 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267481AbUHEEk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:40:59 -0400
Message-ID: <4111B460.5040408@yahoo.com.au>
Date: Thu, 05 Aug 2004 14:15:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au> <411196EE.9050408@bigpond.net.au> <41119A3B.2020202@yahoo.com.au> <4111A39C.40200@bigpond.net.au> <4111A418.5030101@yahoo.com.au> <4111AB49.5010003@bigpond.net.au>
In-Reply-To: <4111AB49.5010003@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:
> 
>> Peter Williams wrote:
>>
>>> Nick Piggin wrote:
>>>
>>>> However if you add or remove scheduling policies, your
>>>> p->policy method breaks.
>>>
>>>
>>>
>>>
>>> Not if Albert's numbering system is used.
>>>
>>
>> What if another realtime policy is added? Or one is removed?
> 
> 
> What if the "prio" field is removed?
> 

Dunno; the scheduler stops working?
