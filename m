Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWARHHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWARHHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWARHHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:07:01 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:1504 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030263AbWARHHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:07:00 -0500
X-Sasl-enc: pHz7eFH5KFhSzNEznw8KSsg5RJksJRpX6IanBV4orEF/ 1137568014
Message-ID: <43CDE907.8070508@fastmail.co.uk>
Date: Wed, 18 Jan 2006 15:06:47 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060116)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CDAFE3.8050203@fastmail.co.uk> <43CDC44E.6080808@wolfmountaingroup.com> <43CDCD9F.5050500@fastmail.co.uk> <43CDC607.2040501@wolfmountaingroup.com>
In-Reply-To: <43CDC607.2040501@wolfmountaingroup.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Max Waterman wrote:
> 
>> Jeff V. Merkey wrote:
>>
>>> Max Waterman wrote:
>>>
>>>> One further question. I get these messages 'in' dmesg :
>>>>
>>>> sda: asking for cache data failed
>>>> sda: assuming drive cache: write through
>>>>
>>>> How can I force it to be 'write back'?
>>>
>>>
>>>
>>>
>>> Forcing write back is a very bad idea unless you have a battery 
>>> backed up RAID controller.  
>>
>>
>> We do.
>>
>> In any case, I wonder what the consequences of assuming 'write 
>> through' when the array is configured as 'write back'? Is it just 
>> different settings for different caches?
> 
> 
> It is.  This is something that should be configured in a RAID 
> controller.  OS should always be write through.

Ok, thanks for clearing that up, though I now wonder why the message is 
there.

<shrug>

Max.

> 
> Jeff
> 
>>
>> Max.
>>
>>> Jeff
>>>
>>>>
>>>> Max.
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-kernel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>
>>
>>
> 

