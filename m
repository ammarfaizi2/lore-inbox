Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRFTVUs>; Wed, 20 Jun 2001 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbRFTVUj>; Wed, 20 Jun 2001 17:20:39 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:37637 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262596AbRFTVU1>;
	Wed, 20 Jun 2001 17:20:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106202120.f5KLKO5320707@saturn.cs.uml.edu>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
To: landley@webofficenow.com
Date: Wed, 20 Jun 2001 17:20:24 -0400 (EDT)
Cc: ttabi@interactivesi.com (Timur Tabi),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <01062007520902.00776@localhost.localdomain> from "Rob Landley" at Jun 20, 2001 07:52:09 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:

> My only real gripe with Linux's threads right now [...] is
> that ps and top and such aren't thread aware and don't group them
> right.
>
> I'm told they added some kind of "threadgroup" field to processes
> that allows top and ps and such to get the display right.  I haven't
> noticed any upgrades, and haven't had time to go hunting myself.

There was a "threadgroup" added just before the 2.4 release.
Linus said he'd remove it if he didn't get comments on how
useful it was, examples of usage, etc. So I figured I'd look at
the code that weekend, but the patch was removed before then!

There is nothing that ps and top can do about this problem.
I've certainly looked into the matter; much of the code is mine.
BTW, the version in debian-unstable is the most stable. :-)

These options might help a little bit: --forest -H f

> (Ever tried to sumit a patch to the FSF?  They want you to sign
> legal documents.  That's annoying.  I usually just send the bug
> reports to red hat and let THEM deal with it...)

Submit patches to me, under the LGPL please. The FSF isn't likely
to care. What, did you think this was the GNU system or something?

> Linus's job is to keep code OUT of the kernel.  He has veto power,
> nothing else.  I suspect he's pre-emptively vetoing some stuff to
> keep the flood down to a level he can deal with.  Maybe someday
> we'll convince him to use some variant of source control (not
> necessarily CVS, how about just a seperate mailing list of the
> individual patches as he applies them?  One linus can post to and
> that is read-only to everybody else?  HE always wants patches
> seperated down nicely into individual messages with explanations,
> but WE have to get pre2-pre3 as one big patch lump.  With a
> patches-from-linus mailing list that he forwarded posts to, we'd
> know exactly when a patch went in and who it was from without
> bothering Linus. :)

How about a filesystem filter to spit out patches, or a filesystem
interface to version control?
