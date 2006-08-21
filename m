Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWHUUP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWHUUP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWHUUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:15:26 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:27282 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1750922AbWHUUP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:15:26 -0400
Message-ID: <44EA1B74.3000702@wolfmountaingroup.com>
Date: Mon, 21 Aug 2006 14:45:40 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: ndiswrapper]
References: <44E9D0FB.4000806@wanadoo.fr> <44E9DD89.4030106@wolfmountaingroup.com> <44E9DA18.1010602@wanadoo.fr> <44E9E6A9.2030803@wolfmountaingroup.com> <44EA1335.9000004@wanadoo.fr>
In-Reply-To: <44EA1335.9000004@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:

> That's not the kernel of my distrib (Ubuntu Dapper). That's my own 
> kernel compiled with the option -binary. So, I installed manually the 
> .deb from kernel.org to sources, image, and headers. Maybe there is a 
> problem of links, to headers by example ?

Looks that way.  First thing it to get a stable kernel tree you can 
build and boot from without ndiswrapper.  Next is check their makefiles 
for ndiswrapper.
I have never attempted to build it on Ubuntu, just Suse and RedHat so 
there may be issues with this.

Jeff

>
>
>
> Jeff V. Merkey a écrit :
>
>> Hulin Thibaud wrote:
>>
>>> I rebuilt ndiswrapper 1.19 version. When I type make, I have these 
>>> errors :
>>>
>>> /usr/src/kernel-headers-2.6.17.060815.dell/Ach/i386/Makefile:383 
>>> /usr/src/kernel-headers-2.6.17.060815.dell/Ach/i386/Makefile.cpu : 
>>> No file or folder of this type
>>> Not rules to built the target
>>>
>>> (I traduce from french)
>>>
>>> Jeff V. Merkey a écrit :
>>>
>>>> Hulin Thibaud wrote:
>>>>
>>>>> Hi !
>>>>> I wanted to write at the kernel-net list, but that don't works.
>>>>> I updated my kernel and compiled it to 2.6.17, but now, ndiswrapper
>>>>> don't recognize my dongle Thomson XG-1500A.
>>>>> What can I do ?
>>>>> Thanks you very much,
>>>>> Thibaud.
>>>>>
>>>>>
>>>>> -
>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>> linux-kernel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>>
>>>> Use the .19 ndiswrapper and try rebuilding.
>>>> Jeff
>>>>
>>>>
>>>
>>>
>> Sounds like the kernel includes and sources are not fully installed.  
>> Don't rely on stock kernels for any of the distros, go the the 
>> provider and get the kernel andall the header sources.
>>
>> Jeff
>>
>>
>
>

