Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945970AbWANBnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945970AbWANBnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWANBnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:43:25 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:65517 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945970AbWANBnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:43:24 -0500
Date: Fri, 13 Jan 2006 20:43:07 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: john stultz <johnstul@us.ibm.com>
cc: Lee Revell <rlrevell@joe-job.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137202773.11300.37.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0601132042050.7584@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com> 
 <1137168254.7241.32.camel@localhost.localdomain>  <1137174463.15108.4.camel@mindpipe>
  <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com> 
 <1137174848.15108.11.camel@mindpipe>  <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
  <1137178506.15108.38.camel@mindpipe>  <1137182991.8283.7.camel@localhost.localdomain>
  <1137198221.11300.21.camel@cog.beaverton.ibm.com> 
 <1137201012.6727.1.camel@localhost.localdomain>  <1137201250.1408.39.camel@mindpipe>
  <1137201821.11300.30.camel@cog.beaverton.ibm.com>  <1137202039.1408.42.camel@mindpipe>
 <1137202773.11300.37.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006, john stultz wrote:

>
> This is as I understand it:
>
> With 2.6.15 on x86-64:
> 	If available, alternate timesources (HPET, ACPI PM) will be used if
> available on AMD SMP systems. (clock= is i386 only)

Hmm, should I boot without the clock= to prove this?

-- Steve

>
> With 2.6.15 on i386:
> 	If CONFIG_X86_PM_TIMER is enabled, and available it is the preferred
> clocksource over the TSC.  Some distros have changed this priority
> causing the TSC to be preferred. In these cases clock=pmtmr is needed.
>
> How's that?
> -john
>
>
>
