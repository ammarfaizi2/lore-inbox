Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293661AbSCPDMT>; Fri, 15 Mar 2002 22:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293687AbSCPDMK>; Fri, 15 Mar 2002 22:12:10 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:25353 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293661AbSCPDL4>;
	Fri, 15 Mar 2002 22:11:56 -0500
Date: Fri, 15 Mar 2002 20:12:40 -0700
From: yodaiken@fsmlabs.com
To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
Message-ID: <20020315201240.A7368@hq.fsmlabs.com>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <1016157250.4599.62.camel@phantasy> <3C91B2A1.48C74B82@ianduggan.net> <1016202310.908.1.camel@phantasy> <15506.7486.729120.64389@kim.it.uu.se> <1016219530.904.21.camel@phantasy> <20020315174036.A5068@hq.fsmlabs.com> <20020316014615.GE363@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020316014615.GE363@matchmail.com>; from mfedyk@matchmail.com on Fri, Mar 15, 2002 at 05:46:15PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 05:46:15PM -0800, Mike Fedyk wrote:
> On Fri, Mar 15, 2002 at 05:40:36PM -0700, yodaiken@fsmlabs.com wrote:
> > On Fri, Mar 15, 2002 at 02:11:49PM -0500, Robert Love wrote:
> > > If you "poke the processor", to be SMP-safe, you should hold a lock to
> > > prevent multiple concurrent "pokings of the processor" - thus you become
> > > preempt-safe.
> > 
> > Without preempt:
> > 	x = movefrom processor register;
> >         do_something with x
> > 
> > is safe in SMP
> > With SMP it requires a lock.
> >
> 
> "With preempt it requires a lock" you mean?

Yep. Keyboard Operator error.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

