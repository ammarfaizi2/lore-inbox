Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUJLRH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUJLRH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUJLRGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:06:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266250AbUJLRDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:03:01 -0400
Date: Tue, 12 Oct 2004 13:02:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephan <support@bbi.co.bw>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling linux-2.6.8.1......
In-Reply-To: <000c01c4b07b$c10060f0$0200060a@STEPHANFCN56VN>
Message-ID: <Pine.LNX.4.61.0410121256510.12380@chaos.analogic.com>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN>
 <20041012141123.GA18579@stusta.de> <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN>
 <Pine.LNX.4.61.0410121048110.3470@chaos.analogic.com>
 <000c01c4b07b$c10060f0$0200060a@STEPHANFCN56VN>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Stephan wrote:

> I've created the typescript as suggested but the only thing I found that 
> seemed out off place is the following line, altough I don't think it's got 
> anything todo with the error I'm getting.
>
> CC [M]  fs/binfmt_misc.o
> include/asm/string.h:32: warning: `strcpy' defined but not used
>

This shouldn't happen. It's a definition in a header file!
It looks line the 'inline' gnu-ism isn't working! Could you
publish the result of
 		gcc --version


>
> Everyhting else seems normal.
>
> Kind regards
> steph
>
> ----- Original Message ----- From: "Richard B. Johnson" 
> <root@chaos.analogic.com>
> To: "Stephan" <support@bbi.co.bw>
> Cc: "Adrian Bunk" <bunk@stusta.de>; <linux-kernel@vger.kernel.org>
> Sent: Tuesday, October 12, 2004 4:49 PM
> Subject: Re: Problem compiling linux-2.6.8.1......
>
>
>> On Tue, 12 Oct 2004, Stephan wrote:
>> 
>>> I've tried to recompile the kernel and watched very carefully for anything 
>>> out off the ordinary but could not find anything that might relate to an 
>>> error message.
>>> 
>>> Is there anything specific I should keep any eye out for?
>>> 
>>> Kind Regards
>>> Steph
>> 
>> Do:
>> 
>> script
>> 
>> make clean
>> make
>> 
>> exit
>> 
>> Whatever happened is now in file typescript.
>> 
>> 
>> 
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
>>             Note 96.31% of all statistics are fiction.
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

