Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWG2XgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWG2XgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWG2XgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:36:02 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:49650 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750777AbWG2XgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:36:00 -0400
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
In-Reply-To: <20060729225138.GA22390@gnuppy.monkey.org>
References: <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <1153861094.1230.20.camel@localhost.localdomain>
	 <44C6875F.4090300@zytor.com>
	 <1153862087.1230.38.camel@localhost.localdomain>
	 <44C68AA8.6080702@zytor.com>
	 <1153863542.1230.41.camel@localhost.localdomain>
	 <20060729042820.GA16133@gnuppy.monkey.org>
	 <20060729125427.GA6669@localhost.localdomain>
	 <20060729204107.GA20890@gnuppy.monkey.org>
	 <20060729234948.0768dbf4.froese@gmx.de>
	 <20060729225138.GA22390@gnuppy.monkey.org>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 16:35:51 -0700
Message-Id: <1154216151.2467.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 15:51 -0700, Bill Huey wrote:
> On Sat, Jul 29, 2006 at 11:49:48PM +0200, Edgar Toernig wrote:
> > Bill Huey (hui) wrote:
> > > Well, this points out a serious problem with doing an mmap extension to
> > > /dev/rtc. It would be better to have a page mapped by another device like
> > > /dev/jiffy_counter, or something like that rather than to overload the
> > > /dev/rtc with that functionality.
> > 
> > You mean something like this, /dev/itimer?
> > 
> >     http://marc.theaimsgroup.com/?m=115412412427996
> 
> [CCing Steve and Ingo on this thread]
> 
> It's a different topic than what Keith needs, but this is useful for another
> set of purposes. It's something that's really useful in the RT patch since
> there isn't a decent API to get at high resolution timers in userspace. What
> you've written is something that I articulated to Steve Rostedt over a dinner
> at OLS and is badly needed in the -rt patches IMO. I suggest targeting that
> for some kind of inclusion to Ingo Molnar's patchset.
> 

Do you mind summarizing what's wrong with the existing interfaces for
those of us who didn't have the opportunity to join you for dinner at
OLS?

-- 
Nicholas Miell <nmiell@comcast.net>

