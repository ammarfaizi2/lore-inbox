Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTHaVvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTHaVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:51:15 -0400
Received: from pasky.ji.cz ([213.226.226.138]:33525 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262718AbTHaVvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:51:13 -0400
Date: Sun, 31 Aug 2003 23:51:11 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
Message-ID: <20030831215111.GB573@pasky.ji.cz>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Andre Hedrick <andre@linux-ide.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831161634.GA695@pasky.ji.cz> <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk> <200308312032.47638.bzolnier@elka.pw.edu.pl> <20030831185706.GB695@pasky.ji.cz> <20030831200639.GA573@pasky.ji.cz> <1062364872.11140.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062364872.11140.13.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Aug 31, 2003 at 11:21:13PM CEST, I got a letter,
where Alan Cox <alan@lxorguk.ukuu.org.uk> told me, that...
> On Sul, 2003-08-31 at 21:06, Petr Baudis wrote:
> > I did few more experiments, and one strange thing is that /proc/dma does not
> > change when turning using_dma on thru hdparm:
> 
> IDE DMA is PCI not ISA. It appears your mainboard is dying when both ISA
> and PCI DMA occur together. If so you'd want to drop the ESS audiodrive
> into PIO mode assuming ALSA supports it (OSS doesnt although I've got
> the docs if you care that much).

I don't ;-) - I lived w/o IDE DMA until now so I guess I'll survive for another
while. Thanks for the help, though. I will try again with ALSA+PIO later in the
2.6.0-test stage, when the other aspects (fb and usb) will more-or-less be
usable for me for daily use.

> Can you do another test here - write to a floppy disk while doing IDE
> DMA and see if it also hangs.

It works fine (aside of the ancient floppy disk grifting terribly).

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
