Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313914AbSDUWU2>; Sun, 21 Apr 2002 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313916AbSDUWU1>; Sun, 21 Apr 2002 18:20:27 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:39946 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S313914AbSDUWU1>; Sun, 21 Apr 2002 18:20:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: SSE related security hole
Date: 21 Apr 2002 22:11:13 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a9vde1$285$1@abraham.cs.berkeley.edu>
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com> <Pine.LNX.3.95.1020418144215.30908A-100000@chaos.analogic.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1019427073 2309 128.32.45.153 (21 Apr 2002 22:11:13 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Apr 2002 22:11:13 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>Well, if what's on the internal stack of the FPU can actually leak
>information, I think the notion of "leak" has expanded just a bit
>too much.

Note that some crypto implemenations use the FPU heavily to speed up
the encryption process.  Thus, if FPU data can leak, secret keys are
at risk.  I don't know about you, but that doesn't sound good to me.
