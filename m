Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbUDYUoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUDYUoC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUDYUoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:44:02 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:52611 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262981AbUDYUoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:44:00 -0400
Date: Sun, 25 Apr 2004 22:43:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Alexey Mahotkin <alexm@w-m.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: flooded by "CPU#0: Running in modulated clock mode"
Message-ID: <20040425204346.GF24375@elf.ucw.cz>
References: <8765btmd9n.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211355220.2250@montezuma.fsmlabs.com> <87y8opkxyo.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211411390.2250@montezuma.fsmlabs.com> <20040424110730.GB2595@openzaurus.ucw.cz> <Pine.LNX.4.58.0404250309080.3414@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404250309080.3414@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If i recall correctly it's hardware set, i'm not sure if BIOSes can modify
> > > that these days. One thing you may want to note is that in the modulated
> > > state the processor doesn't process interrupts and runs at a 50% clock
> >
> > No interrupts? That would mean almost dead machine.
> > Are you sure?
> 
> Yep, it's normally 50% modulation for 1ms or until the temperature drops
> below threshold, whichever comes first with interrupts remaining pending.

Ok, but that means (assuming machine is above treshold all the time)
that interrupts are only delayed by milisecond, and that machine does
no usefull work 50% of time, right?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
