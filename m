Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290639AbSA3V6K>; Wed, 30 Jan 2002 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290640AbSA3V6B>; Wed, 30 Jan 2002 16:58:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60689 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290639AbSA3V5y>; Wed, 30 Jan 2002 16:57:54 -0500
Date: Wed, 30 Jan 2002 16:56:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: jacob@chaos2.org
cc: Russell King <rmk@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.21.0201301152350.21054-100000@inbetween.blorf.net>
Message-ID: <Pine.LNX.3.96.1020130164627.5584A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Jacob Luna Lundberg wrote:

> 
> On Wed, 30 Jan 2002, Russell King wrote:
> > There's one problem with that though - if someone maintains many files,
> > and his email address changes, you end up with a large patch changing all
> > those email addresses in every file.
> 
> Why not have real fun and give out e-mail@vger.kernel.org (or @kernel.org) 
> to people who make it into MAINTAINERS then?  Of course, someone would
> have to maintain the accounts...  ;)

Just as a talking point, it should be possible to have a daemon scan mail
the lkml for [PATCH] and read the filenames from the patch itself, and do
a file to maintainer lookup followed by a mail. Obviously it would have to
have a human for some cases, but that's not all that bad, at least the
patch program could assign a number and post a list of patches to lkml on
a regular basis.

The hard part is the file to maintainer map, so the program can pick the
best maintainer, and possibly on a regular (daily) basis a single list of
patches to other maintainers: "this patch was sent to XXX bacause most of
the files are hers,but some are yours so you might want to check." And of
course XXX would be told that the patch changed other's files as well.

All patches would be given a number for discussion, after eyeball of the
first 20 patches I saw, I guess that 60-80% could unambiguously go to the
correct maintainer.

I realize this is less complex and wonderful than the schemes proposed,
therefore it might easily actually happen... and it takes no effort except
reading the mail, if the maintainer doesn't care to use the notification
s/he can ignore it, at least the submitter can be sure it was remailed and
to whom.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

