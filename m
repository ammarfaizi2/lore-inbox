Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSJ0WYr>; Sun, 27 Oct 2002 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJ0WYr>; Sun, 27 Oct 2002 17:24:47 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:27581 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S262697AbSJ0WYp>;
	Sun, 27 Oct 2002 17:24:45 -0500
Message-ID: <3DBC6827.5030002@tpg.com.au>
Date: Mon, 28 Oct 2002 09:26:47 +1100
From: Bill Leckey <bleckey@tpg.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System lockup.
References: <3DB3442A.7050002@tpg.com.au> <1035199818.27259.34.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I've been running 2.4.19 on three systems for about 3 days 
now.  Where before I would expect each system to hang at least once a 
day, I've had no hangs whatsoever.

I'm not sure if it was the PPP race or something else but 2.4.19 seems 
(at least so far) much more stable.

Thanks for the advice Alan.

Bill

Alan Cox wrote:
> On Mon, 2002-10-21 at 01:02, Bill Leckey wrote:
> 
>>I have a terminal server that's supporting up to 240 lines.  It's a 
>>2.4.17 kernel, and is running squid, and using the reiser file system to 
>>store log files, squid cache and other data.  About every day or so, the 
>>machine locks up.  The screen is blank, keyboard doesn't respond, the 
>>serial console I set up shows no 'dying gasp' and there is nothing in 
>>any of the system logs.
>>
>>This doesn't appear to be related to load as it has happened both during 
>>the busiest times and during the low times.
>>
>>I'm still servicing interrupts from our serial devices (on IRQ 11), so 
>>it seems interrupts are still happening.
>>
>>Beyond this, however, I have no idea where to go from here.  If anyone 
>>has any hints on what the problem might be, or even a way to gather more 
>>information, I would be grateful.
> 
> 
> Hardware details would be a useful starting point. Also if its
> uniprocessor or SMP. Finally have you considered 2.4.19 as 2.4.17 does
> have at least one known and fixed small PPP race. With 240 lines I guess
> you might actually hit that
> 

