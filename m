Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRH3Xhi>; Thu, 30 Aug 2001 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272560AbRH3Xh3>; Thu, 30 Aug 2001 19:37:29 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:56588 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S272559AbRH3XhO>;
	Thu, 30 Aug 2001 19:37:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: 30 Aug 2001 23:33:52 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9mmih0$qvb$1@abraham.cs.berkeley.edu>
In-Reply-To: <200108302044.f7UKi7c20040@wildsau.idv-edu.uni-linz.ac.at> <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 999214432 27627 128.32.45.153 (30 Aug 2001 23:33:52 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 30 Aug 2001 23:33:52 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>The min() macro is not really used for the mathematical min, anywhere
>I've found it in the kernel. It's used as a whatever_will_fit() macro
>where the writer wanted to prevent a buffer overflow. [...]
>
>I suggest we just leave the damn thing alone and fix any
>bugs found in the normal way, i.e., "If it ain't broke, don't fix it."

The problem is that this tends not to work out so well when it
comes to security.  Patch-and-pray gets pretty painful after a
while; proactive measures would seem to be called for, if security
is on the line.
