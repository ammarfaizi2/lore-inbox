Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVGNKKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVGNKKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVGNKIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:08:32 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:18817
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S262979AbVGNKIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:08:13 -0400
Message-ID: <42D63916.7000007@prodmail.net>
Date: Thu, 14 Jul 2005 15:36:14 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net> <1121327103.3967.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1121327103.3967.14.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-07-14 at 11:03 +0530, RVK wrote:
>  
>
>>Robert Hancock wrote:
>>
>>    
>>
>>>RVK wrote:
>>>
>>>      
>>>
>>>>Can anyone suggest me how to get the threadId using 2.6.x kernels.
>>>>pthread_self() does not work and returns some -ve integer.
>>>>        
>>>>
>>>What do you mean, negative integer? It's not an integer, it's a
>>>pthread_t, you're not even supposed to look at it..
>>>      
>>>
>>What is pthread_t inturn defined to ? pthread_self for 2.4.x thread
>>libraries return +ve number(as u have a objection me calling it as
>>integer :-))
>>    
>>
>
>it doesn't return a number it returns a pointer ;) or a floating point
>number. You don't know :)
>
>what it returns is a *cookie*. A cookie that you can only use to pass
>back to various pthread functions.
>
>  
>
Hahaha......common. Please clarify following....
SYNOPSIS
       #include <pthread.h>

       pthread_t pthread_self(void);

DESCRIPTION
       pthread_self return the thread identifier for the calling thread.

bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;

rvk

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>.
>
>  
>

