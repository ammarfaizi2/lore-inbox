Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130371AbQLPW00>; Sat, 16 Dec 2000 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQLPW0L>; Sat, 16 Dec 2000 17:26:11 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130320AbQLPWZs>;
	Sat, 16 Dec 2000 17:25:48 -0500
Message-ID: <20001215235700.I9506@bug.ucw.cz>
Date: Fri, 15 Dec 2000 23:57:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@wirex.com>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <3A3623C6.B2499D4D@haque.net> <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net> <20001212083812.A9287@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001212083812.A9287@wirex.com>; from Greg KH on Tue, Dec 12, 2000 at 08:38:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Someone gave me a really awesome idea about possibly using a palm pilot
> > to capture the oops. Anyone know if it will be a problem using
> > /dev/ttyUSB0 as the serial port?
> > 
> > Baiscally if I want to duplicate the environment in which I'm getting
> > the oops, I need to be dialed out. That takes out COM1. I never gt my
> > COM2 to work (can't figure out what's wrong. doesn't work under windows
> > either). So that's out. I have a Keyspan USB PDA adapter that I use for
> > my Palm Vx which shows up as /dev/ttyUSB0.
> > 
> > I guess if usb serial can't be used I'll try duplicating the oops w/o
> > being dialed out.
> 
> I don't know if /dev/ttyUSBX would work, but I think it would.  People
> have successfully run consoles through the usb-serial drivers, but I'm
> not sure if the oops main console requires something different (like
> registering itself actually as a console?)

No, you can't put kernel console on usb. Kernel console has to work
irq-less.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
