Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSIRPcY>; Wed, 18 Sep 2002 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSIRPcY>; Wed, 18 Sep 2002 11:32:24 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:63447 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267010AbSIRPcX>;
	Wed, 18 Sep 2002 11:32:23 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 09:35:24 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918093523.I14918@host110.fsmlabs.com>
References: <20020918090104.E14918@host110.fsmlabs.com> <Pine.LNX.4.44.0209181711350.22395-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209181711350.22395-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 18, 2002 at 05:33:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} of course, and it should also be massively-threaded, LSB-compliant,
} enterprise-ready, secure, cluster-aware, power-saving and self-healing. I
} admit that there's still lots of work to be done, but there's just so many
} hours in a day.

get_pid() is simple, I don't see why it's taking you so long to add those
features.  I'll sketch out a plan for an improvement in getpid_MARK02(c)
numbers once you have the prototype done.

} actually, on-the-fly O(log(N)) multiprocessor garbage collection is
} already integrated into its high-end modular OO design.
} 
} > Perhaps a get_pid() that solves the Turning Halting Problem should be on
} > the todo list for 2.6.

Given my misspelling of Turing, I think it's clear that get_pid() needs a
spellchecker.  This would be an opportunity to begin work on get_pid .NET.

} the first small mystery to solve are certain perturbations in Alan
} Turing's name. But, yes, it's definitely a goal of the PID allocator to be
} an answer to all, but also for it to avoid infinite loops for every
} possible input value, while yielding slightly more subtle output than the
} numeric value of 42. Patch in a few minutes.

Please be sure to implement a BK replacement, open-source it, switch the
kernel over to it and supply the patch in that format.  It would be
appreciated.
