Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbRGJV4Q>; Tue, 10 Jul 2001 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbRGJV4G>; Tue, 10 Jul 2001 17:56:06 -0400
Received: from mail01.onetelnet.fr ([213.78.0.138]:21344 "EHLO
	mail01.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S267154AbRGJVzw>; Tue, 10 Jul 2001 17:55:52 -0400
Message-ID: <3B4BCD05.2070107@onetelnet.fr>
Date: Tue, 10 Jul 2001 23:50:29 -0400
From: FORT David <epopo@onetelnet.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: "C. Slater" <cslater@wcnet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <NOEJJDACGOHCKNCOGFOMOEKECGAA.davids@webmaster.com> <001501c10980$f42035a0$fe00000a@cslater>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C. Slater wrote:

>
>>>    - Replace all saved structures
>>>
>>>what if the layout of these changes as it often does?
>>>
>>You would want to convert all structures into a neutral encoding scheme
>>that would support transferring structures across versions. BER comes to
>>mind, as it provides for an easy way to ignore stuff you don't understand
>>and support multiple versions of the same object in a single encoding.
>>
>>However, this would be a truly massive task. And the big challenge would
>>
>be
>
>>what to do when an older kernel doesn't understand something essential. It
>>could be simplified significantly by supporting live replacement only of
>>kernels of the same version, but this seems to defeat much of the purpose.
>>
>>DS
>>
>
>I don't think that it would be possible to switch kernels when one was not
>properly set up to do it, if thats what you mean. You could only switch
>between kernels that have been compiled to support live switching.
>
>I do see you'r point with the datastructures changeing. We would need to use
>some format that all properly setup kernels could understand, then we would
>only need to write enough to convert the structs to the middle format and
>back when they change. I am not familer with BER, but if it is suitable, it
>may help.
>
>Are you saying that swaping the kernels out altogether would be a massive
>task, or that saveing/restoring the datastructures would be a massive task.
>
>  Colin
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
I remembered that this thread was longly discussed 1 or 2 years ago on 
linux-future
and came to no conclusive end.

-- 
 HomePage: http://www.enlightened-popo.net  
-- This was sent by Djinn running Linux 2.4.5 -- 



