Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271795AbRHUSfV>; Tue, 21 Aug 2001 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271793AbRHUSfD>; Tue, 21 Aug 2001 14:35:03 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:54534 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271790AbRHUSe2>;
	Tue, 21 Aug 2001 14:34:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Date: 21 Aug 2001 18:31:15 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu9dj$n5v$7@abraham.cs.berkeley.edu>
In-Reply-To: <606175155.998387452@[169.254.45.213]> <Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998418675 23743 128.32.45.153 (21 Aug 2001 18:31:15 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:31:15 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang  wrote:
>so as I see this discussion it goes something like this.
>
>1. the entropy pool is not large enough on headless machines.
>2. you don't want to use urandom as there are theoretical attacks against
>it

If that's the concern, then I'm glad to say that I have very reassuring
news for you.  No attacks are known on /dev/urandom, not even theoretical
ones.

(And no attack is known on SHA-1, not even a theoretical one.)

(Don't confuse a remote risk that someone might discover a theoretical
attack on SHA-1 with knowledge that we already know of a theoretical
attack on SHA-1.)
