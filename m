Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316436AbSEOQjg>; Wed, 15 May 2002 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316440AbSEOQjf>; Wed, 15 May 2002 12:39:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316436AbSEOQj3>; Wed, 15 May 2002 12:39:29 -0400
Date: Wed, 15 May 2002 09:39:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org 
In-Reply-To: <30386.1021456050@redhat.com>
Message-ID: <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 May 2002, David Woodhouse wrote:
>
> Are you still accepting BK changesets by mail? I heard rumours that you'd
> said you didn't want them any more -- but couldn't find a message in which
> you actually said that.

I try to avoid it as much as possible - it's actually more work for me,
and about 50% of the BK patches I get don't even apply, because the person
who sent them to me didn't send the whole series (ie left out some patch
he didn't like or something like that).

> When making changesets to send to you, I usually start with a fresh clone
> of your latest tree and apply my changes to that -- would you prefer me to
> make the whole tree available somewhere public (or on master.kernel.org)
> for a 'bk pull' instead?

I much prefer a bk pull, if the tree I pull from is clean (ie it doesn't
have random crud in it, and it contains changsets from just one project).

Some people actually use BK but then send me regular patches anyway,
because they find that easier than setting up an exported BK tree and
being careful about cleanliness. I don't much care one way or the other:
regular email patches are easy for me to integrate, so it's really up to
you.

> Having the facility to put per-file changelogs in with BK rather than just
> sending patches is something I quite like, so I'd rather not just revert to
> sending patches.

[ Personal opinion alert! No impact on patch acceptance, as long as
  enough changelog information exists _somewhere_ ]

I personally like good changelog comments, and I find per-file comments to
be a mistake.

I have a few simple reasons for this:

 - most changes are related, and per-file comments tend to just repeat.

   In fact, for patches, I just repeat the Subject: line in the per-file
   comments, so that they have just enough context to get the big picture.

 - if your changes _aren't_ related, you should have done multiple
   changesets in the first place. Rince and repeat as necessary.

 - the per-file comments don't show up in many of the standard changelogs
   (not mine, not in "bk changes" etc), so the per-changeset comment
   should be "sufficient" in many ways anyway.

But to each his own.

[ End personal opinion ]

		Linus

