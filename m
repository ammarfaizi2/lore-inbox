Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVBSUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVBSUwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVBSUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:50:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7862 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261805AbVBSUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:50:38 -0500
Date: Sat, 19 Feb 2005 21:29:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Oliver Neukum <oliver@neukum.org>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050219202903.GB475@openzaurus.ucw.cz>
References: <047401c515bb_437b5130_0f01a8c0@max> <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz> <200502182158.34910.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502182158.34910.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The question is how to unify it.
> > > 
> > > Using power.c to simply pass power/sleep keys to the ACPI event pipe
> > > could get the input subsystem out of the loop at least. Maybe we could
> > > even pass sound keys to it. 
> > 
> > I do not think passing sound keys through acpi is good idea. acpid
> > does not know how to handle them, and X already know how to get them
> > from input subsystem.
> 
> What X? I am not saying that sound events should go through acpid, but
> why bringing X here? One may not even run X...

True, but X is big "existing user", thats why I mentioned it.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

