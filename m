Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRHSRd1>; Sun, 19 Aug 2001 13:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbRHSRdR>; Sun, 19 Aug 2001 13:33:17 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:52745 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S266921AbRHSRdH>;
	Sun, 19 Aug 2001 13:33:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 19 Aug 2001 17:29:55 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lot2j$pmg$2@abraham.cs.berkeley.edu>
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int> <Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho> <20010816131112.V31114@turbolinux.com> <998009344.664.72.camel@phantasy>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998242195 26320 128.32.45.153 (19 Aug 2001 17:29:55 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Aug 2001 17:29:55 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love  wrote:
>I put together a patch that addresses this, it allows the user to
>configure whether or not network devices contribute to the entropy pool.

Be careful.  Probably the right thing to do is to have network
devices contribute to the entropy pool but not to the entropy
count.  If you implement this policy, and use /dev/urandom, you
essentially get the best of both worlds, as far as I can see.
