Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbTGTUuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbTGTUuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:50:13 -0400
Received: from p508EBE9D.dip.t-dialin.net ([80.142.190.157]:58263 "HELO
	neutronstar.dyndns.org") by vger.kernel.org with SMTP
	id S268415AbTGTUuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:50:08 -0400
Date: Sun, 20 Jul 2003 23:12:46 +0200
From: textshell@neutronstar.dyndns.org
To: linux-kernel@vger.kernel.org
Cc: Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030720211246.GK2331@neutronstar.dyndns.org>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307201745.h6KHjcHt095999@sirius.nix.badanka.com>
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please CC your replies, because i'm not subscribed]

On Sun, Jul 20, 2003 at 07:45:37PM +0200, Henrik Persson wrote:
> On Sun, 20 Jul 2003 17:02:43 +0200
> textshell@neutronstar.dyndns.org wrote:
> 
> > [please CC your replies, because i'm not subscribed]
> > 
> > I'm testing 2.6.0-test1 on my HP nx9005 Laptop (using a Mobile AMD
> > Athlon XP)
> > 
> > But i can't get the sysfs interface of CPUFreq part to show up. I then
> > recomplied the kernel with both old (obsolete) /proc interfaces enabled.
> > The old interfaces both show up, but seem to be not working (but the is
> > my first try to get CPUFreq working with any kernel version). I googled
> > around for hours without finding any useful information for this case.
> 
> My .config attached.. Hope that will help you..
> 
> With this setup I have /sys/devices/system/cpu/cpu0/cpufreq/ and it's all
> working perfectly. I am also using a Mobile AMD Athlon XP.
> 

I tried your config (with just one change, i enabled reiserfs, i use it for my
root fs) but It's the same. /sys/devices/system/cpu/cpu0/ is just empty, no
change.

I tried with gcc 2.95.4 (as shipped with debian testing) and gcc 3.3.1 (same)
but neither solved to problem.
What else could be the Problem? I assume problems loading modules or such
userspace problems can't cause this behaviour?

Any help diagnosing the problem appricatied,

Martin H.
