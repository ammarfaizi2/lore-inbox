Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbRERRHi>; Fri, 18 May 2001 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261193AbRERRHU>; Fri, 18 May 2001 13:07:20 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261173AbRERRGI>;
	Fri, 18 May 2001 13:06:08 -0400
Date: Thu, 17 May 2001 10:42:26 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010517104226.B44@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 01:37:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Hi!

> They might also be exactly the same channel, except with certain magic
> bits set. The example peter gave was fine: tty devices could very usefully
> be opened with something like
> 
> 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> 
> where we actually open up exactly the same channel as if we opened up
> /dev/cua00, we just set the speed etc at the same time. Which makes things

Hmm, there might be problem with this. How do you change speed without
reopening device? [Remember: your mice knows when you close device]
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

