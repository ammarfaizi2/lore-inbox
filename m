Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbRGDOmE>; Wed, 4 Jul 2001 10:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265820AbRGDOly>; Wed, 4 Jul 2001 10:41:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38918 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265816AbRGDOll>; Wed, 4 Jul 2001 10:41:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: Ideas for TUX2
Date: Wed, 4 Jul 2001 16:31:00 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at> <3.0.6.32.20010704095314.009201b0@pop3.bmlv.gv.at>
In-Reply-To: <3.0.6.32.20010704095314.009201b0@pop3.bmlv.gv.at>
MIME-Version: 1.0
Message-Id: <01070416310004.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 July 2001 09:53, Ph. Marek wrote:
> >> Well, my point was, that with several thousand inodes spread over the
> >> disk it won't always be possible to update the inode AND the fbb in one
> >> go. So I proposed the 2nd inode with generation counter!
> >
> >The cool thing is, it *is* possible, read how here:
> >
> >  http://nl.linux.org/~phillips/tux2/phase.tree.tutorial.html
>
> Well, ok. Your split the inode "files" too.
>
> Hmmm...
> That sound more complex than my version (at least now, until I've seen the
> implementation - maybe it's easier because it has less special cases than
> mine).

Yes, it's more complex, but not horribly so.  It's a lot more efficient, and 
that's the point.

> And of course the memory usage on the harddisk is much less with your
> version as you split your inode data and don't have it duplicated.

Yep.

> Well, I hope to see an implementation soon - I'd like to help, even if it's
> only testing.

See you on the list.  By the way, if you want to help out right now, could 
you run some benchmarks my latest early flush patch?  See "[RFC] Early Flush 
with Bandwidth Estimation".

--
Daniel
