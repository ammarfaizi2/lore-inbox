Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJXRZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJXRZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:25:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:268 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262419AbTJXRZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:25:01 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: 24 Oct 2003 17:14:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnbmmf$45r$1@gatekeeper.tmr.com>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <3F8CE3EB.8040907@storm.ca> <bnbi95$3qn$1@gatekeeper.tmr.com> <20031024165553.GB933@inwind.it>
X-Trace: gatekeeper.tmr.com 1067015695 4283 192.168.12.62 (24 Oct 2003 17:14:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031024165553.GB933@inwind.it>,
M. Fioretti <m.fioretti@inwind.it> wrote:
| On Fri, Oct 24, 2003 15:59:33 at 03:59:33PM +0000, bill davidsen (davidsen@tmr.com) wrote:
| 
| > | > If we can ensure that Linux keeps working on these machines, it
| > | > will be a good thing.
| > 
| > Agreed, until you start to talk cluster. If you pay for electricity,
| > newer machines use less per MHz. One of those $200 "Lindows" boxen
| > from Wal-Mart starts to look good about the 2nd old Pentium!
| 
| May I ask you to elaborate on this? Less per MHz doesn't matter much
| if the frequency is much higher, or it does? I mean, if you put, say,
| a 133 MHz pentium and a 1 GB pentium to do the same thing with the
| same SW (mail server, for example), the 1GB system may use less per
| MHz (newer silicon, lower voltage, etc...) and its flip-flops toggle
| for a smaller percentage of time, but its electricity bill will still
| be the higher one, or not?

Presumably a cluster exists to do more work than can be done on a single
machine. So a single cheap low power modern system will probably use a
lot less power to do equal work. Perhaps MHz was a poor choice, but we
don't really have a good single term for an arbitrary unit of computing
(AUC?) which is what I really meant there. At some point a cluster of
old slow machines doesn't scale financially, even if they are free.
Admin and repair tend to scale with units, networking is needed which
drives up the cost, even if time is free it's still finite.

| In general: has anybody ever done *this* kind of benchmarks? Comparing
| electricity consumption among different systems doing just the same
| task?

If same task means the same number of AUC, say web pages served,
probably you could find that somewhere. Or measure a 486, a P4 and a C3
compiling a kernel. If the 486 takes about 80 minutes (from memory
that's close), and a P4-2.6 takes about 8 minutes, then if the P4 takes
less than ten times the power of the 486 it would be more efficient in
terms of computations per watt. I have never compiled a kernel on the
C3, but I suspect it is at least 5x the 486 and takes much less power.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
