Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273277AbTG3TCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273289AbTG3TCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:02:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6921 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S273277AbTG3TCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:02:42 -0400
Date: Wed, 30 Jul 2003 21:02:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730190240.GN10276@atrey.karlin.mff.cuni.cz>
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk> <20030730174457.GI10276@atrey.karlin.mff.cuni.cz> <20030730185659.GA7260@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730185659.GA7260@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My construction of LED lights is extremely flaky, and I'm afraid of
> > burning printer port. At 486 days ports were expected to survive such
> > abuse. Not sure if todays EPP/wtf ports can handle that.
> 
> parport uses 5V (actually a little less) so if you
> use normal (not extra super duper bright) leds and
> put a 1kOhm resistor in front of each led, then it
> will drain 5mA per led, which gives a total of 40mA
> for eight leds (for example)
> 
> now for the parport: depending on the technology
> and the age of the circuit, it provides between
> 2 and 14mA output at >2.4V (the led usually requires
> less than 1.5V to operate) so this would be within
> the range ... but, if you want either extra brightness
> or extra security, you could provide +5V and use
> the outputlines as sink, which then is between
> 15 and 25mA ...
> 
> anyway, parport should be short circuit safe, so
> the worst what could happen is, that the leds are
> not working ;) ...

Really? Even for newer designs? I was afraid not to kill
southbridge...


> PS: I usually use 220Ohm and no external power ...

I used 330Ohm and no external power. 8leds were bright (those on data
pins), 4 dim (those on control pins). That was 486, through.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
