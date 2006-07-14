Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945903AbWGNXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWGNXVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945904AbWGNXVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:21:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945903AbWGNXVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:21:39 -0400
Date: Fri, 14 Jul 2006 10:09:52 -0400
From: Dave Jones <davej@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 18rc1 soft lockup
Message-ID: <20060714140952.GD667@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	john stultz <johnstul@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060711190346.GK5362@redhat.com> <1152645227.760.9.camel@cog.beaverton.ibm.com> <20060711191658.GM5362@redhat.com> <20060713220722.GA3371@redhat.com> <1152828943.6845.107.camel@localhost> <20060713222830.GC3371@redhat.com> <Pine.LNX.4.64.0607141121450.12900@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607141121450.12900@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 11:22:47AM +0200, Roman Zippel wrote:
 > Hi,
 > 
 > On Thu, 13 Jul 2006, Dave Jones wrote:
 > 
 > > On Thu, Jul 13, 2006 at 03:15:43PM -0700, john stultz wrote:
 > > 
 > >  > > Just when I thought it had gotten fixed..
 > >  > > 2.6.18rc1-git6 this time on x86-64..
 > >  > > 
 > >  > > BUG: soft lockup detected on CPU#3!
 > >  > > 
 > >  > > Call Trace:
 > >  > >  [<ffffffff80270865>] show_trace+0xaa/0x23d
 > >  > >  [<ffffffff80270a0d>] dump_stack+0x15/0x17
 > >  > >  [<ffffffff802c44e6>] softlockup_tick+0xd5/0xea
 > >  > >  [<ffffffff80250bea>] run_local_timers+0x13/0x15
 > >  > >  [<ffffffff8029cc1d>] update_process_times+0x4c/0x79
 > >  > >  [<ffffffff8027bfeb>] smp_local_timer_interrupt+0x2b/0x50
 > >  > >  [<ffffffff8027c766>] smp_apic_timer_interrupt+0x58/0x62
 > >  > >  [<ffffffff802628ae>] apic_timer_interrupt+0x6a/0x70
 > >  > 
 > >  > Hmmm.. grumble. Was this on bootup, or after some time period?
 > > 
 > > Right at the end of boot up, between the switch from runlevel 3 to 5.
 > 
 > When it waits, a SysRq+T might be useful.

it doesn't wait. this scrolls by within a split second.

		Dave

-- 
http://www.codemonkey.org.uk
