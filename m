Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423243AbWANBOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423243AbWANBOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWANBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:14:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24499 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1423243AbWANBOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:14:18 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137201012.6727.1.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137198221.11300.21.camel@cog.beaverton.ibm.com>
	 <1137201012.6727.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 20:14:09 -0500
Message-Id: <1137201250.1408.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 20:10 -0500, Steven Rostedt wrote:
> 
> Thanks, I'll add that to my list of tests too.
> 
> Oh and 2.6.15 passed as well (with clock=pmtmr) 

It really seems like it would fail if you gave it enough time due to the
rdtsc in monotonic_clock()...

Lee

