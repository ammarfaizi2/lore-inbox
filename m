Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUGJRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUGJRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUGJRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 13:05:25 -0400
Received: from [212.20.83.41] ([212.20.83.41]:17156 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id S266304AbUGJRFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 13:05:07 -0400
Message-ID: <40F021B8.1@century.cz>
Date: Sat, 10 Jul 2004 19:04:56 +0200
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a2) Gecko/20040704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Lowery <rlowery@optusnet.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Belkin Bluetooth Access Point GPL violation
References: <200407100920.i6A9Kr808614@mail001.syd.optusnet.com.au>
In-Reply-To: <200407100920.i6A9Kr808614@mail001.syd.optusnet.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.1 (chudak.century.cz [192.168.0.2]); Sat, 10 Jul 2004 19:04:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Lowery wrote:

>Hi Marcel,
>
>At this point, I have not tried pulling the firmware apart, all I have done is telnetted into 
>it and poked around a bit.
>
>If I manage to get the kernel source, my next step will be to try and work out how to 
>pull apart their firmware and repackage it with a custom kernel.
>
>-Robert
>
>  
>
Hello,

    I've try to look at firware image and it really seems that they do 
not use modules in kernel and that bluetooth drivers are compiled in. So it
really seems that they should either distribute source for their stack 
or do not distribute it at all.

Petr Titera


>>Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>>Hi Robert,
>>
>>    
>>
>>>I recently purchase a Belkin Bluetooth Access Point with USB Print
>>>Server
>>>
>>>      
>>>
>>http://catalog.belkin.com/IWCatProductPage.process?Merchant_Id=&Section_
>>
>>    
>>
>>>Id=200583&pcount=&Product_Id=134669
>>>
>>>By telnetting into it, I was able to find that it runs linux,
>>>specifically uClinux version 2.0.38.1pre7arm.
>>>
>>>Investigating further, I found the device is made by
>>>www.rovingnetworks.com
>>>
>>>The latest version of firmware may be obtained from
>>>http://www.belkin.com/firmware/bluetooth/f8t030/flash.bin or a beta
>>>version that includes PAN support at
>>>www.rovingnetworks.com/belkinpan4.bin
>>>
>>>I contacted them at support@rovingnetworks.com  Mike Conrad replied 
>>>      
>>>
>>to
>>    
>>
>>>my request.
>>>
>>>Initially, he said they wanted $5000 for a source code license.  When 
>>>      
>>>
>>I
>>    
>>
>>>Informed him of their GPL violation, he said
>>>"you could possibly have the linux os changes we made, but our 
>>>      
>>>
>>bluetooth
>>    
>>
>>>stack, for example, is not covered under the GPL. And we have special
>>>tools that enable web download, and  create the image that is loaded,
>>>etc."
>>>
>>>Looking at the running system, it is not running any kernel modules, 
>>>      
>>>
>>so
>>    
>>
>>>I would expect the bluetooth stack to be compiled into the kernel
>>>proper, which in my understanding would mean they have to release the
>>>source.
>>>      
>>>
>>may you tell me how you extracted the kernel and the filesystem from 
>>the
>>firmware files. I wanna take a look at it and find out what Bluetooth
>>stack they are using.
>>
>>Regards
>>
>>Marcel
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

