Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTA2Qoh>; Wed, 29 Jan 2003 11:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbTA2Qoh>; Wed, 29 Jan 2003 11:44:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266453AbTA2Qog>;
	Wed, 29 Jan 2003 11:44:36 -0500
Subject: Re: 2.5.59-dcl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73el6wyvz1.fsf@oldwotan.suse.de>
References: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
	 <1043798822.10150.318.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
	 <p73el6wyvz1.fsf@oldwotan.suse.de>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043859235.10150.322.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 29 Jan 2003 08:53:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 04:35, Andi Kleen wrote:
> Stephen Hemminger <shemminger@osdl.org> writes:
> 
> > > . Lockless gettimeofday                 (Andi Kleen, me)
> 
> The original algorithm actually came from Andrea Arcangeli,
> I just ported it from vsyscalls to do_gettimeofday.
> 
> > > . Performance monitoring counters for x86 (Mikael Pettersson)
> 
> Isn't that slightly redundant with oprofile?
> They have different capabilities, but there is still much overlap.

They are different.  My point was to have both and let the performance
team at OSDL try both, and comment on what works/doesn't work

