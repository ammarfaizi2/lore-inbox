Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRHTQEC>; Mon, 20 Aug 2001 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271235AbRHTQDx>; Mon, 20 Aug 2001 12:03:53 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:3087 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271331AbRHTQDm>;
	Mon, 20 Aug 2001 12:03:42 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 20 Aug 2001 16:00:30 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lrc6u$6pv$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998323230 6975 128.32.45.153 (20 Aug 2001 16:00:30 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 20 Aug 2001 16:00:30 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel  wrote:
>OK; well in which case it doesn't solve the problem.

I don't see why not.  Apply this change, and use /dev/urandom.
You'll never block, and the outputs should be thoroughly unpredictable.
What's missing?

(I don't see why so many people use /dev/random rather than /dev/urandom.
I harbor suspicions that this is a misunderstanding about the properties
of pseudorandom number generation.)
