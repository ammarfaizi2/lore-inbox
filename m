Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWATTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWATTXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWATTXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:23:11 -0500
Received: from [63.81.120.158] ([63.81.120.158]:30446 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1751041AbWATTXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:23:09 -0500
Subject: Re: BUG in check_monotonic_clock()
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: george@wildturkeyranch.net, mingo@elte.hu, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
In-Reply-To: <1137784177.27699.260.camel@cog.beaverton.ibm.com>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>
	 <1137782896.3202.9.camel@localhost.localdomain>
	 <1137783149.27699.256.camel@cog.beaverton.ibm.com>
	 <1137783751.3202.11.camel@localhost.localdomain>
	 <1137784177.27699.260.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 11:23:07 -0800
Message-Id: <1137784987.3202.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 11:09 -0800, john stultz wrote:

> That's what I was guessing. So there aren't any TSC inconsistency
> messages in the dmesg? Odd.

I didn't see any ..

> 
> > Isn't there a handy proc entry for this? 
> 
> Yep, there's a sysfs entry:
> 
> 	/sys/devices/system/clocksource/clocksource0/current_clocksource 

Great! The patch that George sent me fixed it .. Thanks George !

Daniel

