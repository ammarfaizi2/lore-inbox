Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWG3CCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWG3CCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 22:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWG3CCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 22:02:14 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:34992 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751000AbWG3CCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 22:02:14 -0400
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc
	character driver)
From: Nicholas Miell <nmiell@comcast.net>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Edgar Toernig <froese@gmx.de>, Neil Horman <nhorman@tuxdriver.com>,
       Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20060730013936.GA23571@gnuppy.monkey.org>
References: <44C68AA8.6080702@zytor.com>
	 <1153863542.1230.41.camel@localhost.localdomain>
	 <20060729042820.GA16133@gnuppy.monkey.org>
	 <20060729125427.GA6669@localhost.localdomain>
	 <20060729204107.GA20890@gnuppy.monkey.org>
	 <20060729234948.0768dbf4.froese@gmx.de>
	 <20060729225138.GA22390@gnuppy.monkey.org>
	 <1154216151.2467.5.camel@entropy>
	 <20060730010020.GA23288@gnuppy.monkey.org>
	 <1154222579.2467.12.camel@entropy>
	 <20060730013936.GA23571@gnuppy.monkey.org>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 19:02:07 -0700
Message-Id: <1154224927.2467.14.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 18:39 -0700, Bill Huey wrote:
> On Sat, Jul 29, 2006 at 06:22:59PM -0700, Nicholas Miell wrote:
> > On Sat, 2006-07-29 at 18:00 -0700, Bill Huey wrote:
> > > Think edge triggered verse level triggered. Event interfaces in the Linux
> > > kernel are sort of just that, edge triggered events. What RT folks generally
> > > want is control over scheduling policies over a particular time period in
> > > relation to a scheduling policy. A general kernel event interface isn't
> >                 ^ Did you mean to say timer here?
> 
> No, I really ment scheduling.

OK, so what does control of a scheduling policy in relation to a
scheduling policy mean?

> > > going to cut it for those purpose and wasn't design to deal with those cases
> > > in the first place.
> > 
> > So you're asking for an automatic (perhaps temporary) change in
> > scheduling policy when a particular timer expires (or perhaps on
> > occurrence of other types of events)?
> 
> > I think Windows automatically boosts the priority of a thread when it
> > delivers an I/O completion notification, and I'm pretty sure that
> > Microsoft has a patent related to that.
> 
> Na, different problem altogether. It's better that'd shut up.
> 

I'm actually interested, and I imagine other people are too.

-- 
Nicholas Miell <nmiell@comcast.net>

