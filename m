Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCCWyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUCCWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:54:20 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:32306 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261220AbUCCWyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:54:18 -0500
Date: Wed, 3 Mar 2004 23:54:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303225405.GF222@elf.ucw.cz>
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303224841.GB16874@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > We could make that functionality depend on CONFIG_ACPI, and allow
>  > runtime selection only if its defined... But those two drivers are
>  > pretty different just now and acpi-dependend chunk is pretty big. (It
>  > does funny stuff like polling for AC plug removal if we are in
>  > high-power state  and battery would not handle that. Old driver simply
>  > refused to use high-power states on such machines.)
> 
> you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this
> area right ? We'll need that anyway for Powernow-k7 and maybe longhaul too
> and its senseless duplicating this code.

That [1] looks like promise of url, but I don't see that url.

> One thing is bugging me though. Whats wrong with the ACPI P-state cpufreq
> driver ? Does that not work these days ? It's been a long time since I
> even looked at it.

No idea.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
