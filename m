Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265825AbSKFQrr>; Wed, 6 Nov 2002 11:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSKFQrr>; Wed, 6 Nov 2002 11:47:47 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:17855 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265825AbSKFQrp>;
	Wed, 6 Nov 2002 11:47:45 -0500
Date: Wed, 6 Nov 2002 16:53:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: yet another update to the post-halloween doc.
Message-ID: <20021106165327.GA11290@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Robert Love <rml@tech9.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021106140844.GA5463@suse.de> <1036599481.3405.1080.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036599481.3405.1080.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 11:18:01AM -0500, Robert Love wrote:

 > One idea: how about covering new system calls?  We have the thread calls
 > Ingo did, the sched_[set|get]affinity calls, AIO, etc.

I've toyed with this idea, but wondered if perhaps a seperate
document would be a better idea. Ie, keep this one as a
end-users guide, and have a seperate programmers guide
covering things like API changes and the likes.
The latter would likely be more time consuming than the former,
we'll see how things go..
 
 > > - Note, there are still cases where preemption must be temporarily disabled
 > >   where we do not.  If you get "xxx exited with preempt count=n" messages
 > >   in syslog, don't panic, these are non fatal, but are somewhat unclean.
 > I just want to clarify that, in the second point, the "xxx exited with
 > preempt_count=n" message and not disabling preemption are two different
 > issues.

Good point, that was confusing. Cleaned up.
 
 > Not disabling preemption where needed is like an SMP race condition. 
 > There may be a some per-CPU data left that needs explicit protection but
 > hopefully not much.

Wasn't there also some issue in various drivers ? I believe Alan cited
the 8390 net driver as one example.
 
 > Just a note that the tree Rik and I are hacking on is the original and
 > not a fork.  It is the same tree mkj created and is in the official Red
 > Hat CVS repository.  It just has not had much activity lately and now it
 > has new blood :)
 > 
 > Albert's tree is a fork.

*sigh* politics. I changed that text after Albert mailed me complaining
about the original. Something tells me I'm not going to be able to
please both of you.  I'll mangle it again, and see which one of you
complains next time 8-)
 

All other suggestions added/changed/etc.

Thanks for the feedback

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
