Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753731AbWKFXxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbWKFXxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbWKFXxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:53:39 -0500
Received: from 8.ctyme.com ([69.50.231.8]:19137 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1753731AbWKFXxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:53:39 -0500
Message-ID: <454FCB02.2060907@perkel.com>
Date: Mon, 06 Nov 2006 15:53:38 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Chris Lalancette <clalance@redhat.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: could not find filesystem /dev/root
References: <454E95E1.2010708@perkel.com> <200611062112.42202.rjw@sisk.pl> <454FA6AD.7000301@perkel.com> <200611062225.56070.rjw@sisk.pl> <454FA988.7040204@perkel.com> <454FC945.90903@redhat.com>
In-Reply-To: <454FC945.90903@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Lalancette wrote:
> Marc Perkel wrote:
>   
>> Rafael J. Wysocki wrote:
>>
>>     
>>> On Monday, 6 November 2006 22:18, Marc Perkel wrote:
>>>  
>>>
>>>       
>>>> Rafael J. Wysocki wrote:
>>>>    
>>>>
>>>>         
>>>>> On Monday, 6 November 2006 02:54, Marc Perkel wrote:
>>>>>        
>>>>>
>>>>>           
>>>>>> Trying to compile a new kernel and getting this on boot
>>>>>>
>>>>>> could not find filesystem /dev/root
>>>>>>             
>>>>>>             
>>>>> Which kernel?
>>>>>         
>>>>>           
>>>> 2.6.19rc4
>>>>     
>>>>         
>>> What is the last working version?
>>>   
>>>       
>> Last one I tried that worked other than the stock kernel is 2.6.18 but
>> I've upgraded from FC5 to FC6 since then.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>     
>
> I ran into the same problem when using an FC-6 .config file compiling 2.6.19-rc4.  In my case, the problem was that the configuration options for Serial ATA have changed since 2.6.18 (which the FC-6 config is based on).  I had to manually go in to the config (with make menuconfig) and turn on the SATA device that I have.  What kind of SATA controller do you have, and what does your .config look like?
>
> Chris Lalancette
>   

I'm looking at it now. that is very likely it. I'm using nv_sata

