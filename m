Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVI0MUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVI0MUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVI0MUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:20:41 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:19357 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S964814AbVI0MUk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:20:40 -0400
In-Reply-To: <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Date: Tue, 27 Sep 2005 09:20:33 -0300
To: Grzegorz Kulewski <kangur@polcom.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Grzegorz. Thank you for your response.

On Sep 27, 2005, at 8:43 AM, Grzegorz Kulewski wrote:
> What is your southbridge?

The southbridge is a VIA VT82C686.

> Maybe there are some problems there with DMA or cables.

Humm, cables. I forgot to check that. I will check that as soon as I  
wake up. I spent the entire night trying to fix this, but of course,  
I gave up after some days of effort and decided to ask for help.

> Anything in logs?

Nothing in the logs. No oops, no stack trace, no nothing. :-( Oh, now  
that you mention it, I remember that I also made my Matrox G400 use  
speed 4x. I will try slowing it down to see if there is any influence  
on what I see.

> Maybe sourthbridge or northbridge is simply overheating? Maybe you  
> have bad power suply? What are readings of temperatures and  
> voltages in BIOS after some heavy disk-memmory activities?

I don't know, because lmsensors doesn't give accurate measurements,  
unfortunately. :-(

> You can use http://pyropus.ca/software/memtester/ to check your  
> memory in linux. You can run cpuburn at the same time. And you can  
> do some disk activity at the same time (for example dd if=/dev/hda  
> bs=200M | md5sum several times to check if it will give the same  
> results).

I had already tried using memtester, but I guess that I was too  
ambitious with the amount of memory that I tried it to allocate. I  
will try this, but with my filesystem in read-only mode, as I cannot  
afford to loose what I have (and Debian's mondo/mind isn't working  
right now---I already filed a bug report that is shared by others).

> I will bet that you have some hardware problem there. You can try  
> to remove the 256MB DDR module and turn HIGHMEM off. You can also  
> try to check each module separately.

I already checked each module separately, but I didn't see any  
corruption. I guess that I maybe wasn't paying too much attention. I  
will try it again. Thanks for the suggestion.

> And the best choice will be probably to buy new mb (for example  
> Abit KW7 or KV7) because your is very old and it can start to  
> silently break after so many years... Today mbs are very short  
> living parts - 3-4 years and they are broken...

Yes, I was just trying to avoid getting a new system now, with all  
the transitions going on (i386 -> x86_64 CPUs, PATA -> SATA etc). But  
my time is also costing me some nights of sleep... :-( It sucks not  
to be in the US, where things are cheaper. :-(


Thank you very much, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/


