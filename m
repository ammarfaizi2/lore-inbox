Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTGWMPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTGWMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:15:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12553 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270227AbTGWMPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:15:09 -0400
Date: Wed, 23 Jul 2003 14:30:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: textshell@neutronstar.dyndns.org, Dominik Brodowski <linux@brodo.de>,
       davej@suse.de, Linux kernel <linux-kernel@vger.kernel.org>,
       Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030723123014.GB18878@atrey.karlin.mff.cuni.cz>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de> <20030722141839.GD7517@neutronstar.dyndns.org> <20030722142353.GA1301@brodo.de> <20030722145352.GE7517@neutronstar.dyndns.org> <20030723111320.GB729@zaurus.ucw.cz> <Pine.LNX.4.53.0307230720190.8208@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307230720190.8208@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 				Pavel
> > Hardware that lets software kill it deserved that.
> 
> Don't touch the Motorola 56xxx DSP, then. There are several
> "insane instructions" that will smoke the device (programming
> a pin for both input and output at the same time). There are

Well, if motorola was so stupid that you can kill it by mistake... I
don't want to touch _that_.

> Also, the bits for setting the power supply voltages to be
> applied to your CPU are available in I/O space on many motherboards.
> Try your 2.5 volt CPU on 5.0 volts. It will melt the solder that
> holds the socket to the board!

On mainboards I saw it was in 'reasonable' range. I trust it not to
melt cpu before thermal diode does its job.

AMD's PowerNow at least will not let you overclock and/or
overvoltage. You are free to undervoltage, but that's crash-only.

Its true that HP Omnibook xe3 probably can be damaged, provided that
its CPU fan fails and there's just enough airflow to keep thermal
protection from kicking in. Its harddrive overheats in such case.
I guess that's uncommon enough.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
