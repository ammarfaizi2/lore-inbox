Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSBRVve>; Mon, 18 Feb 2002 16:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSBRVv1>; Mon, 18 Feb 2002 16:51:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60427 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S287966AbSBRVvM>; Mon, 18 Feb 2002 16:51:12 -0500
Date: Mon, 18 Feb 2002 16:50:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Michael Cohen <me@ohdarn.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre9-mjc2 compile errors
In-Reply-To: <1014064227.18406.1.camel@ohdarn.net>
Message-ID: <Pine.LNX.3.96.1020218162444.13294A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2002, Michael Cohen wrote:

> On Mon, 2002-02-18 at 13:25, root@deathstar.prodigy.com wrote:
> > filemap.c: In function `__find_page_nolock':
> > filemap.c:404: structure has no member named `next_hash'
> > make[2]: *** [filemap.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux/mm'
> > make[1]: *** [first_rule] Error 2
> > make[1]: Leaving directory `/usr/src/linux/mm'
> > make: *** [_dir_mm] Error 2
> 
> There was a fix posted to lkml earlier, though I'd say that likely if
> you can't fix this, you don't need to run this kernel. try looking at
> lkml.  Next version will have it fixed, however. =)

I didn't ask for a fix, I was offering a problem report, from a machine
with no lkml or anything else (don't let the name and IP fool you, I was
testing). I was trying to add it to my summary of recent kernels which run
well on small slow machines which might be available for the asking.

I included the config because I thought the P5 might be triggering a
problem others hadn't tested, but it looks as if everyone had the problem.
I thought these were like -ac patches which has already been tested to see
if they compile.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

