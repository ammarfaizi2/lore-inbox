Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316067AbSENV0l>; Tue, 14 May 2002 17:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316068AbSENV0k>; Tue, 14 May 2002 17:26:40 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8343 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316067AbSENV0j>;
	Tue, 14 May 2002 17:26:39 -0400
Date: Mon, 13 May 2002 12:37:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Diego Calleja <DiegoCG@teleline.es>, Andi Kleen <ak@muc.de>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
Message-ID: <20020513123731.B34@toy.ucw.cz>
In-Reply-To: <20020512225724.232357b3.DiegoCG@teleline.es> <Pine.GSO.3.96.1020513141909.26083B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sorry for my ignorance, but the typical conectors: mouse, keyboard,
> > /dev/ttyS0, /dev/ttyS1, /dev/lp0...aren't isa devices? 
> 
>  The PS/2 mouse and the keyboard (or the 8042, actually) are motherboard
> devices using the 0x00-0xff range of I/O ports -- ISA is above that.

outb to 0x80, and watch it go to ISA. Not all ports < 0x80 are mainboard.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

