Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268938AbTGORja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbTGORie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:38:34 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:40861 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S268938AbTGORdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:33:46 -0400
Date: Tue, 15 Jul 2003 18:48:24 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: ian.soboroff@nist.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 - cpu_freg sysfs nodes?
Message-ID: <20030715174824.GA15505@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	ian.soboroff@nist.gov, linux-kernel@vger.kernel.org
References: <m34r1n3e93.fsf@euphrates.ncsl.nist.gov> <20030715164251.GA2623@inferi.kami.home> <m3d6gb1wp8.fsf@euphrates.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6gb1wp8.fsf@euphrates.ncsl.nist.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:17:23PM -0400, ian.soboroff@nist.gov wrote:
 > > find /sys -iname 'cpu*'
 > >
 > > /sys/firmware/acpi/namespace/ACPI/CPU0
 > > /sys/devices/system/cpu
 > > /sys/devices/system/cpu/cpu0
 > > /sys/devices/system/cpu/cpu0/cpufreq
 > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
 > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
 > 
 > If this is the right place to look, the Documentation/cpu-freq needs
 > some updating.

Already updated in the cpufreq tree. Going to be pushed in the
next day or so.

 > But this still isn't it...
 > 
 > # find /sys -iname 'cpu*'
 > /sys/devices/system/cpu
 > /sys/devices/system/cpu/cpu0

Hmm, for some reason the registration failed.
Are there any cpufreq messages at all in the boot logs ?

		Dave
