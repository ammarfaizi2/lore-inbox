Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSA2NXd>; Tue, 29 Jan 2002 08:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289273AbSA2NXY>; Tue, 29 Jan 2002 08:23:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12082 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289239AbSA2NXM>; Tue, 29 Jan 2002 08:23:12 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <landley@trommello.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jan 2002 06:19:43 -0700
In-Reply-To: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com>
Message-ID: <m1wuy1cn0w.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
 
> Now, if you've read this far, and you agree with these issues, I suspect
> you know the solution as well as I do. It's the setup I already mentioned:
> a network of maintainers, each of whom knows other maintainers.
> 
> And there's overlap. I'm not talking about a hierarchy here: it's not the
> "general at the top" kind of tree-like setup. The network driver people
> are in the same general vicinity as the people doing network protocols,
> and there is obviously a lot of overlap.

So the kernel maintainership becomes a network of maintainers.  Then
we only have to understand the routing protocols.  Currently the
routing tables appear to have Linus as the default route.  As there
are currently kernel subsystems that do not have a real maintainer, it
may reasonable to have a misc maintainer.  Who looks after the
orphaned code, rejects/ignores patches for code that does have
active maintainers, and looks for people to be maintainers of the
orphaned code.  

The key is having enough human to human protocol that there is someone
besides Linus you can send your code to.  Or at least when there isn't
people are looking for someone.

Free Software obtains a lot of it's value by many people scratching an
itch and fixing a little bug, or adding a little feature, sending the
code off and then they go off to something else.  We need to have the
maintainer routing protocol clear enough, and the maintainer coverage
good enough so we can accumulate most of the bug fixes from the fly by
night hackers.  

So does anyone have any good ideas about how to build up routing
tables?  And almost more importantly how to make certain we have good
maintainer coverage over the entire kernel?

Eric
