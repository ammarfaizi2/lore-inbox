Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRHFBDV>; Sun, 5 Aug 2001 21:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRHFBDM>; Sun, 5 Aug 2001 21:03:12 -0400
Received: from [63.209.4.196] ([63.209.4.196]:6928 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S266067AbRHFBCx>;
	Sun, 5 Aug 2001 21:02:53 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: /proc/<n>/maps getting _VERY_ long
Date: Mon, 6 Aug 2001 01:01:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9kkq9k$829$1@penguin.transmeta.com>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <20010806010738.B11372@unthought.net> <200108052341.f75Nfhx08227@penguin.transmeta.com> <20010805204143.A18899@alcove.wittsend.com>
X-Trace: palladium.transmeta.com 997059750 26670 127.0.0.1 (6 Aug 2001 01:02:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Aug 2001 01:02:30 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010805204143.A18899@alcove.wittsend.com>,
Michael H. Warfield <mhw@wittsend.com> wrote:
>On Sun, Aug 05, 2001 at 04:41:43PM -0700, Linus Torvalds wrote:
>
>> We could merge more, but I'm not interested in working around broken
>
>	If it only causes problems for the broken app, that's fine.  If it
>causes problems for the rest of the system, that could be bad.

It only causes problem for the broken app. Even then, the problem is a
(likely undetectable) slowdown, or in the extreme case the kernel will
just tell it that "Ok, you've allocated enough, no more soup for you".

		Linus
