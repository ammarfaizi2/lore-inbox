Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277253AbRJ3SP4>; Tue, 30 Oct 2001 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277317AbRJ3SPq>; Tue, 30 Oct 2001 13:15:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57617 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277330AbRJ3SPd>; Tue, 30 Oct 2001 13:15:33 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.14-pre4 tainted + preempt oops...
Date: Tue, 30 Oct 2001 18:13:33 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rmqkd$bn9$1@penguin.transmeta.com>
In-Reply-To: <200110301018.LAA17404@lambik.cc.kuleuven.ac.be>
X-Trace: palladium.transmeta.com 1004465738 9188 127.0.0.1 (30 Oct 2001 18:15:38 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Oct 2001 18:15:38 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110301018.LAA17404@lambik.cc.kuleuven.ac.be>,
Frank Dekervel  <Frank.dekervel@student.kuleuven.ac.Be> wrote:
>
>i know oopses from tainted kernels are probably the result of a broken 
>proprietary module, but this oops seems related with VM or preempt or so..
>the kernel was tainted with vmware and nvidia modules, i'll try to reproduce 
>without them now.

Don't bother, just get pre5. It's a bug in pre4, no blame on vmware or
even nVidia.

		Linus
