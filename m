Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUIEESJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUIEESJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 00:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUIEESI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 00:18:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27786 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266193AbUIEESE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 00:18:04 -0400
Date: Sat, 4 Sep 2004 21:17:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040904211749.3f713a8a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org>
	<20040831183655.58d784a3.pj@sgi.com>
	<20040904133701.GE33964@muc.de>
	<20040904171417.67649169.pj@sgi.com>
	<Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
	<20040904180548.2dcdd488.pj@sgi.com>
	<Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
	<20040904204850.48b7cfbd.pj@sgi.com>
	<Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Take a toke, man.

Ahh ... much better ... thanks.

> Well, that's so much slower and not any more obvious than just doing the 
> iterative few system calls that I don't really see the point other than 

Perhaps no more obvious to you, but if you had to see the confusion
I'm seeing over on user side, this /proc/sys/kernel/sizeof_cpumask
might be a win.

But if you want to take the position that it's not the kernels job
to keep the users head screwed on straight, I won't argue.

Besides, when you wrote "I don't know how to sanely expose the damn
things", I instinctively took that as a challenge to present a way.

==

I still like the position I thought you took for a moment there, of
tightening, not loosening, the preconditions on setaffinity, starting
with backing out the changes made to it this week.

Are you still thinking of doing that, or would you rather just let this
dog go back to sleep, as it lies now?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
