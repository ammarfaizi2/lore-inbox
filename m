Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271783AbRHUSdM>; Tue, 21 Aug 2001 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271789AbRHUScv>; Tue, 21 Aug 2001 14:32:51 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:53766 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271783AbRHUSct>;
	Tue, 21 Aug 2001 14:32:49 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Date: 21 Aug 2001 18:29:36 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu9ag$n5v$6@abraham.cs.berkeley.edu>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com> <606175155.998387452@[169.254.45.213]>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998418576 23743 128.32.45.153 (21 Aug 2001 18:29:36 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:29:36 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel  wrote:
>For clarity, I'm saying Robert's patch is GOOD, and those who are trying
>to point out what I consider to be extremely theoretical weakness it
>introduces into /dev/random (and then, only when config'd on), [...]

That's one place where we disagree.  Over-estimating entropy is not a
theoretical weakness: this is something that real cryptographers get real
worried about.  It's one of the easiest ways for a crypto system to fail.
