Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316640AbSE0Opl>; Mon, 27 May 2002 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSE0Opk>; Mon, 27 May 2002 10:45:40 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12956 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316640AbSE0Opi>;
	Mon, 27 May 2002 10:45:38 -0400
Date: Mon, 27 May 2002 09:07:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020527090746.B35@toy.ucw.cz>
In-Reply-To: <3CEB9465.6040409@evision-ventures.com> <Pine.GSO.4.21.0205220957320.2737-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > So at least we know now:
> > 
> > 1. Kernel is bogous.
> > 2. util-linux is bogous.
> > 
> > IOCTL is ineed the way to go to implement such functionality...
> 
> For kbdrate???  sysctl I might see - after all, we are talking about
> setting two numbers.  ioctl() to pass a couple of integers to the kernel?
> No, thanks.

There may be more than one keyboard in the system, so sysctl() is not 
suitable.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

