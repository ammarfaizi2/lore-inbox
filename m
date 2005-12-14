Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVLNU1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVLNU1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLNU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:27:04 -0500
Received: from mini.brewt.org ([216.18.5.212]:7953 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S964941AbVLNU1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:27:02 -0500
Date: Wed, 14 Dec 2005 12:27:00 -0800
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: Re: tsc clock issues with dual core and question about irq balancing
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1134592020.1228859.700367237899@brewt.org>
In-Reply-To: <1134591272.16294.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
References: <GMail.1134458797.49013860.4106109506@brewt.org>
 <1134522289.3897.21.camel@leatherman>
 <GMail.1134551267.12292355.45625751005@brewt.org>
 <1134591272.16294.3.camel@cog.beaverton.ibm.com>
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

> >>>From your dmesg, you're still running w/ smp, apic, acpi as well.
> I was curious if you could run just as you had before without issue
> using "nosmp noapic acpi=off clock=tsc", only drop the clock=tsc bit.
> 
> I just want to be sure we're only changing one variable at a time.
> :)

I also have a dmesg with those options that I can upload, but I'm not
completely sure about the validity of the sluggishness "tests" because
the system felt the same after I booted with the different
configurations this time around.  ssh seems fine right now, so I guess
my Internet just happened to go bad at the same time I started play with
my hardware and kernel configurations.

I think the only solid problem I've got here is the tsc ocassionally
counting back.  Is switching to clock=pmtmr the permanent/proper
solution for this, or is there a bug in the kernel/hardware that should
be fixable?  Thanks.

Adrian
