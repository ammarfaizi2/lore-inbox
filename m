Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264870AbRFYQ3P>; Mon, 25 Jun 2001 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbRFYQ3F>; Mon, 25 Jun 2001 12:29:05 -0400
Received: from Expansa.sns.it ([192.167.206.189]:4359 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264864AbRFYQ2y>;
	Mon, 25 Jun 2001 12:28:54 -0400
Date: Mon, 25 Jun 2001 18:28:52 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <joeja@mindspring.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Re: AMD thunderbird oops
In-Reply-To: <Springmail.105.993486251.0.81762700@www.springmail.com>
Message-ID: <Pine.LNX.4.33.0106251827570.5670-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you considered to change your dimm at all?
If they are bugged they should be under warranty.

Luigi


On Mon, 25 Jun 2001 joeja@mindspring.com wrote:

> Thanks,
>     I have a heat sink and it is huge about 2 inches, plus fan. Plus another 4" fan in the case. (real nice case).
>
>     I think it is the memory, as yesterday my gcc was bombing with 'internel compiler error', which is usually a good mem tester.  So I started setting mem=64m and things worked better and the install went all the way through.  I think I need to slow my drams down a bit or add some delay in the bios settings.
>
>    The oops says something like 'kernel null pointer at address 0x000000'.  How do I 'catch' the output of an oops when the filesystem goes and I get ext2fs errors and am forced to reboot and manually run e2fsck?
>
>     Lastly with the mem=64M or mem=128M when I do a make dep, I get an error message that says Error 'missing seperator'.  What does that mean?  It stops in the drivers/net dir when I get this message?
>
> Thanks
> Joe
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > I just upgradede my system to an 1200Mhz AMD Athlon Thundirbird (266Mhz FSB) processor  / 512Meg of RAM, and an Asus kt7a motherboard.  >
> > It is oppsing left and right.  I recompiled the kernel with Athelon as the CPU but keep getting these oopses..
> >
> > I also get these same problems while trying to install RH 7.1
> >
> > Anyone know is this a supported processor / MB and has anyone had these problems?
>
> Random oopses normally indicate faulty board cpu or ram (and the fault may
> even just be overheating or dimms not in the sockets cleanly). I doubt its
> the board design or model that is the problem, you probably jut have a faulty
> component somewhere if its oopsing randomly even during installs and stuff
>
> memtest86, and heatsink compound may be your best friends
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

