Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUD3T2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUD3T2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUD3T2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:28:36 -0400
Received: from mail2.webmessenger.it ([193.70.193.55]:7568 "EHLO
	mail1a.webmessenger.it") by vger.kernel.org with ESMTP
	id S264902AbUD3T2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:28:11 -0400
Message-ID: <4092A88D.70007@copeca.dsnet.it>
Date: Fri, 30 Apr 2004 21:27:09 +0200
From: Giuliano Colla <copeca@copeca.dsnet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031007
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it> <409276D6.9070500@gmx.net>
In-Reply-To: <409276D6.9070500@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger ha scritto:

>Giuliano Colla wrote:
>  
>
>>Linus Torvalds ha scritto:
>>
>>    
>>
>>>On Thu, 29 Apr 2004, Giuliano Colla wrote:
>>> 
>>>      
>>>
>>>>Let's try not to be ridiculous, please.
>>>>        
>>>>
>>>It's not abotu being ridiculous. It's about honoring peoples copyrights.
>>>      
>>>
>>On that ground you're correct.
>>[...]
>>But please do consider a different perspective.
>>
>>I'm an end user.
>>I download a damn Linuxant driver because the manufacturer of the laptop
>>I own has seen fit to use a Conexant chipset.
>>In order to do that I must:
>>a) Pay a (small) sum.
>>b) Accept a Microsoft-like license agreement.
>>If at that point I haven't realized that I'm not getting a fully GPL'd
>>software I'm really terminally stupid as you kindly suggest.
>>    
>>
>
>If you look at the price of a cardbus real modem on ebay, you might be
>surprised that these things are really cheap. Sometimes buying software to
>support the winmodems is actually more expensive than buying a real modem.
>
>
>  
>
You're right, but in a laptop using the integrated modem is more 
practical, with less stuff to carry, and less power involved. Provided 
of course I do it at my own risk, and don't try to rebutt the troubles I 
may get into to kernel people, which has more useful things to do, than 
following my personal whims.
BTW on my previous laptop I had a Lucent winmodem, whose driver doesn't 
fake the GPL license, but which was definitely inferior to the Linuxant 
driver, except for the hardware probing stupid implementation.
I'm looking forward for a time when being "Designed for Linux" will be 
more rewarding for a manufacturer than being "Designed for Windows" but 
till then I must get along with what is available.

>>However, if I'm not terminally stupid, I will never think of addressing
>>to kernel people in order to fix problems arising from or after loading
>>the driver, and associated utilities, even if lsmod doesn't show
>>"tainted" modules. Kernel people shouldn't even consider supporting the
>>resulting mess.
>>    
>>
>
>How would you know NOT to complain to linux-kernel if there is no sign you
>shouldn't?
>
>
>  
>
There's no *run-time* sign. But I was made aware of that when I 
downloaded it from a different source, and I had to agree to a non GPL 
license. It didn't originate from kernel group and I'm using it at my 
own risk.

<snip>

>>That said, I'd like to explain what made me react to the announcement
>>posted.
>>
>>Linuxant have figured a Microsoft-like brute force hardware detection
>>mechanism: they attempt to load *all* drivers, and only the one which
>>[...]
>>But I didn't appreciate that the reaction to that mess has been also on
>>Microsoft style.
>>The reaction has been:
>>
>>a) a workaround of the workaround (if you put a \0, I'll detect the
>>Linuxant string)
>>    
>>
>
>Was there anything else that could have been done for the existing fake
>GPL modules?
>
>
>  
>
Maybe I fail to grasp the full picture, but I'd just have ignored it. 
Please remember that they "fake" GPL only at run-time, not when you get 
them.

>>b) a lie (the /GPL directory is empty).
>>    
>>
>
>I have this FUCKING Linuxant .rpm with an empty GPL directory right on my
>hard disk. And this .rpm is signed by Linuxant. So either Linuxant has
>been hacked (someone stole the key, signed a bogus rpm and broke into thir
>site uploading it) or they are careless (forgetting to fill the GPL
>directory for some packages). In both cases I would not trust them.
>
>
>  
>
If you download the "generic package with source" either rpm or tar.gz, 
you'll find the GPL directory populated. I've checked again right now, 
just to be sure. At least, this holds true for hsf modem, which is the 
one I'm actually using.

If you're interested, and have time, you may also estimate if they've 
implemented in the GPL part all of the critical kernel code (as I had 
assumed, maybe naively, from a cursory look to the code), leaving in the 
proprietary binaries only the "proprietary" compression/decompression 
algorithms, or if they've just provided a minimal wrapper, with all 
"real" code proprietary.

It may make sense not to have anything left in the GPL directory in a 
binary only .rpm package, because once linked GPL parts cannot be told 
apart from non-GPL ones.

-- 
Ing. Giuliano Colla
Direttore Tecnico
Copeca srl
Bologna Italy


