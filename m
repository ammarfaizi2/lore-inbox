Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTLLXje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLLXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:39:34 -0500
Received: from gprs149-168.eurotel.cz ([160.218.149.168]:6531 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262674AbTLLXjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:39:32 -0500
Date: Sat, 13 Dec 2003 00:40:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212234028.GA541@elf.ucw.cz>
References: <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]> <20031212220853.GA314@elf.ucw.cz> <1071269849.4182.14.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071269849.4182.14.camel@idefix.homelinux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Every notebook from thinkpad 560X up has produced some kind of
> > cpu-load-related-noise. You'd have to throw out quite a lot of
> > notebooks...
> 
> You're right, I'm probably not the only one. It may be worth at least
> having an option to change HZ to less annoying values. Otherwise there
> are going to be lots of complaints when people try out 2.6 on their
> laptops and hear that noise. On mine, I seriously could not stand the
> noise more than 5 minutes. Not because it was that loud but 1 kHz is
> really annoying.

Okay, we are probably taking other sounds. I can hear cpu-load-related
noise on every notebook from thinkpad 560X -- in a quiet room, and on
some machines its rather hard to notice. You probably have way more
annoying problem.

> > PS: Jean, can you try how high you can get it? You might want to go to
> > 24kHz so that no human can hear it, or to 100kHz to be kind to
> > cats. At ~1MHz you'd be even kind to bats :-), but it is probably
> > impossible to get over 200kHz or so. Still it might be funny
> > experiment.
> 
> For now, my patch only allows up to around 10 kHz. At that frequency, I
> don't hear anything because the noise is not loud enough (ear is much
> more sensitive at 1 kHz). Also, I have around 10% overhead on my
> Pentium-M 1.6 GHz, so I guess it's not for everyone. Extrapolating from
> there, I'd also say that at 100 kHz, it wouldn't do anything but handle
> the interrupts, which is slightly annoying when you want to actually get
> some work done :)

I wonder what happens at 200kHz then; system might detect some lost
ticks and keep running at very slow speed...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
