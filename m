Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291555AbSBAFco>; Fri, 1 Feb 2002 00:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291556AbSBAFcf>; Fri, 1 Feb 2002 00:32:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291555AbSBAFcc>; Fri, 1 Feb 2002 00:32:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [lkml] Re: A modest proposal -- We need a patch penguin
Date: Fri, 1 Feb 2002 05:31:21 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a3d979$22g$1@penguin.transmeta.com>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil> <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there> <20020130224112.A25977@havoc.gtf.org> <9cfy9iefvbt.fsf@rogue.ncsl.nist.gov>
X-Trace: palladium.transmeta.com 1012541531 20075 127.0.0.1 (1 Feb 2002 05:32:11 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Feb 2002 05:32:11 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9cfy9iefvbt.fsf@rogue.ncsl.nist.gov>,
Ian Soboroff  <ian.soboroff@nist.gov> wrote:
>
>or, alternatively, "If you want *BSD, you know where to find it."  The
>funny thing is that the BSDs have all this hierarchy and whatnot, and
>they still fight about it.

I think the fact is that the grass is always greener somewhere else, and
all approaches have their problems. 

And it's always easier to point out problems with existing setups than
it is to come up with constructive changes. People end up wanting to
re-design everything, because that way they can make sure the problems
are gone - without really even knowing what new problems will appear
after a re-designed process.

The same thing happens in coding too, of course - you just _know_ you
can solve some problem by changing how something is done, and when you
actually code it up, you notice that "yes, I solved the problem", but
you also notice that "but now I have this other thing..". 

This is why trial-and-error is such a powerful way of doing things: try
many things, and yes, they all have their problems, but on the whole you
probably end up selecting the approaches where the problems are the
_least_ irritating.

The BIG problem with things like project management is that you simply
_cannot_ do lots of different trial-and-error things.  Sure, you can
try, and you'll get very Dilbertesque results: "The answer to all
problems: re-organize". 

Anyway, I'm actually personally willing to make small trials, and right
now I'm trying to see if it makes any difference if I try to use BK for
a month or two. I seriously doubt it will really "fix" everything, but
neither do I think big re-organizations and patch-lists will. But I'd be
stupid if I wasn't willing to try something.

(So far, trying out BK has only meant that I have spent _none_ of my
time merging patches and reading email, and most of my time writing
helper scripts and emails to Larry to make it possible to use BK in sane
ways that suit me. And I'll doubt you'll see any real productivity
increase from me for a while ;)

			Linus
