Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284297AbRLGSYa>; Fri, 7 Dec 2001 13:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284295AbRLGSY0>; Fri, 7 Dec 2001 13:24:26 -0500
Received: from bitmover.com ([192.132.92.2]:14481 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284302AbRLGSXU>;
	Fri, 7 Dec 2001 13:23:20 -0500
Date: Fri, 7 Dec 2001 10:23:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207102318.J27589@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>,
	Henning Schmiedehausen <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011207092314.F27589@work.bitmover.com> <2697104000.1007719451@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2697104000.1007719451@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Fri, Dec 07, 2001 at 10:04:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 10:04:11AM -0800, Martin J. Bligh wrote:
> > My pay job is developing a distributed source management system which works
> > by replication.  We already have users who put all the etc files in it and
> > manage them that way.  Works great.  It's like rdist except it never screws
> > up and it has merging.
> 
> So would that mean I would need bitkeeper installed in order to change my
> password? 

No, that's just one way to solve the problem.  Another way would be to have
a master/slave relationship between the replicas sort of like CVS.  In fact,
you could use CVS.

> And IIRC, bitkeeper is not free either?

Actually it is for this purpose.  You can either do open logging (probably
not what you want) or run it in single user mode which doesn't log, you
just lose the audit trail (all checkins look like they are made by root).

If I could figure out a way to allow the use of BK for /etc with out any
restrictions at all, and at the same time prevent people from just putting
all their source in /etc and shutting down our commercial revenue, I'd
do it in a heartbeat.  I'd *love it* if when I did an upgrade from Red Hat,
the config files were part of a BK repository and I just did a pull/merge
to join my local changes with whatever they've done.  That would be a huge
step in making sys admin a lot less problematic.  But this is more than a
bit off topic...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
