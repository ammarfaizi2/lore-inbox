Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313044AbSDYKXu>; Thu, 25 Apr 2002 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313045AbSDYKXt>; Thu, 25 Apr 2002 06:23:49 -0400
Received: from [159.226.41.188] ([159.226.41.188]:7431 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S313044AbSDYKXs>; Thu, 25 Apr 2002 06:23:48 -0400
Date: Thu, 25 Apr 2002 18:6:6 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: what`s wrong?
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE8E9F3.AAA6F3A@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I am very sorry to ask such a stupid question. I think I have to work harder 8-)
  Thank you all, especially Matti Aarnio, Mike Galbraith, Joe Thornber.
  Now, I began to treat the kernel as an ordinary, but much more complex, C program.  :)


>On Thu, Apr 25, 2002 at 05:12:21PM +0800, Huo Zhigang wrote:
>....
>> >The entire kernel stack is only 8kB in size.  You have already killed
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >a bunch of random memory by allocating this much memory on the stack.
>> >You allocated 4*8192 = 32kB on the stack here.
>>   
>>    Sure, the kernel stack is 8192 Bytes, but "err_frame[]" is a local 
>>    variable. Does the kernel allocate memory for "err_frame[]" from the 
>>    stack?? 
>
>   It is not about how KERNEL does it, but how C (programming language)
>   does it.  If you don't know C's memory management things regarding
>   various classes of variables, I suggest you pick some good reference
>   book and study it asap.
>
>>    Here, I think, err_frame[] as a function parameter  will take 8K in 
>>    the kernel stack.  Am I correct?
>

      

