Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbSI1PhH>; Sat, 28 Sep 2002 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262011AbSI1PhH>; Sat, 28 Sep 2002 11:37:07 -0400
Received: from 62-190-217-152.pdu.pipex.net ([62.190.217.152]:60678 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261960AbSI1PhG>; Sat, 28 Sep 2002 11:37:06 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209281550.g8SFoeXx001215@darkstar.example.net>
Subject: Re: Framebuffer still "EXPERIMENTAL"?
To: ken@kenmoffat.uklinux.net (Ken Moffat)
Date: Sat, 28 Sep 2002 16:50:40 +0100 (BST)
Cc: pommnitz@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0209281558290.3427-100000@ppg_penguin.linux.bogus> from "Ken Moffat" at Sep 28, 2002 04:02:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Hello Listees,
> > > yesterday I compiled 2.5.38 for the first time and noticed that the
> > > framebuffer option is still marked "EXPERIMENTAL". Well, I know for sure
> > > that I used the VESA-FB 3 years ago to get X running on a strange laptop
> > > graphic chip, so it is at least that long available (actually I think it
> > > got introduced for the Sparc port somewhen in 1995??). 
> > > 
> > > I think it's about time to promote the framebuffer code to a full fledged
> > > kernel feature. Comments?
> > 
> > I've noticed a bug with it, but haven't had time to investigate more fully,
> > infact it might not be a kernel bug, but I suspect that it is.  I don't
> > usually use the framebuffer, (I prefer the standard text mode).
> > 
> > On a standard Slackware 8.1 install, (kernel 2.4.18), on a machine with an
> > ATI graphics card, and with the framebuffer enabled, if you type clear, then
> > fill the screen with text so that it scrolls, (e.g. do a find /), the top
> > four lines where the penguin used to be do not scroll, they just keep the
> > text that is originally put there.  If you press shift-pageup, and then
> > shift-pagedown, it fixes it.
> > 
> > If anybody has got the time to look in to this, I'll post more details.
> > 
> > John.
> 
> Normal operation. Either switch to a different tty, or set a font.

Hmmm, if that's normal operation, surely it's a bug?

Infact, why not use the wasted space to the right of the penguin for something useful - I.E. a status line, like on old terminals, showing disk and serial port activity!?

> There does seem to be a bug in your mailer, though (excessive line
> length) :->

I guess maybe it's time for me to move away from using 'mail' from the command line for my day to day E-Mail needs :-(.  Already, I have to use elm when I need the quoting capabilities so lacking from my favourite mailer :-).

John.
