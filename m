Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVBXUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVBXUKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVBXUKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:10:36 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:33731 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262464AbVBXUK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:10:27 -0500
Message-ID: <421E34B1.9050803@tiscali.de>
Date: Thu, 24 Feb 2005 21:10:25 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz> <20050224191243.GD11806@kroah.com> <20050224191809.GB7978@mail.muni.cz> <20050224192207.GB12018@kroah.com>
In-Reply-To: <20050224192207.GB12018@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Feb 24, 2005 at 08:18:09PM +0100, Lukas Hejtmanek wrote:
>  
>
>>On Thu, Feb 24, 2005 at 11:12:43AM -0800, Greg KH wrote:
>>    
>>
>>>>When connected through uhci-hcd:
>>>>T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
>>>>        
>>>>
>>>Your device is only reporting that it can go at 12Mbit (full speed, not
>>>480Mbit, which is high speed.)
>>>      
>>>
>>Is this independent of used driver?
>>    
>>
>
>Yes, this is read from the descriptor of the device.
>
>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
But why does the usb mass storage give this information to the usb 
driver? Shouldn't it report that it works with 480Mbit too?

Matthias-Christian Ott
