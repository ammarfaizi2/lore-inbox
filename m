Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTLJVcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTLJVcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:32:14 -0500
Received: from dyn-213-36-224-2.ppp.tiscali.fr ([213.36.224.2]:19460 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S263980AbTLJVcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:32:10 -0500
Date: Wed, 10 Dec 2003 22:31:58 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: ed.sweetman@wmich.edu, mru@kth.se, linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-Id: <20031210223158.7ecfc11a.witukind@nsbm.kicks-ass.org>
In-Reply-To: <3FD787AF.8080902@wmich.edu>
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com>
	<20031208233755.GC31370@kroah.com>
	<20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	<20031209075619.GA1698@kroah.com>
	<1070960433.869.77.camel@nomade>
	<20031209090815.GA2681@kroah.com>
	<buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<yw1xd6ayib3f.fsf@kth.se>
	<20031210202354.7a3c429a.witukind@nsbm.kicks-ass.org>
	<yw1xd6aw4ge3.fsf@kth.se>
	<20031210212209.7fce7dae.witukind@nsbm.kicks-ass.org>
	<3FD78645.9090300@wmich.edu>
	<3FD787AF.8080902@wmich.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 15:53:03 -0500
Ed Sweetman <ed.sweetman@wmich.edu> wrote:

> Ed Sweetman wrote:
> > Witukind wrote:
> > 
> >> On Wed, 10 Dec 2003 20:33:24 +0100
> >> mru@kth.se (Måns Rullgård) wrote:
> >>
> >>
> >>> Witukind <witukind@nsbm.kicks-ass.org> writes:
> >>>
> >>>
> >>>> On Tue, 09 Dec 2003 10:39:32 +0100 mru@kth.se (Måns Rullgård)
> >wrote:>>>
> >>>>
> >>>>>> Is there a specific case for which people want this feature?
> >>>>>> Offhand it seems like a slightly odd thing to ask for...
> >>>>>
> >>>>>
> >>>>> I believe the original motivation for module autoloading was to
> >>>>
> >>>>
> >>>> save> memory by unloading modules when their devices were unused.
> >
> >>>> Loading> them automatically on demand made for less trouble for
> >>>> users, who> didn't have to run modprobe manually to use the sound
> >>>> card, or> whatever.  This could still be a good thing in embedded
> >>>> systems.>
> > 
> > the biggest advantage from modules is the ability to enable/disable 
> > devices with different initialization configurations without
> > rebooting, including the use of devices that aren't present during
> > boot or may be added to a system that cant be put down to reboot.
> > Embedded systems usually do not change, that's just part of being
> > embedded, modules dont really make sense there unless things like
> > filesystems and non-device modules never get used at the same time
> > and memory is limited such that 100KB actually matters.
> > 
> > 
> >>>> I don't see why it wouldn't be a good thing for regular systems
> >>>> also. Saving memory is usually a good idea.
> > 
> > 
> > True, but how about we start being good memory users where it counts
> > the most, like gui's/userspace land and then worry about the sub 1MB
> > usage that kernels exist in.
> > 
> >>> The biggest modules are about 100k.  Saving 100k of 1 GB doesn't
> >>> really seem worth any effort.
> >>
> >>
> >>
> >> I don't have 1 Gb of memory. On my laptop with 16 mb RAM saving
> >100k > is worth
> >> the effort.
> > 
> 
> Blah, scratch this.
> > Then why do you use a sylpheed, which is gtk instead of something in
> > a terminal that uses much less memory (doesn't require xfree86,
> > which you're probably also using instead of tinyX) and toolkits,
> > pixmaps etc. 
> >   Obviously, 100k is not worth _your_ effort.
> 
> And of course that's all assuming you're using your laptop to write
> and send email.  Which you probably wouldn't be doing on a 16MB 
> laptop...probably wouldn't be doing anything on a 16MB laptop.  But 
> anyway, the rest of what i was talking about is ok.

Well you can do a lot of things on this laptop and Wingdows 95, although I'd
prefer to be able to do as much or even more using Linux with it.


-- 
Jabber: heimdal@jabber.org
