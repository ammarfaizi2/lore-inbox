Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTHaS5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 14:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTHaS5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 14:57:11 -0400
Received: from pasky.ji.cz ([213.226.226.138]:11248 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261561AbTHaS5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 14:57:08 -0400
Date: Sun, 31 Aug 2003 20:57:06 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
Message-ID: <20030831185706.GB695@pasky.ji.cz>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andre Hedrick <andre@linux-ide.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831161634.GA695@pasky.ji.cz> <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk> <200308312032.47638.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308312032.47638.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Aug 31, 2003 at 08:32:47PM CEST, I got a letter,
where Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> told me, that...
> On Sunday 31 of August 2003 19:57, Alan Cox wrote:
> > On Sul, 2003-08-31 at 17:16, Petr Baudis wrote:
> > >   Hello,
> > >
> > >   when upgrading from 2.4.20 to 2.4.22, I hit a strange problem - the
> > > machine mysteriously freezed (totally, interrupts blocked) in few seconds
> > > when I tried to do anything with the soundcard. It turned out to be a DMA
> > > conflict between soundcard and disk, since it disappears when I disable
> > > the (now defaultly on) DMA-by-default IDE option.
> >
> > Sound and IDE work together on my MVP3 board. Maybe your hardware is
> > just broken.
> 
> Or maybe sound driver is doing some funny things (?).

sb: ESS ES1869 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, irq 10, dma 1, 3
SB 3.01 detected OK (220)
ESS chip ES1869 detected
<ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 10 dma 1,3
sb: 1 Soundblaster PnP card(s) found.

...worked just fine in the past. Oh and under 2.6.0-test I was using ALSA.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
