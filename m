Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278396AbRJMTfw>; Sat, 13 Oct 2001 15:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278382AbRJMTeO>; Sat, 13 Oct 2001 15:34:14 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:12548 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278376AbRJMTd7>;
	Sat, 13 Oct 2001 15:33:59 -0400
Date: Wed, 10 Oct 2001 16:25:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011010162510.A35@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.30.0110081117140.5473-100000@shell.cyberus.ca> <E15qcRA-0000uJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15qcRA-0000uJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 08, 2001 at 04:35:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Even at 200Hz polling a typical cardbus card with say 32 ring buffer slots
> can process 6000pps.

On my velo, I have pcmcia but don't quite know how to drive it properly.
I have not figured interrupts, so I ran ne2000 in polling mode. .5MB/sec
is not bad for as slow hardware as velo is (see sig). Next experiment was
ATA flash. I had to bump HZ to 1000 for it, and I'm getting spurious 
unexpected interrupt messaegs, but it works surprisingly well.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

