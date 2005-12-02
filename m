Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVLBSDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVLBSDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVLBSDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:03:36 -0500
Received: from mail.tmr.com ([64.65.253.246]:53657 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750865AbVLBSDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:03:35 -0500
Message-ID: <43908F5D.6070607@tmr.com>
Date: Fri, 02 Dec 2005 13:15:57 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>	 <20051123233016.4a6522cf.pj@sgi.com>	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>	 <200512020849.28475.vda@ilport.com.ua>	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>	 <4390730F.8000909@tmr.com> <2cd57c900512020907h4be23519q@mail.gmail.com>
In-Reply-To: <2cd57c900512020907h4be23519q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>2005/12/3, Bill Davidsen <davidsen@tmr.com>:
>  
>
>>Coywolf Qi Hunt wrote:
>>
>>    
>>
>>>This is a reason why enums are worse than #defines.
>>>
>>>Unlike in other languages, C enum is not much useful in practices.
>>>      
>>>
>>Actually they are highly useful if you know how to use them. They allow
>>type checking, have auto increment, and are part of the language instead
>>  of a feature of the preprocessor.
>>    
>>
>
>Yes, I know type checking and auto increment. But they are not
>worthwhile, at least not for serious C programming. No, I don't know
>how to use them comfortably.
>  
>

Type checking is not useful for serious C programming? Really?

>What's wrong with sorted macros? They are more flexible and readable.
>enums just look weird. We also share macros b/w C and asm.
>
>You words on language and preprocessor doesn't make any sense.
>  
>

They highlight the difference. The preprocessor is a form of text 
editor, which only knows what the source *says* but not what it *means*. 
The compiler knows about types, common subexpressions, etc.

>It's not a feature of the preprocessor, it's what cpp is for. Look, I
>call it Cpp. Without this `feature', what would a C preprocessor do?
>You've castrated cpp.
>
>Follow you logic, C standard should only specify C language, not
>anything of libc...  I have no interest in arguing the relations b/w C
>and cpp.
>  
>

The standard should specify the source language and it's meaning. The 
fact that it specifies what cpp does (text editing) as well is for 
convenience. The language works the same whether you write it with vi or 
cpp, cpp is just more convenient that sed ;-)

>  
>
>>>Maybe the designer wanted C to be as fancy as other languages?  C
>>>shouldn't have had enum imho. Anyway we don't have any strong motives
>>>to switch to enums.
>>>      
>>>
>>The last sentence seems correct in spite of your misunderstanding of how
>>and why enums are used and useful. Like a driver who mis-read a map
>>wandering aimlessly and lost, you have come to the correct destination
>>by accident.
>>    
>>
>
>lol
>
>  
>
>>It would have been good to use enums in the first place, I can't see
>>changing now because of the effort involved.
>>    
>>
>
>You contradict yourself rather.
>  
>

Not at all... enum would have been better, but not so much better that 
it's worth doing over.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

