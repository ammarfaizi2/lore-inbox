Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJAP4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJAP4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVJAP4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:56:40 -0400
Received: from fsmlabs.com ([168.103.115.128]:6606 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750812AbVJAP4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:56:40 -0400
Date: Sat, 1 Oct 2005 09:02:43 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <433BDC11.7070407@anagramm.de>
Message-ID: <Pine.LNX.4.61.0509291243440.1684@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de> <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com>
 <433BDC11.7070407@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Clemens Koller wrote:

> Zwane Mwaikambo wrote:
> 
> It's reproducable... I got the same thing with a slightly different configured
> 2.6.13.2-npe (no preemtion, no acpi, no apm) but beside that, I got other
> very strange crashes (page table something thingys?) as well during a CRUX
> pkgmk
> tool to build i.e. samba. So I wasn't able to get the system stable enough for
> more serious testing yet.
> I am about to grab the latest linus' git tree and try that...
> 
> This system was running for a long time with linux without any problems
> in the past. But I had to change the hdd (old one was broken) and installed
> a new (CRUX) system from scratch... I migrated to 2.6.13.2 and switched over
> to udev... I was running memtest86 for about half a day. It didn't show any
> problems. Are there good torture tests to check if a system's hw is stable?

memtest and repeated multijob kernel/gcc builds seems to do a very good 
job. Let me know how the new kernel goes, i'm going to try and see if any 
of my systems can trigger it.

Thanks,
	Zwane

