Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTGVMIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTGVMIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:08:20 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:14817 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270803AbTGVMIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:08:19 -0400
Date: Tue, 22 Jul 2003 14:08:11 +0200
From: Dominik Brodowski <linux@brodo.de>
To: textshell@neutronstar.dyndns.org
Cc: linux-kernel@vger.kernel.org, Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030722120811.GD1160@brodo.de>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720211246.GK2331@neutronstar.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried your config (with just one change, i enabled reiserfs, i use it for my
> root fs) but It's the same. /sys/devices/system/cpu/cpu0/ is just empty, no
> change.
> 
> I tried with gcc 2.95.4 (as shipped with debian testing) and gcc 3.3.1 (same)
> but neither solved to problem.
> What else could be the Problem? I assume problems loading modules or such
> userspace problems can't cause this behaviour?
> 
> Any help diagnosing the problem appricatied,
> 
> Martin H.

What's the output [if any] in "dmesg" starting with either "cpufreq" or
"powernow"?

I guess it's yet another BIOS problem... [as seen quite often wrt AMD
PowerNow, unfortunately]

	Dominik
