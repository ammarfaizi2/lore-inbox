Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTKAVEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTKAVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 16:04:11 -0500
Received: from smtp7.hy.skanova.net ([195.67.199.140]:53955 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263447AbTKAVEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 16:04:07 -0500
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics losing sync
References: <200311011751.39610.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Nov 2003 22:04:02 +0100
In-Reply-To: <200311011751.39610.gallir@uib.es>
Message-ID: <m2k76jssvx.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> I've sent this report before. 
> 
> I repeat it just in case someone found a workaround, and because 
> 2.6.0-test9 gives other related errors as well (TSC error):
> 
> ...
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 4th byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver resynced.
> Losing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.
> Synaptics driver lost sync at 1st byte
> ...
> 
> The laptop is a Dell X200 with APM and cpufreq enabled, and IO-apic 
> disabled.
> 
> I tested with and w/o preemptive kernel and cpufreq with the same results. 

Did you try without APM? My laptop loses many clock ticks if I enable
APM. It works fine with ACPI though.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
