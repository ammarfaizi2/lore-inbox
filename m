Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUCXASk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUCXASk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:18:40 -0500
Received: from gprs214-3.eurotel.cz ([160.218.214.3]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262933AbUCXASi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:18:38 -0500
Date: Wed, 24 Mar 2004 01:18:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org,
       Micha? Roszka <michal@roszka.pl>
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
Message-ID: <20040324001828.GB238@elf.ucw.cz>
References: <200403180821.44199.michal@roszka.pl> <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it> <20040318112057.GC3686@ibrium.se> <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it> <20040318120311.GD3686@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318120311.GD3686@ibrium.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Btw, I would like to get reports about how well this driver works
> > > with respect to noise reduction. I'm in particular interested
> > > in the dual 1.4 GHz model...
> > 
> > The author has a dual-1.2 and I tested it on another dual-1.2. I don't
> > know if it has been tested on other mathines. The driver writes in
> > the system logs the temperature and the fan speed every time they change,
> > so you can check what it's doing (and you can unload the module if you
> > see it does something wrong).
> 
> Yes I know... I wrote it :-)
> 
> It should be perfectly safe to use. It contains a (very conservative)
> fail safe; if the temperature exceeds the working point by a few
> degrees, the hardware overheat protection is programmed to turn
> on the fans 100%. This works even if the kernel has locked up
> solidly.

Is it actually possible to set that hardware to self-destruct?

[ACPI notebooks have very simple hardware failsafe: if temperature
exceeds some hard limit, power is simply cut.]
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
