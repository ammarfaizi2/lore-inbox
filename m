Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUEPNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUEPNTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEPNTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 09:19:20 -0400
Received: from wingding.demon.nl ([82.161.27.36]:40321 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S263605AbUEPNTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 09:19:18 -0400
Date: Sun, 16 May 2004 15:20:20 +0200
From: Rutger Nijlunsing <rutger.nijlunsing@nospam.com>
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040516132020.GA14608@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20040513173946.GA8238@dominikbrodowski.de> <20040514214751.GA8433@nospam.com> <20040515064434.GB8572@dominikbrodowski.de> <20040515105200.GA8095@nospam.com> <20040515194124.GA8212@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515194124.GA8212@dominikbrodowski.de>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The only thing I could find in Intel's documentation is the max. time
> > of throttling is 3 microseconds (p.67; 5.2.1 of Prescott
> > datasheet). So this 3 microseconds should correspond to 5600 ticks or
> > so...
> 
> Can't find it in the datasheets right now, but did find an interesting
> comment in section 13.15.3 of 24547212.pdf which explains the strange
> behaviour we're seeing.

Hm, 13.16.3 in my version, but indeed: all logical processors should
be put asleep in the same way ;)

> 
> > I know this is not P4 specific, but motherboard specific, but do
> > you know of modules which use motherboard specific knowledge to scale
> > the processor?
> No.
> > If the BIOS can do it, so should we be able to do it.
> 
> Dynamic frequency scaling is (probably) way different from setting a
> frequency at boot (which is what the BIOS does). Timing issues, settling
> times, etc. are way too complicated, AFAICS. Even trying to do this might
> result in severe non-recoverable hardware failures.

Probably true for some motherboards, but Asus got a WinXP program
called 'AiBooster' which is a program to under/overclock from -50% to
+33% runtime (butt-ugly UI can be seen in
http://www.asuscom.de/pub/ASUS/mb/sock478/p4p800/AIBooster_u.pdf). Could
Wine be used (given the right permissions) to run or disect such a
utility to make underclocking reality under Linux?

*hopeful* Or has Asus released the specification of its motherboard?

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
