Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289735AbSBGUhE>; Thu, 7 Feb 2002 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291284AbSBGUgs>; Thu, 7 Feb 2002 15:36:48 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:29701 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289735AbSBGUgd>;
	Thu, 7 Feb 2002 15:36:33 -0500
Date: Thu, 7 Feb 2002 13:36:02 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207133602.C21935@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy> <20020207125853.B21354@hq.fsmlabs.com> <1013112523.9534.75.camel@phantasy> <20020207131550.A21935@hq.fsmlabs.com> <1013113285.11659.84.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1013113285.11659.84.camel@phantasy>; from rml@tech9.net on Thu, Feb 07, 2002 at 03:20:24PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 03:20:24PM -0500, Robert Love wrote:
> On Thu, 2002-02-07 at 15:15, yodaiken@fsmlabs.com wrote:
> 
> > I'd love to hear how things could be done right here. 
> > There seem to be 3 choices for reader writer locks
> 
> Assuming there is no
> 
> 	4. a solution that works
> 
> (and I do not assume that) we can just not do inheritance under

> reader-writer locks and that means they remain as spin locks.  Normal
> spin locks remain proper candidates.
> 
> I never mentioned anything about reader-writer locks in my original
> email.  Most of the long-held locks I am considering are not in this
> category anyway ...

I'm content to let it drop here, but I simply observe that you keep bringing
up the glorious future of inheritance without addressing any of the hard
problems. My contention is that the very capable Solaris engineers did not find the
(4) above because it does not exist.

> P.S. If this is going to turn into another priority-inheritance flame, I
> am stopping here.  Let's take it off-list or just drop it, please.  I'd
> much prefer to discuss the current combilock issue which is at hand. ;)

It's the same issue.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

