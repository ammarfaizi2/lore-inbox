Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSA2XMx>; Tue, 29 Jan 2002 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSA2XMu>; Tue, 29 Jan 2002 18:12:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:61073
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286521AbSA2XLb>; Tue, 29 Jan 2002 18:11:31 -0500
Message-Id: <200201292311.g0TNBJU21007@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Skip Ford <skip.ford@verizon.net>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 18:12:26 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <a354iv$ai9$1@penguin.transmeta.com> <20020129143359.BBSA15035.out018.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
In-Reply-To: <20020129143359.BBSA15035.out018.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 09:30 am, Skip Ford wrote:
> Linus Torvalds wrote:
> [snip]
>
> > A word of warning: good maintainers are hard to find.  Getting more of
> > them helps, but at some point it can actually be more useful to help the
> > _existing_ ones.  I've got about ten-twenty people I really trust, and
>
> Then why not give the subsystem maintainers patch permissions on your tree.
> Sort of like committers.  The problem people have is that you're dropping
> patches from those ten-twenty people you trust.

I understand why he doesn't do that: he can't function if the code is 
changing under him in ways that suprise him.  (Especially he can't function 
as architect without doing code inspection.)

Linus DOES apply larger patches from maintainers with less scrutiny, but 
there still IS scrutiny of each patch.  (At the very least, checking which 
files it touches.)

> Each subsystem maintainer should handle patches to that subsystem, and
> you should remove your own patch permissions for only those subsystems.
> You could get involved with only changes in direction that affect more
> than one subsystem.

Linus also reserves the right to mess with a maintainer's code and force a 
patch back down the tree for them to resync with.  He just did it with the 
help files (after a "private flamewar").  In this case, the maintainer was 
caught by suprise, claiming to be unaware that Linus expected him to make 
that change, which just seems to be one more example of a lack of 
communication between Linus and a maintainer.  This time, instead of Linus 
not getting the maintainer's message (patch), the maintainer doesn't get 
linus's message ("Go do this, in this order".)  So we've got examples of 
messages getting dropped in both directions, making the maintainer look 
inattentive when he claims otherwise, and making Linus look inattentive when 
HE claims otherwise...

Rob
