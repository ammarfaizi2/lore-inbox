Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273292AbTG3TFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273295AbTG3TFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:05:31 -0400
Received: from www.13thfloor.at ([212.16.59.250]:34474 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S273292AbTG3TFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:05:18 -0400
Date: Wed, 30 Jul 2003 21:05:25 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730190525.GB7260@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marc Giger <gigerstyle@gmx.ch>,
	linux-kernel@vger.kernel.org
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk> <20030730174457.GI10276@atrey.karlin.mff.cuni.cz> <20030730205002.1e2a27bf.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030730205002.1e2a27bf.gigerstyle@gmx.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 08:50:02PM +0200, Marc Giger wrote:
> Hi All,
> 
> On Wed, 30 Jul 2003 19:44:57 +0200
> Pavel Machek <pavel@suse.cz> wrote:
> 
> > Hi!
> > 
> > > > But this kind of blinkenlights needed pretty fast LEDs. (At 486
> > > > time I decided that parport on ISA is fast enough..)
> > > 
> > > I'll buy some LEDs and build a parallel port connected LED panel
> > > tomorrow...  Do you think the overhead of driving the LEDs would
> > > have too much of a negative effect on system performance?  If so, or
> > > if we
> 
> Yesterday I connected 8 LED's to the parallelport datalines. Today I
> read this thread. What for a coincidence...
> The goal of this "project" was to show the current cpu load. It works
> great now! I can see randomly the LED's lightening up while I am writing
> this mail:-))
> 
> > 
> > I'm not sure. At 486 days I was pretty sure it did not matter. These
> > days you might get 10% slowdown on some microbenchmark, or something
> > like that. I do not think it can slow down common tasks.
> > 
> > My construction of LED lights is extremely flaky, and I'm afraid of
> > burning printer port. At 486 days ports were expected to survive such
> > abuse. Not sure if todays EPP/wtf ports can handle that.
> > 								Pavel
> 
> At beginning I had some fear to connect LEDS directly to the parport,
> because its an onboard controller (like the most mainboards have).
> I don't notice system performance slowdowns. (CPU Load code was borrowed
> from xosview:-))
> 
> My personal goal would be to controll a Dot-Matrix Display. The
> Display should show something like the actual CPU temperature,
> CPU-load, processes, s.m.a.r.t state, etc etc etc etc..........But my
> problem is how to beginn with that. I would prefer to controll it with a
> PCI card. Also I looked today at 68HC11 microcontrollers, which I can
> connect to the serial port and transmit the needed infos.

sounds interesting ...

> Are there suggestions / comments / questions?

http://www.ewal.net/lcd.php
http://patrick.wattle.id.au/cameron/information/lcd/

> If somebody is interested to develop such a card / controller with me, I
> will be pleased to hear from you!

I'm interested in discussions and willing to share my
knowledge (was working with embedded systems) on this
issue ... 

best,
Herbert

> Thank you
> 
> Marc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
