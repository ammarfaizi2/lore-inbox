Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSGBXLv>; Tue, 2 Jul 2002 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGBXLu>; Tue, 2 Jul 2002 19:11:50 -0400
Received: from irc.sh.nu ([216.239.132.110]:48311 "EHLO fungus.sh.nu")
	by vger.kernel.org with ESMTP id <S314277AbSGBXLs>;
	Tue, 2 Jul 2002 19:11:48 -0400
Date: Tue, 2 Jul 2002 16:14:17 -0700
From: crimsun@fungus.sh.nu
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler vs 2.4.19-rc1 (question).
Message-ID: <20020702161417.A14646@fungus.sh.nu>
References: <20020702210905.687588B4@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020702210905.687588B4@merlin.webofficenow.com>; from landley@trommello.org on Tue, Jul 02, 2002 at 11:33:36AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:33:36AM -0400, Rob Landley wrote:
> I'm finally getting around to playing with the O(1) scheduler (well I found a 
> way to break something that this might help), and I'm a bit confused as to 
> what to apply to get the newest version running on 2.4.19-rc1:

The last one you list below is the latest.

> http://people.redhat.com/mingo/O(1)-scheduler/sched-O1-2.4.18-pre8-K3.patch
> http://people.redhat.com/mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-A4
> http://people.redhat.com/mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-B3
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^

> 1) The 2.4.18-pre8 patch is from February 7th.  Is that really the latest one 
> for straight 2.4?  If nobody's found even a typo in the thing for almost five 
> months, can we expect it in 2.4.20-pre1?

While it's certainly nice, I think Ingo and Robert both stated best that
it's best not to change this in vanilla 2.4 where accountable behavior
should remain for a stable-branch kernel.

> 2) Do the -ac patches bring the 2.4-mt O(1) up to the level that's in the -ac 
> tree, or are they against the -ac tree itself?  I'd happily run the -ac tree 
> except it doesn't HAVE stable releases, it has "it compiled" releases which 
> do tend to be fairly stable but don't have nice clustering points where 
> enough people are running that particular variant that they can tell you what 
> the inevitable bugs actually are...

Against the -ac tree itself as stated in the patch name. For the record,
2.4.19-pre10-ac2 has been solid here in various incarnations for nearly
a month.

> 3) Is any of the stuff in ingo's directory actually the latest version?  I 
> know he wrote it, but I've watched about five other people patch it (Robert 
> Love, etc.), and I didn't keep close track at the time but I'm fairly certain 
> it was more recent than February.

See above (and below). :)

> 4) What's with the version numbers?  I don't THINK the "B3" patch backlevels 
> K3 in a more recent -ac version, especially since "B3" is dated july and "K3" 
> is dated february...  I seem to have missed a curve somewhere...

Ingo's mail dated 01 July 11:49:39 +0200 (CEST) has
sched-2.4.19-pre10-ac2-B3 as the latest.

-- 
Dan Chen                crimsun@fungus.sh.nu
GPG key:   www.sh.nu/~crimsun/pubkey.gpg.asc
