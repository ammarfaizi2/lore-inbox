Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753179AbWKFXq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbWKFXq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWKFXq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:46:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753179AbWKFXq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:46:57 -0500
Message-ID: <454FC945.90903@redhat.com>
Date: Mon, 06 Nov 2006 18:46:13 -0500
From: Chris Lalancette <clalance@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: could not find filesystem /dev/root
References: <454E95E1.2010708@perkel.com> <200611062112.42202.rjw@sisk.pl> <454FA6AD.7000301@perkel.com> <200611062225.56070.rjw@sisk.pl> <454FA988.7040204@perkel.com>
In-Reply-To: <454FA988.7040204@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> 
> 
> Rafael J. Wysocki wrote:
> 
>> On Monday, 6 November 2006 22:18, Marc Perkel wrote:
>>  
>>
>>> Rafael J. Wysocki wrote:
>>>    
>>>
>>>> On Monday, 6 November 2006 02:54, Marc Perkel wrote:
>>>>        
>>>>
>>>>> Trying to compile a new kernel and getting this on boot
>>>>>
>>>>> could not find filesystem /dev/root
>>>>>             
>>>>
>>>> Which kernel?
>>>>         
>>>
>>> 2.6.19rc4
>>>     
>>
>>
>> What is the last working version?
>>   
> 
> 
> Last one I tried that worked other than the stock kernel is 2.6.18 but
> I've upgraded from FC5 to FC6 since then.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I ran into the same problem when using an FC-6 .config file compiling 2.6.19-rc4.  In my case, the problem was that the configuration options for Serial ATA have changed since 2.6.18 (which the FC-6 config is based on).  I had to manually go in to the config (with make menuconfig) and turn on the SATA device that I have.  What kind of SATA controller do you have, and what does your .config look like?

Chris Lalancette
