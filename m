Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSGBV33>; Tue, 2 Jul 2002 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSGBV32>; Tue, 2 Jul 2002 17:29:28 -0400
Received: from pc132.utati.net ([216.143.22.132]:22657 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S311752AbSGBV30>; Tue, 2 Jul 2002 17:29:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: O(1) scheduler vs 2.4.19-rc1 (question).
Date: Tue, 2 Jul 2002 11:33:36 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020702210905.687588B4@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm finally getting around to playing with the O(1) scheduler (well I found a 
way to break something that this might help), and I'm a bit confused as to 
what to apply to get the newest version running on 2.4.19-rc1:

In http://people.redhat.com/mingo/O(1)-scheduler/ there live a number of 
files, the most interesting of which for my purposes appear to be:

http://people.redhat.com/mingo/O(1)-scheduler/sched-O1-2.4.18-pre8-K3.patch
http://people.redhat.com/mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-A4
http://people.redhat.com/mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-B3

Questions:

1) The 2.4.18-pre8 patch is from February 7th.  Is that really the latest one 
for straight 2.4?  If nobody's found even a typo in the thing for almost five 
months, can we expect it in 2.4.20-pre1?

2) Do the -ac patches bring the 2.4-mt O(1) up to the level that's in the -ac 
tree, or are they against the -ac tree itself?  I'd happily run the -ac tree 
except it doesn't HAVE stable releases, it has "it compiled" releases which 
do tend to be fairly stable but don't have nice clustering points where 
enough people are running that particular variant that they can tell you what 
the inevitable bugs actually are...

3) Is any of the stuff in ingo's directory actually the latest version?  I 
know he wrote it, but I've watched about five other people patch it (Robert 
Love, etc.), and I didn't keep close track at the time but I'm fairly certain 
it was more recent than February.

4) What's with the version numbers?  I don't THINK the "B3" patch backlevels 
K3 in a more recent -ac version, especially since "B3" is dated july and "K3" 
is dated february...  I seem to have missed a curve somewhere...

5) Huh?

Thanks,

Rob
