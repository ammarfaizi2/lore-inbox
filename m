Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVIMUgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVIMUgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVIMUgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:36:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41413 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932395AbVIMUgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:36:51 -0400
Subject: Re: 2.6.13-rt6, ktimer subsystem
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
In-Reply-To: <20050913201004.GA32608@elte.hu>
References: <20050913100040.GA13103@elte.hu>
	 <1126641589.13893.52.camel@mindpipe>  <20050913201004.GA32608@elte.hu>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 16:36:49 -0400
Message-Id: <1126643809.13893.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 22:10 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2005-09-13 at 12:00 +0200, Ingo Molnar wrote:
> > > i have released the 2.6.13-rt6 tree, which can be downloaded from the 
> > > usual place:
> > > 
> > >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > 
> > Ingo,
> > 
> > Is this supposed to work on amd64?  Lots of people on linux-audio-user 
> > report that it just reboots immediately when booting the kernel.  I 
> > have the .configs if you want them.
> 
> it wont even build right now, due to the ktimer changes. I'll fix x64 up 
> once things have settled down a bit. (but if someone does patches i'll 
> sure apply them)

The problem apparently affected 2.6.13-rt4 too.  The users reported that
it built OK (as long as realtime preemption is enabled) but then reboots
as soon as grub loads the kernel.

Can this be worked around by disabling CONFIG_HIGH_RES_TIMERS?

Lee


