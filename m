Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290840AbSAaCp3>; Wed, 30 Jan 2002 21:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSAaCpU>; Wed, 30 Jan 2002 21:45:20 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:44696 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290840AbSAaCpM>;
	Wed, 30 Jan 2002 21:45:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>, jacob@chaos2.org
Subject: Re: A modest proposal -- We need a patch penguin
Date: Thu, 31 Jan 2002 03:45:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        patchbot-devel@killeri.net
In-Reply-To: <Pine.LNX.3.96.1020130164627.5584A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020130164627.5584A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W7Ea-0000KI-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 10:56 pm, Bill Davidsen wrote:
> On Wed, 30 Jan 2002, Jacob Luna Lundberg wrote:
> > On Wed, 30 Jan 2002, Russell King wrote:
> > > There's one problem with that though - if someone maintains many files,
> > > and his email address changes, you end up with a large patch changing all
> > > those email addresses in every file.
> > 
> > Why not have real fun and give out e-mail@vger.kernel.org (or @kernel.org) 
> > to people who make it into MAINTAINERS then?  Of course, someone would
> > have to maintain the accounts...  ;)
> 
> Just as a talking point, it should be possible to have a daemon scan mail
> the lkml for [PATCH] and read the filenames from the patch itself, and do
> a file to maintainer lookup followed by a mail. Obviously it would have to
> have a human for some cases, but that's not all that bad, at least the
> patch program could assign a number and post a list of patches to lkml on
> a regular basis.
> 
> The hard part is the file to maintainer map, so the program can pick the
> best maintainer, and possibly on a regular (daily) basis a single list of
> patches to other maintainers: "this patch was sent to XXX bacause most of
> the files are hers,but some are yours so you might want to check." And of
> course XXX would be told that the patch changed other's files as well.
> 
> All patches would be given a number for discussion, after eyeball of the
> first 20 patches I saw, I guess that 60-80% could unambiguously go to the
> correct maintainer.
> 
> I realize this is less complex and wonderful than the schemes proposed,

Is that bad?

> therefore it might easily actually happen... and it takes no effort except
> reading the mail, if the maintainer doesn't care to use the notification
> s/he can ignore it, at least the submitter can be sure it was remailed and
> to whom.

One (and only one) step ahead of you.  Please have a look at what we're
doing here:

   http://killeri.net/cgi-bin/alias/ezmlm-cgi

And yes, we're already thinking about Russell's concerns with spam.  I
think that issue is under control.

-- 
Daniel
