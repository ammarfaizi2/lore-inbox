Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVGNO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVGNO2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbVGNO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:28:46 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55151 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263035AbVGNO2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:28:44 -0400
Date: Thu, 14 Jul 2005 08:28:21 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Thread_Id
In-reply-to: <42D6462B.8030706@prodmail.net>
To: rvk@prodmail.net
Cc: Ian Campbell <ijc@hellion.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42D67685.1040401@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
 <42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net>
 <1121327103.3967.14.camel@laptopd505.fenrus.org>
 <42D63916.7000007@prodmail.net> <1121337567.18265.26.camel@icampbell-debian>
 <42D6462B.8030706@prodmail.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RVK wrote:
> Ian Campbell wrote:
> 
>> On Thu, 2005-07-14 at 15:36 +0530, RVK wrote:
>>
>>  
>>
>>> bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;
>>>   
>>
>>
>> That's an implementation detail which you cannot determine any
>> information from.
>>
>> What Arjan is saying is that pthread_t is a cookie -- this means that
>> you cannot interpret it in any way, it is just a "thing" which you can
>> pass back to the API, that pthread_t happens to be typedef'd to unsigned
>> long int is irrelevant.
>>
>>  
>>
> Do you want to say for both 2.6.x and 2.4.x I should interpret that way ?
> 
> rvk

Indeed, for ANY OS using pthreads it should be interpreted that way..
