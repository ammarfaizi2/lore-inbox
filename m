Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSFURu4>; Fri, 21 Jun 2002 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFURuz>; Fri, 21 Jun 2002 13:50:55 -0400
Received: from bitmover.com ([192.132.92.2]:52189 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316705AbSFURuy>;
	Fri, 21 Jun 2002 13:50:54 -0400
Date: Fri, 21 Jun 2002 10:50:55 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020621105055.D13973@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1r8j1rwbp.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Jun 21, 2002 at 12:15:54AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:15:54AM -0600, Eric W. Biederman wrote:
> I think Larry's perspective is interesting and if the common cluster
> software gets working well enough I might even try it.  But until a
> big SMP becomes commodity I don't see the point.

The real point is that multi threading screws up your kernel.  All the Linux
hackers are going through the learning curve on threading and think I'm an
alarmist or a nut.  After Linux works on a 64 way box, I suspect that the
majority of them will secretly admit that threading does screw up the kernel
but at that point it's far too late.

The current approach is a lot like western medicine.  Wait until the
cancer shows up and then make an effort to get rid of it.  My suggested
approach is to take steps to make sure the cancer never gets here in
the first place.  It's proactive rather than reactive.  And the reason
I harp on this is that I'm positive (and history supports me 100%)
that the reactive approach doesn't work, you'll be stuck with it,
there is no way to "fix" it other than starting over with a new kernel.
Then we get to repeat this whole discussion in 15 years with one of the
Linux veterans trying to explain to the NewOS guys that multi threading
really isn't as cool as it sounds and they should try this other approach.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
