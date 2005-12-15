Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVLOXd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVLOXd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVLOXd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:33:57 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:63622 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751203AbVLOXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:33:57 -0500
Message-ID: <43A1E876.6050407@wolfmountaingroup.com>
Date: Thu, 15 Dec 2005 15:04:38 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de>	 <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de>	 <43A1DB18.4030307@wolfmountaingroup.com>	 <1134688488.12086.172.camel@mindpipe>	 <43A1E451.2090703@wolfmountaingroup.com> <1134689197.12086.176.camel@mindpipe>
In-Reply-To: <1134689197.12086.176.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2005-12-15 at 14:46 -0700, Jeff V. Merkey wrote:
>  
>
>>Lee Revell wrote:
>>
>>    
>>
>>>On Thu, 2005-12-15 at 14:07 -0700, Jeff V. Merkey wrote:
>>> 
>>>
>>>      
>>>
>>>>When you are on the phone with an irrate customer at 2:00 am in the 
>>>>morning, and just turning off your broken 4K stack fix
>>>>and getting the customer running matters. 
>>>>   
>>>>
>>>>        
>>>>
>>>Bugzilla link please.  Otherwise STFU.
>>> 
>>>
>>>      
>>>
>>??????
>>
>>Jeff
>>    
>>
>
>You imply that your customer's problem was due to a kernel bug triggered
>by CONFIG_4KSTACKS.  I am asking you to provide a link to the bug report
>or get lost.
>
>Lee
>  
>

You hack on this code base (hack is the right word) -- I sell it, 
service and support it with customers in a dozen countries.  I don't report
company level issues in "bugzilla" or anywhere else public unless they 
apply to kernel code.  calls from several of our apps (which use
larger than 4K kernel space on a stack) from user space crash -- so do 
wireless drivers -- and kdb crashes as well with some bugs with 4K stacks
turned on when you are trying to debug something. 

Hope that addresses your concerns "joe job".

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

