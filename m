Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSFWGfK>; Sun, 23 Jun 2002 02:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSFWGfJ>; Sun, 23 Jun 2002 02:35:09 -0400
Received: from holomorphy.com ([66.224.33.161]:19655 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316978AbSFWGfJ>;
	Sun, 23 Jun 2002 02:35:09 -0400
Date: Sat, 22 Jun 2002 23:34:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020623063432.GI22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com> <m1lm97rx16.fsf@frodo.biederman.org> <20020622122656.W23670@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020622122656.W23670@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 12:26:56PM -0700, Larry McVoy wrote:
> Not as stupid as having a kernel noone can maintain and not being able
> to do anything about it.  There seems to be a subthread of elitist macho
> attitude along the lines of "oh, it won't be that bad, and besides,
> if you aren't good enough to code in a fine grained locked, soft real
> time, preempted, NUMA aware, then you just shouldn't be in the kernel".
> I'm not saying you are saying that, but I've definitely heard it on
> the list.  

I've been accused of this, so I'll state for the record: my views on
locking are not efficiency-related in the least. They have to do with
ensuring that locks protect well-defined data and that locking
constructs are clean (e.g. nonrecursive and no implicit drop or acquire).
My duties are not directly related to locking, and I only push the
agenda I do as a low-priority kernel janitoring effort. As this is not
a scalability issue, I'll not press it further in this thread.


Cheers,
Bill
