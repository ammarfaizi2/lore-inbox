Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUAQCAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAQCAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:00:48 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:48541 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265974AbUAQCAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:00:45 -0500
Subject: Re: i2c_adapter i2c-0: Bus collision!
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Cc: sensors@stimpy.netroedge.com
In-Reply-To: <1073707567.621.5.camel@buick>
References: <1073527236.624.7.camel@buick>
	 <20040108230559.05a5674c.khali@linux-fr.org> <1073707567.621.5.camel@buick>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1074304828.780.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Jan 2004 03:00:29 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

sorry to bother you again, but this didn't tell you anything about
what's going on?

Best regards,
Stian

lør, 10.01.2004 kl. 05.06 skrev Stian Jordet:
> tor, 08.01.2004 kl. 23.05 skrev Jean Delvare: 
> > > i2c_adapter i2c-0: Bus collision! SMBus may be locked until next hard
> > > reset. (sorry!)
> > > 
> > > Kernel 2.6.0 with lm-sensors 2.8.2.
> > 
> > Are you able to reproduce the same behavior with kernel 2.4.24 and
> > lm-sensors 2.8.2?
> 
> Just tried, and I do. I forgot to mention it in my last mail, but I
> sometime has to reload the modules before "sensors" finds any sensor.
> 
> > > I get very weird results, especially on the fan, but others as well.
> > > Here are three runs of sensors:
> > > (...)
> > 
> > Could you provide a few outputs of "i2cdump 0 0x2d"? I wonder if this
> > will show read errors (as "XX") or simply changing values.
> 
> Attached three runs. Seems to be some read errors :( On these three runs I got
> first three bus-collisions, then one, and last two.
> 
> > Does your BIOS provide a feature such as "Circle Of Protection" or
> > anything that sounds like "active" hardware monitoring? Is it enabled?
> 
> No such option.
> 
> > If you have any other chips (eeproms for example) on the bus, do you
> > observe similar behavior with these?
> 
> Not other chips.
> 
> > > It works fine with MBM in Windows. Well, MBM is having some troubles
> > > with the temperature (it gets lower and lower as time pass, and ends
> > > on about 8-9 degrees celsius. But fan and temperatures are read just
> > > fine, never any glitch. On thing thing though, the Vcore2 is 1,70. The
> > > Bios reports it correctly, but both MBM and LM-sensors says 1,50. Have
> > > no idea why. The 1,50 is static, never changes, while VCore1 (which
> > > ideally should be 1,75) varies from 1,75 to 1,79. In the BIOS both
> > > seem sane, and varies with 3-4 degrees.
> > > 
> > > I guess all these problems are because of the bus collision, which I
> > > have read usually happens because of bad boards. Which I admit that I
> > > do have, but it works in Windows :(
> > 
> > Which motherboard is it?
> 
> A Rioworks SDVIA (http://www.rioworks.com/SDVIA.htm) Not very new, I'm afraid.
> And not very good.
> 
> > Did you have to enable any particular option in MBM?
> 
> Nah, it just worked :)
> 
> > > What are the most common reasons for the bus collisions (...)?
> > 
> > Bad brakes?
> > 
> > Just kidding... ;)
> 
> Hehe :)
> 
> I guess this is unsolvable, but I just wanted to hear what you say. Kinda weird
> it works so well with MBM, but that's ok. It's just for fun I want it to work.
> 
> Thanks for your reply :)
> 
> Best regards,
> Stian

