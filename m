Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292267AbSBOXXp>; Fri, 15 Feb 2002 18:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292268AbSBOXXi>; Fri, 15 Feb 2002 18:23:38 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53776 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292267AbSBOXXZ>; Fri, 15 Feb 2002 18:23:25 -0500
Date: Sat, 16 Feb 2002 00:23:12 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215232312.GB12204@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <200202152209.g1FM9PZ00855@vindaloo.ras.ucalgary.ca> <20020215165029.C14418@thyrsus.com> <20020215143807.L28735@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020215143807.L28735@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Larry McVoy wrote:

> If you really want to contribute, what you'll do is improve the existing
> system.  Screaming that it can't be done just means you aren't a kernel
> programmer.  What kernel programmers do is the hard ugly work it takes to
> make things work smoothly.  Look at any device driver - just a handfull
> of simple interfaces: open,close,read,write,ioctl (ok that last one is
> far from simple).  Now go look at the code implementing those interfaces,
> it's frequently a huge effort to make some recalcitrant device behave.
> 
> But that's what kernel programmers do.  They take a mess and present
> a clean, well working system.  No one said it was easy.  If you are a
> kernel programmer, you can take CML1 and make it work, for a reasonable
> definition of "work".  If you can't, you're far better off to admit
> you're in over your head and give it up.  Harping on CML2 as the better
> answer isn't going to work.  Neither is telling people they don't get it,
> when those same people have done 10,000 times more work on the kernel
> than you'll ever do.  

(cc: list killed, I assume all are subscribed to l-k)

Preface: I have no plan of kbuild and kernel configuration, so take this
with a grain of salt. But maybe it gives me the chance to calm all this
because I'm not biased towards either side.

Are you telling that kernel programmers don't rewrite code from scratch?
Is that a correct interpretation of "improve the existing system"? Note
that "it can't be done" can also imply "cannot reasonable be done".

If that's not what you mean, stop reading this mail, drop a line to
clarify this and forget this piece of mail. If it _is_ what you mean,
then with all due respect, why cannot kernel programmers rewrite a
subsystem (even if it interfaces with the whole world of kernel
configurations) from scratch?

Eric has done it, without being of kernel hacker temple's fame.

Whether he doesn't listen to other developers, I cannot tell, I got my
/fetchmail/ issues resolved. Still, I share the opinion that the kernel
build stuff is mainly for developers (and if it cuts down turnaround
times, it well deserves a try), and if -- as a side effect -- it's good
for the user, so be it, and if it's clear and self documenting, that's
nothing a developer would reject. Resurrecting this IMHO dead thread
around Mrs. Tillie won't bring any good. (Although Aunt Tillie should
really get her kernel as .deb or .rpm.)

AFAICS, Eric has gone lengths to get a competitive kernel configuration
system working well enough for production use, minor issues seem to
remain, like split Configure.help. I can easily understand no-one is
throwing this work away. If he's convinced the system is more consistent
and robust in itself, that's good -- but all this advocacy seems to be
torn down to some (personal) vendetta. Linux does not deserve that.

What I'm missing in this thread are facts. The point "communications
problem" has been raised. It seems to me as though the two opposing
parties (pro and con CML2) were not clear about what they expect from
the other party. If something has gone on behind the scenes, well, I
will have missed it...

I'm really hoping that this issue can get resolved in one way or
another, my personal opinion is that one single config stuff parser is
the goal, be it mconfig or be it CML2.
