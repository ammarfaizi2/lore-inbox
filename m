Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264861AbRFYQYf>; Mon, 25 Jun 2001 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbRFYQYZ>; Mon, 25 Jun 2001 12:24:25 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:35629 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S264861AbRFYQYQ>; Mon, 25 Jun 2001 12:24:16 -0400
From: joeja@mindspring.com
Date: Mon, 25 Jun 2001 12:24:11 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: AMD thunderbird oops
Message-ID: <Springmail.105.993486251.0.81762700@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, 
    I have a heat sink and it is huge about 2 inches, plus fan. Plus another 4" fan in the case. (real nice case). 

    I think it is the memory, as yesterday my gcc was bombing with 'internel compiler error', which is usually a good mem tester.  So I started setting mem=64m and things worked better and the install went all the way through.  I think I need to slow my drams down a bit or add some delay in the bios settings.  

   The oops says something like 'kernel null pointer at address 0x000000'.  How do I 'catch' the output of an oops when the filesystem goes and I get ext2fs errors and am forced to reboot and manually run e2fsck?  

    Lastly with the mem=64M or mem=128M when I do a make dep, I get an error message that says Error 'missing seperator'.  What does that mean?  It stops in the drivers/net dir when I get this message?

Thanks
Joe

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I just upgradede my system to an 1200Mhz AMD Athlon Thundirbird (266Mhz FSB) processor  / 512Meg of RAM, and an Asus kt7a motherboard.  > 
> It is oppsing left and right.  I recompiled the kernel with Athelon as the CPU but keep getting these oopses..
> 
> I also get these same problems while trying to install RH 7.1
> 
> Anyone know is this a supported processor / MB and has anyone had these problems?

Random oopses normally indicate faulty board cpu or ram (and the fault may 
even just be overheating or dimms not in the sockets cleanly). I doubt its
the board design or model that is the problem, you probably jut have a faulty
component somewhere if its oopsing randomly even during installs and stuff

memtest86, and heatsink compound may be your best friends


