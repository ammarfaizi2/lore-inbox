Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271788AbRHUSbl>; Tue, 21 Aug 2001 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271783AbRHUSbE>; Tue, 21 Aug 2001 14:31:04 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:51462 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271788AbRHUSak>;
	Tue, 21 Aug 2001 14:30:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 21 Aug 2001 18:27:27 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu96f$n5v$5@abraham.cs.berkeley.edu>
In-Reply-To: <605512235.998386789@[169.254.45.213]> <Pine.LNX.4.33.0108211212570.20625-100000@Megathlon.ESI>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998418447 23743 128.32.45.153 (21 Aug 2001 18:27:27 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:27:27 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo  wrote:
>A little question: I used to believe that crypto software requires
>strong random source to generate key pairs, but this requirement in
>not true for session keys.

It is true for session keys, too.  Session keys should not be guessable,
so you must use an unpredictable source for them.  Fortunately,
/dev/urandom is essentially just as good as /dev/random in this respect.
