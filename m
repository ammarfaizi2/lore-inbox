Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWGaOFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWGaOFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWGaOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:05:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32494 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932310AbWGaOFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:05:40 -0400
Date: Mon, 31 Jul 2006 07:04:07 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
In-reply-to: <20060731055655.GB7094@irc.pl>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0607310701190.10584@montezuma.fsmlabs.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <20060730120844.GA18293@outpost.ds9a.nl>
 <20060730160738.GB13377@irc.pl>
 <Pine.LNX.4.64.0607301043070.7932@montezuma.fsmlabs.com>
 <20060731055655.GB7094@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Tomasz Torcz wrote:

> On Sun, Jul 30, 2006 at 10:45:13AM -0700, Zwane Mwaikambo wrote:
> 
> > CONFIG_X86_ACPI_CPUFREQ
> 
>   I had this one =y. After setting =n, cpufreq-nforce2 (=m) works again.
> 
> powernowd: PowerNow Daemon v0.96, (c) 2003-2005 John Clemens
> powernowd: Found 1 cpu:  -- 1 thread (or core) per physical cpu
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No
> such file or directory
> powernowd:   cpu0: 1228Mhz - 1753Mhz (7 steps)

Hi Tomasz,

	Could you also please test Bert's patch which propogates error 
return values with your previous configuration?

Thanks,
	Zwane
