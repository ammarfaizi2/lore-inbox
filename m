Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263383AbSJFLsM>; Sun, 6 Oct 2002 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbSJFLsM>; Sun, 6 Oct 2002 07:48:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62154 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263383AbSJFLsL>;
	Sun, 6 Oct 2002 07:48:11 -0400
Date: Sun, 6 Oct 2002 14:04:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Ulrich Drepper <drepper@redhat.com>, <bcollins@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: BK MetaData License Problem?
In-Reply-To: <20021006.035934.106436540.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210061324500.4303-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, David S. Miller wrote:

>    i'm also a bit worried about the legal status of commit messages posted
>    via bkbits. Are they GPL-ed automatically, can we just take them and put
>    them into a free-BK type server? We already have one precedent of a
>    business entity abusing a free OS project and then suing it (and winning
>    the suit), hindering the free OS's development for years.
> 
> Larry has stated many times over that he doesn't own our bits.
> 
> That is why once you extract content from the repository into some other
> form (a patch with the change logs prepended, for example) he doesn't
> care what you do with it.

for years people sent emails to Linus that described patches and this was
not a big issue - Linus has kept 99% of the metadata in the source code.
But today the 'Linux kernel' is not the source code anymore, it's the
source code plus the BK metadata, which are separate bits, and this
creates a new situation.

the BKL.txt license currently says:

                             By transmitting the Metadata
     to an Open Logging server, You hereby grant BitMover,
     or any other operator of an Open Logging server, per-
     mission  to  republish  the Metadata sent by the Bit-
     Keeper Software to the Open Logging server.

what i'm worried about is the following issue: by default the data and the
MetaData is owned by whoever created it. You, me, other kernel developers.
We GPL the code, but the metadata is not automatically GPL-ed, just like
writing a book about the Linux kernel is is not necesserily GPL-ed.

It's not a big problem today because if you ask me then i'll tell you that
it's GPL-ed - but what will be the situation be in years? Couldnt
'BitMover or any other operator of an Open Logging server' argue that the
MetaData is owned by whoever created them, and is not covered by the GPL -
and only 'BitMover or any other operator of an Open Logging server' has
'permission to republish the Metadata'.

there are a number of legal cases in the US that involve around exactly
such issues (republishing of newpaper articles on the internet written by
independent journalists, republishing of the CD info database created by
anonymous users, etc.), and i'm sure we do not want the Linux kernel tree
to become another legal precedent.

it would be better if the license also said:

	By transmitting the MetaData to an Open Logging server, You 
        hereby also agree to license the MetaData under the same license
        you license the data it describes.

(or something to that extent - i'm not a lawyer.)

this ensures that metadata attached to GPL-ed code is also licensed under
the GPL, and creates a clearly GPL-ed repository, both data and metadata.  
I'm 100% sure that the Linux commit messages are already valuable today,
and they will become a few orders more valuable in a few years.

btw., this is also the case with the emails Linus puts into BK commit info
- the email someone sends to Linus is _not_ GPL-ed by default.

(perhaps the solution is simple - i'd be really happy if it was.)

	Ingo

