Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTI2SzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTI2SzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:55:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16401 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264455AbTI2SzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:55:20 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test6
Date: 29 Sep 2003 18:45:52 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bl9ul0$348$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1064861152 3208 192.168.12.62 (29 Sep 2003 18:45:52 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F77BB2C.7030402@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| AFAIK, Con's scheduler doesn't change the nice implementation at all.
| Possibly some of his changes amplify its problems, or, more likely they
| remove most other scheduler problems leaving this one noticable.
| 
| If X is running at -20, and xmms at +19, xmms is supposed to still get
| 5% of the CPU. Should be enough to run fine. Unfortunately this is
| achieved by giving X very large timeslices, so xmms's scheduling latency
| becomes large. The interactivity bonuses don't help, either.

Clearly the "some is good, more is better" approach doesn't provide
stable balance between sound and cpu hogs. It isn't a question of "how
much" cpu, just "when"which works or not.

This is sort of like the deadline scheduler in that it trades of
throughput for avoiding jackpot cases. I think that's desired behaviour
in a CPU schedular too, at least if used by humans.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
