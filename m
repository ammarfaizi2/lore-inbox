Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWIGQA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWIGQA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWIGQA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:00:57 -0400
Received: from web36604.mail.mud.yahoo.com ([209.191.85.21]:7836 "HELO
	web36604.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932230AbWIGQA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:00:56 -0400
Message-ID: <20060907160055.17688.qmail@web36604.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Thu, 7 Sep 2006 09:00:55 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <ednsma$hbt$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- David Wagner <daw@cs.berkeley.edu> wrote:

> Casey Schaufler  wrote:
> >In our TCSEC B1 (Old person speak for LSPP)
> >evaluation we had to put way too much effort
> >into explaining why certain operations that
> >had nothing to do with the system security
> >policy (e.g. compute resource limitations)
> >required privilege. These operations had
> >no security implications at all, but since
> >they required privilege they were assumed to
> >have dire consequences should they be abused.
> 
> Well, this is sounding like a pretty weak argument.

That all depends on how important getting
an evaluation complete is to you. And, they
do have a point, which is why does it make
sense to use the same privilege mechanism
for you security policy as you do for your
resource management policy.

> It sounds like what you are saying is the evaluators
> were not thinking
> straight when they gave you a hard time about your
> efforts to do a
> better job of implementing the principle of least
> privilege.

No, they were very clear that they felt that
use of the privelege ought to be an indication
that policy was being violated, and they were
correct. The issue was that the system made
it difficult to distinguish between violations
of the security policy and violations of the
resource management policy. 

> If I
> understand the gist of what you are saying
> correctly, you reduced the
> privilege on some processes, and the result was that
> they complained
> more loudly than if you had done nothing.  If so,
> that's pretty lame.
> That doesn't sound to me like the evaluators were
> thinking very clearly.

No, the issue was that every use of the
privilege mechanism, even when it was not
relevent to the security policy, required
investigation and explaination.

> And if the evaluators don't really understand how to
> think clearly about
> security, why should we pay any attention to them,
> anyway?

Because it's cool to have the hand-calligraphed
certificate hanging on your office wall.

> I see no
> reason to design the Linux kernel around the whims
> of those who don't
> understand the technical issues.

The evaluatee gets to explain the technical
issues to the evaluators. That's the challenge.
The areas that require the most explaination
are typically those that could use refinement.

> Who cares about what the evaluators
> think, if they don't have their head screwed on
> straight?  Personally,
> I care more about technical merit than about
> pleasing folks who don't
> understand security.

Much of the community's understanding of
security has come about because evaluators
asked unpleasant questions that required
hard thinking to answer. The SELinux effort,
for example, represents a directed effort
to "do better" than the Unix B1/CMW systems.
Don't underestimate evaluators.


Casey Schaufler
casey@schaufler-ca.com
