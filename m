Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTKUJPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 04:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTKUJPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 04:15:06 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:36252 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264337AbTKUJPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 04:15:01 -0500
Message-ID: <3FBDD790.5060401@cyberone.com.au>
Date: Fri, 21 Nov 2003 20:14:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v19a
References: <3FB62608.4010708@cyberone.com.au>	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>	 <1069395102.16807.11.camel@midux>  <3FBDAE99.9050902@cyberone.com.au> <1069405566.18362.5.camel@midux>
In-Reply-To: <1069405566.18362.5.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Hästbacka wrote:

>Hi again.
>I'm not sure if this is because of the patch or what, but my X crashes
>normally in ~2 days, and the framebuffer gets all messy (green lines,
>can't see what I'm typing, etc.), this doesn't happen with your patch at
>all, only with vanilla kernel(s). Maybe my hardware likes your patch or
>something. My X have been running for four days now without any kind of
>problem on the patched kernel. (I'm not sure if it's the kernel or what,
>but reported it anyway). That's the only problem I've been getting more
>than often.
>
>There's no other problems, only that the kernel standard scheduler is a
>bit slower than yours.
>  
>

Well yes its possible that my scheduler is better at hiding some bug. It
wouldn't be fixing anything, of course. It definitely was better at
exposing a kernel or postgresql bug when running OSDL's PostgreSQL tests -
I saw the crash 3 times I think, though never with standard kernel.

I don't know how you should be reporting X crashes. I guess you could report
the bug to the XFree86 guys as per their guidelines if you can reproduce the
crashes with an up to date 2.4 kernel.

Nick

>Regards,
>Markus
>
>On Fri, 2003-11-21 at 08:20, Nick Piggin wrote:
>  
>
>>Well that's very good to hear :) err, just remember if you have
>>any specific problems with unpatched 2.6 to make a report. We
>>want the standard scheduler to run well too.
>>
>>Thanks,
>>Nick
>>    
>>

