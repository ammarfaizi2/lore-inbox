Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270321AbRHHFCH>; Wed, 8 Aug 2001 01:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270320AbRHHFB5>; Wed, 8 Aug 2001 01:01:57 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:45073 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S270321AbRHHFBn>;
	Wed, 8 Aug 2001 01:01:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: summary Re: encrypted swap
Date: 8 Aug 2001 04:58:42 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9kqgu2$oi6$1@abraham.cs.berkeley.edu>
In-Reply-To: <fa.g4fleqv.1mle133@ifi.uio.no> <Pine.GSO.4.31.0108071419300.2838-100000@cardinal0.Stanford.EDU> <9kq1v4$ku7$1@abraham.cs.berkeley.edu> <3B70B241.40908@kalifornia.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 997246722 25158 128.32.45.153 (8 Aug 2001 04:58:42 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 8 Aug 2001 04:58:42 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Ford  wrote:
>David Wagner wrote:
>>You missed some scenarios.  Suppose I run a server that uses crypto.
>>If swap is unencrypted, all the session keys for the past year might
>>be laying around on swap.  If swap is encrypted, only the session keys
>>since the last boot are accessible, at most.  Therefore, using encrypted
>>swap clearly reduces the impact of a compromise of your machine (whether
>>through theft or through penetration).  This is a good property.
>
>Wiping swap on boot will achieve the same effect.

No, it won't.  Or rather: Yes, it would, if you could erase data
reliably, but it's not clear that you can.  Once again, please see
Peter Gutmann's paper on the difficulty of erasing data reliably.
