Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVBSUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVBSUwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVBSUuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:50:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9654 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261808AbVBSUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:50:38 -0500
Date: Sat, 19 Feb 2005 21:31:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Oliver Neukum <oliver@neukum.org>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050219203120.GC475@openzaurus.ucw.cz>
References: <047401c515bb_437b5130_0f01a8c0@max> <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz> <200502182158.34910.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502182158.34910.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe power and suspend keys should definitely go through
> > input. I'm not that sure about battery... Lid is somewhere in
> > between...
> >
> 
> I think we need a generic way of delivering system status changes to
> userspace. Something like acpid but bigger than that, something not

Yes, we need something like that. But IMNSHO, it should not
handle power button. We already have perfectly good way of
handling power button through input.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

