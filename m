Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTKFSvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTKFSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:51:18 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31242 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263135AbTKFSvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:51:16 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: 6 Nov 2003 18:40:49 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boe4jh$ett$1@gatekeeper.tmr.com>
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031031112615.GA10530@k3.hellgate.ch> <200310310755.36224.edt@aei.ca>
X-Trace: gatekeeper.tmr.com 1068144049 15293 192.168.12.62 (6 Nov 2003 18:40:49 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310310755.36224.edt@aei.ca>, Ed Tomlinson  <edt@aei.ca> wrote:

| With 2.6 its possible to tell the kernel how much to swap.  Con's patch
| tries to keep applications in memory.  You can also play with 
| /proc/sys/vm/swappiness which is what Con's patch tries to replace.

I added Nick's sched and io patches to Con's patch on test9, and it
looked stable under load. But I'm (mostly) on vacation this week, so it
isn't being tested any more. My responsiveness test didn't show it to be
as good as 2.4, unfortunately.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
