Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVJ1DJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVJ1DJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 23:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVJ1DJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 23:09:29 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:19366 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S965074AbVJ1DJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 23:09:29 -0400
Date: Thu, 27 Oct 2005 20:09:21 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Fawad Lateef <fawadlateef@gmail.com>
cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
In-Reply-To: <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510271947360.32301@twin.uoregon.edu>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> 
 <20051027204923.M89071@linuxwireless.org>  <1130446667.5416.14.camel@blade>
  <20051027205921.M81949@linuxwireless.org>  <1130447261.5416.20.camel@blade>
  <20051027211203.M33358@linuxwireless.org> <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005, Fawad Lateef wrote:

> On 10/28/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
>> On Thu, 27 Oct 2005 23:07:41 +0200, Marcel Holtmann wrote
>>> Hi Alejandro,
>>>
>>> so there is no way to give me back the "lost" memory. Is it possible
>>> that another motherboard might help?
>>
>> AFAIK, No. AMD and Intel will always do the same thing until we all move to
>> real IA64.
>>
>
> Can you tell me the main differences between IA64 and x86_64 (Opteron)

IA64 is itanium - there are a lot of differences but the principle one for 
your perspective is that you don't want to run x86 code on a itanium, it 
has an x86 instruction decoder but you wouldn't want to use it if you 
could avoid it.

> ? because in your one of the previous mail you said IA64 != EM64T and

emt64 getts lumped with amd64 collectivly x86_64. fundamentaly intels 
implementation is compatible with amd's

> its true, but I know is EM64T/AMD64 in 64-bit mode != IA32 but you
> said that too EM64T is not really 64-bit, its a IA32 .. Can you give

It is ia32 except with 40 bits of real memory and 48 bits of virtual 
memory and 64 bit registers.

one article that's use for getting a start on the instruction set is here:

http://arstechnica.com/cpu/03q1/x86-64/x86-64-1.html


> me some link which just tells the difference between IA64 (Itanium)
> and AMD64 (Opteron) ?

you're not likely to care about ia64, so I think what your'e really 
interested in is ia32 vs x86_64 and intel vs amd in the context of x86_64

> While googling I found this article
> http://www.eweek.com/article2/0,1895,1046390,00.asp but its not
> clearing mentioning the difference between Opteron and Itanium !
>
> Although I found this difference in that article :
>                     With the Itanium, Intel proposes to examine
> programs when they are compiled into their executable form and encode
> concurrent operations ahead of time. Intel calls this approach EPIC,
> for Explicitly Parallel Instruction Computing, and it is the genuine
> difference between the Itanium and AMD's x86-64. EPIC's drawback is
> that the core of the Itanium no longer offers an effective
> upward-compatible path to existing x86 code; its speed in running that
> 32-bit code has proved to be disappointing.
>
> So is there any other difference except above ?
>
>
> --
> Fawad Lateef
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

