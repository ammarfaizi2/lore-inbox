Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJLRH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJLRH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUJLRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:06:54 -0400
Received: from ns2.gabswave.net ([193.219.214.10]:3295 "EHLO gabswave.net")
	by vger.kernel.org with ESMTP id S266252AbUJLRE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:04:59 -0400
Message-ID: <001501c4b07d$96a31fd0$0200060a@STEPHANFCN56VN>
From: "Stephan" <support@bbi.co.bw>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN> <20041012141123.GA18579@stusta.de> <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN> <Pine.LNX.4.61.0410121048110.3470@chaos.analogic.com> <000c01c4b07b$c10060f0$0200060a@STEPHANFCN56VN> <Pine.LNX.4.61.0410121256510.12380@chaos.analogic.com>
Subject: Re: Problem compiling linux-2.6.8.1......
Date: Tue, 12 Oct 2004 19:04:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-gabswave.net-MailScanner-Information: Please contact the ISP for more information
X-gabswave.net-MailScanner: Found to be clean
X-MailScanner-From: support@bbi.co.bw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc (GCC) 3.2.3 20030502

----- Original Message ----- 
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Stephan" <support@bbi.co.bw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 12, 2004 7:02 PM
Subject: Re: Problem compiling linux-2.6.8.1......


> On Tue, 12 Oct 2004, Stephan wrote:
>
>> I've created the typescript as suggested but the only thing I found that 
>> seemed out off place is the following line, altough I don't think it's 
>> got anything todo with the error I'm getting.
>>
>> CC [M]  fs/binfmt_misc.o
>> include/asm/string.h:32: warning: `strcpy' defined but not used
>>
>
> This shouldn't happen. It's a definition in a header file!
> It looks line the 'inline' gnu-ism isn't working! Could you
> publish the result of
>  gcc --version
>
>
>>
>> Everyhting else seems normal.
>>
>> Kind regards
>> steph
>>
>> ----- Original Message ----- From: "Richard B. Johnson" 
>> <root@chaos.analogic.com>
>> To: "Stephan" <support@bbi.co.bw>
>> Cc: "Adrian Bunk" <bunk@stusta.de>; <linux-kernel@vger.kernel.org>
>> Sent: Tuesday, October 12, 2004 4:49 PM
>> Subject: Re: Problem compiling linux-2.6.8.1......
>>
>>
>>> On Tue, 12 Oct 2004, Stephan wrote:
>>>
>>>> I've tried to recompile the kernel and watched very carefully for 
>>>> anything out off the ordinary but could not find anything that might 
>>>> relate to an error message.
>>>>
>>>> Is there anything specific I should keep any eye out for?
>>>>
>>>> Kind Regards
>>>> Steph
>>>
>>> Do:
>>>
>>> script
>>>
>>> make clean
>>> make
>>>
>>> exit
>>>
>>> Whatever happened is now in file typescript.
>>>
>>>
>>>
>>> Cheers,
>>> Dick Johnson
>>> Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
>>>             Note 96.31% of all statistics are fiction.
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
> 


