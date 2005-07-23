Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVGWDiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVGWDiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVGWDiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:38:24 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:26045
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262325AbVGWDfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:35:53 -0400
Message-ID: <42E1ACCF.8000308@linuxwireless.org>
Date: Fri, 22 Jul 2005 21:34:55 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>,
       Andrian Bunk <bunk@stusta.de>, "H. Peter Anvin" <hpa@zytor.com>,
       torvalds@osdl.org
Subject: Re: Giving developers clue how many testers verified	certain	kernel
 version
References: <200507230244.11338.blaisorblade@yahoo.it>	 <42E1986B.8070202@linuxwireless.org> <1122088160.6510.7.camel@mindpipe>	 <42E1A832.7010604@linuxwireless.org> <1122088863.6510.19.camel@mindpipe>
In-Reply-To: <1122088863.6510.19.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Fri, 2005-07-22 at 21:15 -0500, Alejandro Bonilla wrote:
>  
>
>>OK, I will, but I first of all need to learn how to tell if benchmarks 
>>are better or worse.
>>    
>>
>
>Con's interactivity benchmark looks quite promising for finding
>scheduler related interactivity regressions.  It certainly has confirmed
>what we already knew re: SCHED_FIFO performance, if we extend that to
>SCHED_OTHER which is a more interesting problem then there's serious
>potential for improvement.  AFAIK no one has posted any 2.4 vs 2.6
>interbench results yet...
>  
>
I will give it a try.

>I suspect a lot of the boot time issue is due to userspace.  But, it
>should be trivial to benchmark this one, just use the TSC or whatever to
>measure the time from first kernel entry to execing init().
>  
>
You got it! As a laptop user, I think it just takes too much more. I 
think it is maybe hotplugs fault with the kernel? I don't know how much 
is done by the kernel or userspace but it definitely takes longer.

I could do some sort of benchmarks, but believe me, I hate to say this, 
but I use 2.6 because of much more power managements features in it. 
Else I like 2.4 a lot more. Is like, the feels is sharper. Sometimes 
when I got into a tty1, it takes some time after I put my username in to 
prompt me for a password. This does not occur when I boot with 2.4.27. 
Strange huh?

I don't want to be an ass and say that 2.4 is better, instead I want to 
help and let determine why is it that I feel 2.6 slower.

.Alejandro

>Lee 
>
>
>  
>

