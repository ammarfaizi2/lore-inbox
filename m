Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423350AbWJUQRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423350AbWJUQRH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWJUQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:17:07 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:32225 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161005AbWJUQRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:17:03 -0400
Subject: Re: (About GPLv3) Can the Linux Kernel Relicense?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ciaran@fsfe.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Oct 2006 11:16:59 -0500
Message-Id: <1161447419.17804.94.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 Ciarán O'Riordan wrote:
> While discussing GPLv3, some people have suggested that even when
> version 3 of the GPL is released, the Linux kernel developers will not
> have the option of using it due to copyright reasons.

Let me try to move this discussion out of the various hidden corners of
the blogosphere and into the open, because it is an important one.

> This is incorrect, but it is based on a real problem: The Linux kernel
> has no structures in place to facilitate relicensing.

The characterisation of this as a "problem" is incorrect.  In fact, I
see this as just another of the many strengths of the open source
process.  He who owns the copyright controls the code.  The object of
the Linux development process is to produce the best and most
technically excellent kernel we possibly can, not to produce a piece of
code that's owned by some individual person or entity.  Thus, it seems
to me to be the essence of fairness that each individual contributor to
Linux owns their own copyright and hence the kernel itself is owned by
all its contributors in proportion to their contribution.

This is a structure and it serves two purposes

     1. It franchises every contributor to the kernel.  Anyone who ever
        submits a patch for anything can point to their contribution and
        know they own it.
     2. It prevents anyone taking control of the project via the
        mechanism of copyright ownership.

> Moving to an incompatible licence requires that current code is
> relicenced with permission from the copyright holders, or is removed.

That is correct.  It would be a very time consuming and arduous process,
but it could be done.

> FSF foresaw this problem in the 80s, and it was obvious that the
> licence would have to be updated at some time, and so they implemented
> two fixes. One fix was specifically for the GNU project - they
> requested the contributors assign the copyright to FSF so that
> relicensing (as well as enforcement) can be done by FSF.

That's fine and dandy for as long as you trust the FSF stewardship of
the copyrights.  If we'd signed over the Linux copyrights to the FSF, it
would give us all a warm glow to know that the kernel was going v3
regardless of the views of its contributors.

Fundamentally, I far prefer the trust nobody franchise everybody
approach which is the current state in Linux.

> The second is that they recommended that people using the GNU GPL
> should licence their software under a specific version plus "any later
> version". If people do this, their software will be compatible with
> GPLv3, v4, v5, etc., so this issue will not exist.

Again, this is an issue of trust:  Nearly a decade ago, the then Linux
developers didn't trust the FSF enough to accept whatever GPLv3 would
turn out to be sight unseen.  Whether this was the correct course of
action is open to debate, of course.  However, any good lawyer always
tells you to read a contract or licence over before signing or accepting
it ... which is violated by the "or later" wording.

> Almost every GPL-using free software project did this. The Linux
> kernel is the only large exception. With hundreds or thousands of
> authors, and each being a copyright holder, it will be difficult to
> contact them all.
> 
> Why is GPLv2 incompatible with v3? GPL version 2 says that any
> modified versions of the software must also be distributed under GPL
> version 2. GPL version 3 will say that any modified versions of
> software it covers, must be distributed under GPL version 3. So if
> someone merges some version 2 software with some version 3 software,
> there will be no legal way to distribute the combination. It has
> always been known that version 3 would be incompatible with version 2.

That's not necessarily true.  If v3 had simply fixed the three known
issues in v2:  Bittorrent, termination and patent licence as v2 plus
additional permissions, then the resulting licence would have been v2
compatible.  It's the additional restrictions that v3 is insisting on
that introduce the fundamental incompatibility with the v2 "no
additional restrictions" requirements.

> For Linux, getting into a position where they can use another licence
> will take time and/or effort, but this is something they should do
> anyway. If an absurd interpretation of GPLv2 is accepted by a court in
> your country tomorrow, what will Linux do? And what if this absurd
> interpretation is accepted in more countries? Or what if the licence
> is declared invalid by a court? (that last situation is very unlikely,
> but it's just an example for discussion.)

But, for the reasons given above, I think it is in the correct position.
Changing the licence is like invoking great power ... and invoking great
power should be fundamentally hard otherwise people want to do it at the
drop of a hat.  Since we have to secure the agreement of every copyright
holder, it will be difficult and take a long time.  On the other hand,
if there's a great impetus to do it (like some of the situations you
cite above) then I think we could all rally around.

> This is a reason why free software projects should maintain their
> copyrights in a way that will allow them to update their licence when
> the want or need arises.

How can you lecture about freedom and then in the next breath turn
around and demand a controlling structure?  True freedom is also freedom
from control; and I think the franchise all Linux mechanism comes far
closer to this than the centrally controlled FSF one.

> To get into the position to move to a GPLv3, the Linux developers
> could adopt the "or any later version" policy from now on, get
> relicensing permission from as many copyright holders as possible, and
> then get back to programming. Over time, the (hopefully small amount
> of) non-relicensed code will be replaced by new code (without the
> license problem), and eventually the entire code base will be ok to
> relicense.
> 
> So I'm saying they can move to v3 if they want. Whether they actually
> do, also depends on whether they want to. That discussion will be more
> productive after GPLv3 is released (the current published texts are
> just discussion drafts). Right now, the important thing is for people
> to go to the current draft and comment on the text, to help make the
> best licence possible.

I'm really sorry, but this is democracy in action: in order to relicence
linux, *you* have to convince every copyright holder that it's the right
thing to do.  You can't wring your hands and say "convincing people is
too hard, we'll just wave the magic wand of control and make the problem
go away" because we don't have one (deliberately).  Nor can you blame
"the linux developers" for not having a correct licensing policy.  Code
only goes into the Linux kernel on its merits after it has been argued
for in a review the same is true of the Licence ... get on with
convincing people and arguing for GPLv3.

James


