Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSBSBT7>; Mon, 18 Feb 2002 20:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSBSBTr>; Mon, 18 Feb 2002 20:19:47 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:50822 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S289166AbSBSBTl>;
	Mon, 18 Feb 2002 20:19:41 -0500
Subject: Re: 2.4.18-pre9-mjc2 compile errors
From: Michael Cohen <me@ohdarn.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davidsen@tmr.com
In-Reply-To: <Pine.LNX.3.96.1020218162444.13294A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020218162444.13294A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 20:19:37 -0500
Message-Id: <1014081580.21495.3.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-18 at 16:50, Bill Davidsen wrote:
> On 18 Feb 2002, Michael Cohen wrote:
> 
> > On Mon, 2002-02-18 at 13:25, root@deathstar.prodigy.com wrote:
> > > filemap.c: In function `__find_page_nolock':
> > > filemap.c:404: structure has no member named `next_hash'
> > > make[2]: *** [filemap.o] Error 1
> > > make[2]: Leaving directory `/usr/src/linux/mm'
> > > make[1]: *** [first_rule] Error 2
> > > make[1]: Leaving directory `/usr/src/linux/mm'
> > > make: *** [_dir_mm] Error 2
> > 
> > There was a fix posted to lkml earlier, though I'd say that likely if
> > you can't fix this, you don't need to run this kernel. try looking at
> > lkml.  Next version will have it fixed, however. =)
> 
> I didn't ask for a fix, I was offering a problem report, from a machine
> with no lkml or anything else (don't let the name and IP fool you, I was
> testing). I was trying to add it to my summary of recent kernels which run
> well on small slow machines which might be available for the asking.
> 
> I included the config because I thought the P5 might be triggering a
> problem others hadn't tested, but it looks as if everyone had the problem.
> I thought these were like -ac patches which has already been tested to see
> if they compile.
Sorry, I wasn't in too great of a mood.  Didn't mean to sound *that*
rough.  Anyways, I had just started using bitkeeper, and the change
didn't get committed properly, so it fell out of my bk tree when I made
the patch.  It had been tested mostly though.  I started using a much
more inclusive test .config though; and I'll have a working next
release.  Take a look at how well 2.5 currently compiles though =)

Fix is to remove the function __find_page_nolock from mm/filemap.c.

------
Michael Cohen
OhDarn.net

