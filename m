Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRHWWuB>; Thu, 23 Aug 2001 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270451AbRHWWtv>; Thu, 23 Aug 2001 18:49:51 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:20085
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S270645AbRHWWtc>; Thu, 23 Aug 2001 18:49:32 -0400
Date: Thu, 23 Aug 2001 15:49:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: source control?
Message-ID: <20010823154947.X25998@work.bitmover.com>
Mail-Followup-To: "Grover, Andrew" <andrew.grover@intel.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0A4@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0A4@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Thu, Aug 23, 2001 at 02:29:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 02:29:18PM -0700, Grover, Andrew wrote:
> Is Linux development ever going to use source control?
> 
> This was talked about at the Kernel Summit, and I haven't heard anything
> about it since.

There are two features that Linus wants in BitKeeper that we haven't
finished yet.  One is the removal of the revision control files from
the working tree and the other is the ability to break the tree up
into logical units (we call 'em filesets) so that you can more easily
pick and choose which patches you want in your tree.

Linus pinged me about these a while back, we've made some progress on
them but they aren't done yet.  When they are done we'll let Linus take
it for a whirl and see what he thinks.

In the meantime, the PPC people maintain a pure Linux tree in BK, you
can see it at http://ppc.bkbits.net and Ted Tso has recently done a
nice import of the various kernel versions complete with Linus' change
logs.  I need to work with the PPC guys and Ted to get to one tree;
it's not an easy issue because the PPC have a lot of changes in their
tree but Ted's tree was done more nicely, he did some extra work to 
preserve timestamps and comments.  

And to avoid yet-another-BK-flamewar, I'm not saying Linus will or will
not use BitKeeper, all I'm saying is that we're making changes he wants
and then he'll see if it is good enough for him.  I will say that he has
eased slightly off of his original position of "I'll use BitKeeper when
it is the best" because I asked him if that meant what I think both he
and I would mean, i.e., "it is not physically possible for it to be better"
as opposed to "it's better than all the other crap out there".  I think
we agreed we have to be well past #2 but not necessarily to #1 (which is
a good thing, at the rate we're going we'll hit the best sometime this
century but that's as close as I want to call it :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
