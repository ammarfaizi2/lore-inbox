Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbRL2W1O>; Sat, 29 Dec 2001 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2W1G>; Sat, 29 Dec 2001 17:27:06 -0500
Received: from ns.suse.de ([213.95.15.193]:62474 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287200AbRL2W0w>;
	Sat, 29 Dec 2001 17:26:52 -0500
Date: Sat, 29 Dec 2001 23:26:51 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229140914.B13883@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112292317310.1336-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> I'd suggest you go try this idea out.  It's funny how often people suggest
> that they are going to make the problems go away, it's always this same
> proposal, typically nobody does any work, when they do it doesn't get used,
> could it be there is a reason for that?
>
> I'm prepared to be wrong, but I don't hear the maintainers asking for this
> patchbot.  Why not?

Something I've done for a quite is set up some procmail rules
to filter subjects with [PATCH] and the likes into an additional
folder.  Every so often, I'll go through it, deleting ones that
ended up getting merged with mainline.

The ones that don't, I look around for followups in my l-k
folder for that month. If it got shot down in flames or discarded
for another reason, it gets deleted from my patch folder.

Picking through the rest usually turns up some useful bits
that in the past I've resynced/cleaned up, and pushed to relevant
maintainer and they've finally got accepted.

I'm making two points here.

 1. This is not perfect in that a lot of patches get sent to the list
 without being prefixed with [PATCH], so unless I happen to see it
 when skimming my l-k folder, it falls through the gaps.

 2. I don't have time to read every patch that ends up in my
 patch folder.

The patchbot solves the first problem by making it not possible to accept
a patch without a standard prefix. The second it could fix by generating
a monthly "pending" report for every person using it, and having these
summaries sent to a patchbot-pending mailing list.

As long as *someone* sees these patches are still out there, they'll get
merged eventually, even if it means sitting in a tree other than Linus's
for a few months.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

