Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRLGMcs>; Fri, 7 Dec 2001 07:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277532AbRLGMci>; Fri, 7 Dec 2001 07:32:38 -0500
Received: from 24-28-205-10.mf3.cox.rr.com ([24.28.205.10]:8196 "EHLO
	24-28-205-10.mf3.cox.rr.com") by vger.kernel.org with ESMTP
	id <S276369AbRLGMcZ>; Fri, 7 Dec 2001 07:32:25 -0500
To: linux-kernel@vger.kernel.org
Path: 24-28-205-10.mf3.cox.rr.com!not-for-mail
From: gsh@cox.rr.com (Greg Hennessy)
Newsgroups: list.linux
Subject: Re: horrible disk thorughput on itanium
Date: Fri, 7 Dec 2001 12:32:23 +0000 (UTC)
Organization: A InterNetNews site
Message-ID: <9uqcsn$270$1@24-28-205-10.mf3.cox.rr.com>
In-Reply-To: <9upmqm$7p4$1@penguin.transmeta.com>
NNTP-Posting-Host: localhost
X-Trace: 24-28-205-10.mf3.cox.rr.com 1007728343 2273 127.0.0.1 (7 Dec 2001 12:32:23 GMT)
X-Complaints-To: news@24-28-205-10.mf3.cox.rr.com
NNTP-Posting-Date: Fri, 7 Dec 2001 12:32:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9upmqm$7p4$1@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> wrote:
> Isn't somebody ashamed of glibc and willing to try to fix it? It might
> be as simple as just testing a static flag "have I used pthread_create"
> or even a function pointer that gets switched around at pthread_create..

As the person who started this thread, I'll say that I'm willing to
test new alternatives, Redhat engineers gave me a newer kernel to see
if it helped (it didn't) and if someone can give me (or point me to) a
glibc with better io I'm glad.

Right now I have to explain to my boss why my $4K pentium computers do
io faster than my $20K itanium computer. And since our major software
code is 3rd party, we can't rewrite the appilcation.




