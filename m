Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGBWCv>; Tue, 2 Jul 2002 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSGBWCv>; Tue, 2 Jul 2002 18:02:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57326 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S312938AbSGBWCu>; Tue, 2 Jul 2002 18:02:50 -0400
Subject: Re: O(1) scheduler vs 2.4.19-rc1 (question).
From: Robert Love <rml@tech9.net>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020702210905.687588B4@merlin.webofficenow.com>
References: <20020702210905.687588B4@merlin.webofficenow.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Jul 2002 15:05:05 -0700
Message-Id: <1025647505.11052.1320.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-02 at 08:33, Rob Landley wrote:

> 1) The 2.4.18-pre8 patch is from February 7th.  Is that really the latest one 
> for straight 2.4?  If nobody's found even a typo in the thing for almost five 
> months, can we expect it in 2.4.20-pre1?

That is the latest patch Ingo has.  I have been generating 2.4 patches
now and the latest (for 2.4.19-rc1) is at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-rc1-1.patch

People have found bugs and there is still active development.  The last
patch being against 2.4.18-pre8 should not mean otherwise.  Neither Ingo
nor I plan to pursue the O(1) scheduler in 2.4, especially not starting
with 2.4.20-pre.

Enjoy it in 2.5 or get 2.4-ac or the above patch.

> 2) Do the -ac patches bring the 2.4-mt O(1) up to the level that's in the -ac 
> tree, or are they against the -ac tree itself?  I'd happily run the -ac tree 
> except it doesn't HAVE stable releases, it has "it compiled" releases which 
> do tend to be fairly stable but don't have nice clustering points where 
> enough people are running that particular variant that they can tell you what 
> the inevitable bugs actually are...

I do not know if I agree with your view of 2.4-ac, but nonetheless I
have kept the scheduler in there fairly up-to-date.  The patches above
of Ingo's will bring 2.4.19-pre10-ac2 up-to-date with the very latest
code.

> 3) Is any of the stuff in ingo's directory actually the latest version?  I 
> know he wrote it, but I've watched about five other people patch it (Robert 
> Love, etc.), and I didn't keep close track at the time but I'm fairly certain 
> it was more recent than February.

The 2.4-ac stuff is recent, obviously the 2.4.18-pre8 thing is a bit out
of date.

Ingo is still active in development, he just does not have the latest
2.4 stock patch.  See mine above.

> 4) What's with the version numbers?  I don't THINK the "B3" patch backlevels 
> K3 in a more recent -ac version, especially since "B3" is dated july and "K3" 
> is dated february...  I seem to have missed a curve somewhere...
>
> 5) Huh?

Eh?

	Robert Love

