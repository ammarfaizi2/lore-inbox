Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262897AbSJAXPE>; Tue, 1 Oct 2002 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262902AbSJAXPE>; Tue, 1 Oct 2002 19:15:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62215 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262897AbSJAXPB>; Tue, 1 Oct 2002 19:15:01 -0400
Date: Tue, 1 Oct 2002 16:22:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jaroslav Kysela <perex@suse.cz>
cc: "David S. Miller" <davem@redhat.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update [10/10] - 2002/08/05
In-Reply-To: <Pine.LNX.4.33.0209302327500.503-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.33.0210011607200.18575-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, Jaroslav Kysela wrote:
> 
> I need to redo next 7 patches because your update :-(
> My fault, I should be faster.

You should be _timely_.

The big patches also means that it is damn painful for me to merge your
patches. In fact, of _all_ the subsystems in the whole kernel, right now
the ALSA code is absolutely the worst by a big marging when it comes to
merging. 

And your changeset names are just dates, for chrissake! 

Please, fix this up. Your CVS tree means that nobody else can comment
sanely on the changes, it makes _your_ merges harder (not just mine), and
we've several times lost real work that went into the standard tree
because of that.

Right now some audio drivers don't compile, apparently because their
makefiles are broken etc etc. Getting huge drops with totally unrelated 
changes every two months is _not_ acceptable.

Talk to David about the problems with an external CVS tree, he had many of
the same problems with his sparc/networking tree a long time ago. David, 
maybe you can talk about how you solved them.

This is worse than the ACPI stuff, which is saying something. The ACPI
tree has actually tried to merge in sane chunks lately, and make a clean
BK tree available (in contrast, your BK patches don't even apply, since
there are missing chunks etc small "details").

There's a strong hint in the fact that the patches are so big that you 
can't post them. And that hint says that something is WRONG.

			Linus

