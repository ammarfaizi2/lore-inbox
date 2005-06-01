Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFAW6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFAW6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFAW6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:58:23 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:28433 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261276AbVFAW6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:58:16 -0400
Date: Wed, 1 Jun 2005 16:02:44 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601230244.GA11262@nietzsche.lynx.com>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <20050601214257.GA28196@nietzsche.lynx.com> <20050601215913.GB28196@nietzsche.lynx.com> <20050601223250.GH5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601223250.GH5413@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 12:32:50AM +0200, Andrea Arcangeli wrote:
> Do you worry about "less work" after all this new stuff added? I'd
> understand "less work" for a simple and safe solution like rtlinux/RTAI,
> but going down your path, isn't looking for "less work" or "simpler".

This has already been discussed earlier in this thread.
 
> The advantage you get with preempt-RT is a chance to run syscalls with
> higher prio by sharing the same syscall code of the non-RT case, but
> it'd be little advantage if you then have to lose in reliability.

This is not the purpose of the patch, nor will it ever be. RT apps don't
depend on this property as was previously mentioned in this thread.
 
> The argument that only a subset of drivers is used isn't very valid,

It's being done. It's works and it's valid.

> people will just assume it to be hard-RT and they could build hardware
> with random drivers thinking that they will get the gurantee. I
> understand it's ok with you since you're able to evaluate the RT-safety
> of every driver you use, but I sure prefer "ruby hard" solutions that
> don't require looking into drivers to see if they're RT-safe.

Again, this has been covered previously by this thread. It's ultimately
about writing RT apps that have a more sophisticated use that RTAI or
RT Linux.

bill

