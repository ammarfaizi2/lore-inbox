Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293655AbSCPBpV>; Fri, 15 Mar 2002 20:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293657AbSCPBpL>; Fri, 15 Mar 2002 20:45:11 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33518
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293655AbSCPBpB>; Fri, 15 Mar 2002 20:45:01 -0500
Date: Fri, 15 Mar 2002 17:46:15 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: yodaiken@fsmlabs.com
Cc: Robert Love <rml@tech9.net>, Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
Message-ID: <20020316014615.GE363@matchmail.com>
Mail-Followup-To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <1016157250.4599.62.camel@phantasy> <3C91B2A1.48C74B82@ianduggan.net> <1016202310.908.1.camel@phantasy> <15506.7486.729120.64389@kim.it.uu.se> <1016219530.904.21.camel@phantasy> <20020315174036.A5068@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315174036.A5068@hq.fsmlabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 05:40:36PM -0700, yodaiken@fsmlabs.com wrote:
> On Fri, Mar 15, 2002 at 02:11:49PM -0500, Robert Love wrote:
> > If you "poke the processor", to be SMP-safe, you should hold a lock to
> > prevent multiple concurrent "pokings of the processor" - thus you become
> > preempt-safe.
> 
> Without preempt:
> 	x = movefrom processor register;
>         do_something with x
> 
> is safe in SMP
> With SMP it requires a lock.
>

"With preempt it requires a lock" you mean?
