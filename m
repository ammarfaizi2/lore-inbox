Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTJFCjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 22:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTJFCjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 22:39:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25349 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263922AbTJFCjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 22:39:09 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Date: 6 Oct 2003 02:29:31 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blqk2b$dbr$1@gatekeeper.tmr.com>
References: <20031001032238.GB1416@Master> <20031001051008.GD1416@Master> <blfi1h$jd0$1@gatekeeper.tmr.com> <3F7B5584.6070604@wmich.edu>
X-Trace: gatekeeper.tmr.com 1065407371 13691 192.168.12.62 (6 Oct 2003 02:29:31 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F7B5584.6070604@wmich.edu>,
Ed Sweetman  <ed.sweetman@wmich.edu> wrote:
| bill davidsen wrote:

| > I wish I could just write off programs like that, but if a program is
| > running, and doing legitimate system calls, and it stops running
| > (totally or usefully), I'd like to be sure that the kernel doesn't have
| > some unintended behaviour before I just pass on the program.
| > 
| > Particularly when OO is what allows lots of people to avoid running that
| > other operating system.
| 
| it isn't doing something legitimate since as he said, it was the only 
| program that exibited the behavior. Perhaps openoffice was exploiting a 
| characteristic of the old schedular to increase it's performance, 
| perhaps it's just the way they ended up coding it.  But if it's the only 
| one then that's that.

I see nothing to indicate that any illegal system calls were made, in
what way is it not doing something legitimate?

One program which has always worked suddenly stopping is a symptom of a
problem, and assuming that there is no problem seems optimistic.
Particularly when it works on BSD, Solaris, all previous Linux and even
Windows.

If this is the sched_yeild() stuff again, I thought that was beaten into
the ground before, and it was agreed that SUS allows it to work the way
it has always worked and the way it works elsewhere. Hopefully this is
not the reason performance is so grim, and a solution can be found.

BTW: I'm told that StarOffice (commercial release) also doesn't work
usefully on test6, can anyone confirm? The test system is not overly
stable and I don't trust negative results there.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
