Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTARGFU>; Sat, 18 Jan 2003 01:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTARGFU>; Sat, 18 Jan 2003 01:05:20 -0500
Received: from 115.8.237.216.globalpac.com ([216.237.8.115]:2283 "EHLO
	mail.yessos.com") by vger.kernel.org with ESMTP id <S262780AbTARGFS>;
	Sat, 18 Jan 2003 01:05:18 -0500
Message-ID: <3E28F0B6.50008@tmsusa.com>
Date: Fri, 17 Jan 2003 22:14:14 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01 (NSCD7.01)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
References: <15911.64825.624251.707026@harpo.it.uu.se> <Pine.LNX.4.44.0301171808010.15056-100000@chaos.physics.uiowa.edu> <20030118054504.GA909@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A confirmation from the peanut gallery -

2.5.59 oopses during boot, 2.5.59 plus the
vmlinux.lds.S  patch boots and runs fine -

Also Red Hat 8.0 -

Joe

Christopher Faylor wrote:

>On Fri, Jan 17, 2003 at 06:11:01PM -0600, Kai Germaschewski wrote:
>  
>
>>On Fri, 17 Jan 2003, Mikael Pettersson wrote:
>>
>>    
>>
>>>This oops occurs for every module, not just af_packet.ko, at
>>>resolve_symbol()'s first call to __find_symbol().
>>>      
>>>
>>Okay, the details I received so far seem to indicate that the appended 
>>patch will fix it, though I didn't get actual confirmation it does.
>>
>>If you experience crashes when loading modules (and have RH 8 binutils), 
>>please give it a shot.
>>    
>>
>
>It isn't a scientific test since I also just added the 2.5.59-mm1
>patches, but applying this patch seemed to fix my problems.  I'm sending
>this from a kernel running 2.5.59 + mm1 + your patch, built with RH 8.0
>binutils.
>
>cgf
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


