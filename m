Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271790AbRHUSha>; Tue, 21 Aug 2001 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271803AbRHUShX>; Tue, 21 Aug 2001 14:37:23 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:56838 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271790AbRHUShK>;
	Tue, 21 Aug 2001 14:37:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: 21 Aug 2001 18:33:56 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu9ik$n5v$8@abraham.cs.berkeley.edu>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com> <20010820211107.A20957@thunk.org> <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca> <3B822D2E.69D4380A@evision-ventures.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998418836 23743 128.32.45.153 (21 Aug 2001 18:33:56 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:33:56 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki  wrote:
>Multiple initializations help only against cryptographic attacks - but
>THEY HURT overall security of the system, becouse they "open it up".

Either I completely misunderstood what you are trying to say, or your
claim is simply not true.  I've done considerable research on generating
randomness for cryptography, and I think you're a little confused about
how /dev/{,u}random work and about their cryptographic properties.
