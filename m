Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbTBYS7h>; Tue, 25 Feb 2003 13:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBYS7h>; Tue, 25 Feb 2003 13:59:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12562 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265680AbTBYS7f>; Tue, 25 Feb 2003 13:59:35 -0500
Date: Tue, 25 Feb 2003 20:09:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: cpufreq@www.linux.org.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
Message-ID: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz>
References: <20030224225545.GA16991@elf.ucw.cz> <20030225004126.GA2477@brodo.de> <20030225180311.GI12028@atrey.karlin.mff.cuni.cz> <20030225182414.GA3242@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225182414.GA3242@brodo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But I agree that hacking proc_intf is not the right thing to do. I did
> > not see that sysfs access. Where is it?
> 
> kernel/cpufreq.c

Okay, I see.

> > > - selecting the voltage manually is something which is only valid for some
> > >   very few drivers - so let's only export one sysfs file[*] for these
> > >   drivers.
> > 
> > Very few drivers? It should be common for at least Intel and AMD, no?
> No. Intel doesn't let you select the exact voltage. IIRC, only vew 
> VIA/Cyrix-longhaul-capable processors and, of course, powernow-k7 are vaild
> targets for such a patch.

So I guess adding /sys/bus/system/devices/cpu0/voltage? Should code to
do that be in kernel/cpufreq.c or is it possible to do sysfs from
powernow-k7 [it does not seem easy]?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
