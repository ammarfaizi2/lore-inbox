Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTL2PWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTL2PWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:22:40 -0500
Received: from ajax.xo.com ([207.155.248.44]:4330 "EHLO ajax.xo.com")
	by vger.kernel.org with ESMTP id S263580AbTL2PWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:22:37 -0500
Message-ID: <3FF04579.1090203@katana-technology.com>
Date: Mon, 29 Dec 2003 10:17:13 -0500
From: Larry Sendlosky <lsendlosky@katana-technology.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and mice
References: <173901c3cceb$02d68560$43ee4ca5@DIAMONDLX60> <m2pte9cgbu.fsf@telia.com> <18cf01c3cdb0$2ab1cf20$43ee4ca5@DIAMONDLX60>
In-Reply-To: <18cf01c3cdb0$2ab1cf20$43ee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get my Microsoft wheel mouse to work left-handed via USB or PS/2 
adaptor.
This is with 2.6.0 and KDE from RH9.  I can only manage to get both 
buttons to
be seen as right-handed mb3 or "normal" right-handed, i.e. mb1 and mb3.  
I do
want to run 2.6.0, but I can't!  Any ideas?  (of course it all works 
fine with 2.4.23).

larry

Norman Diamond wrote:

>Peter Osterlund replied to me:
>
>  
>
>>>2.  Also in Input device support, there is a section on Mice, PS/2 mouse,
>>>and Synaptics TouchPad.  These I compiled in and they don't seem to be
>>>causing any problems.  It seems that the Alps TouchPad is being recognized
>>>as an Intelli/Wheel mouse instead of being recognized as a Synaptics
>>>TouchPad, which is unfortunate but not really causing any problems.  I've
>>>read that Synaptics is most common in foreign countries but Alps is most
>>>common in Japan.
>>>      
>>>
>>The synaptics kernel driver doesn't try to recognize alps touchpads.
>>    
>>
>
>I guess that explains why the Synaptics driver didn't cause any problems
>:-)
>
>  
>
>>However, in the XFree86 driver
>>        http://w1.894.telia.com/~u89404340/touchpad/index.html
>>there is a kernel patch (alps.patch) that makes the kernel recognize
>>alps touchpads and generate data compatible with the XFree86 synaptics
>>driver.
>>    
>>
>
>Looking at that page, I'll guess that SuSE 8.2's version of XFree86 probably
>already has that patch, because under X the touchpad is performing more than
>half of those operations correctly already.
>
>  
>
>>It doesn't work perfectly though, at least not for some hardware. The
>>problem seems to be how to interpret the gesture bit in the alps mouse
>>packets.
>>    
>>
>
>That's OK, Alps supplies notebook vendors with drivers for Monopolysoft
>OSes, and it seems that Alps hasn't completely got this working correctly
>either.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

