Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTIJN7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTIJN7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:59:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43419 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263561AbTIJN7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:59:49 -0400
Message-ID: <3F5F2E28.2030901@austin.ibm.com>
Date: Wed, 10 Sep 2003 08:59:04 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <3F5D023A.5090405@austin.ibm.com>	<20030908155639.2cdc8b56.akpm@osdl.org>	<3F5E4EF5.1030005@austin.ibm.com> <20030909151246.6d42656b.akpm@osdl.org>
In-Reply-To: <20030909151246.6d42656b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch
>>>
>>>      
>>>
>>This patch improves specjjb over test5 and has no real effect on any of 
>>kernbench, volanomark or specsdet.
>>    
>>
>
>Fine, it's a good fix.
>
>  
>
>>>and if you have time, also test5 plus sched-CAN_MIGRATE_TASK-fix.patch plus
>>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-balance-fix-2.6.0-test3-mm3-A0.patch
>>>
>>>      
>>>
>>This patch degrades both specjbb and volanomark, and to a lesser degree 
>>specsdet
>>    
>>
>
>ok.  And just confirming: that was test5 plus
>sched-CAN_MIGRATE_TASK-fix.patch plus
>sched-balance-fix-2.6.0-test3-mm3-A0.patch?
>  
>
No this was test 5 plus sched-CAN_MIGRATE_TASK-fix.patch only.  I seems 
I misread the request.  I am running that job now.

>I didn't expect a regression from sched-balance-fix.
>
>  
>
>>>What I'm afraid of is that those patches will yield improved results over
>>>test5, and that adding
>>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-2.6.0-test2-mm2-A3.patch
>>>
>>>      
>>>
>>I tried adding this patch to stock test5 and it failed to apply 
>>cleanly.  I have not had a chance to look at why.  Did you mean for this 
>>to be applied by itself, or was this supposed to go on top of one of the 
>>other patches?
>>    
>>
>
>Yes, it applies on top of the other two patches.
>
>Thanks for working on this: it's pretty important right now.
>
Ok, this is submitted as well.  Should  have results this afternoon.

Steve



