Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTH1Cjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTH1Cjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:39:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49670 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263696AbTH1Cjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:39:37 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: linux-2.4.22 released
Date: 28 Aug 2003 02:31:04 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bijph8$pqq$1@gatekeeper.tmr.com>
References: <200308270610.h7R6Ajwt000277@81-2-122-30.bradfords.org.uk>
X-Trace: gatekeeper.tmr.com 1062037864 26458 192.168.12.62 (28 Aug 2003 02:31:04 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308270610.h7R6Ajwt000277@81-2-122-30.bradfords.org.uk>,
John Bradford  <john@grabjohn.com> wrote:

| Yes, of course, but the majority of desktop, workstations and server
| machines run whatever kernel their distribution supplies.
| 
| Within a year, a lot of distributions will start offering both 2.4 and
| 2.6.  The only reason to run the distribution's 2.4 kernel will be if
| the 2.6 one doesn't work on the user's hardware.  In that case, we
| will want to add support to/fix 2.6 as a priority, rather than adding
| support to 2.4.
| 

The "must have" feature of 2.4 was iptables. You simply can't do as good
a firwall or network device without stateful sockets. Other than device
drivers the kicker of 2.6 is crypto. If you need the features you really
will go.

Latency in 2.4 seems better, at least for some of the stuff I use, and I
see the new scheduler and NPTL are in the latest Redhat 2.4, so those
are not compelling for most people.

I would still like to see all the responsiveness features, VM, low
latency, preempt current. The O(1) scheduler is still getting better
daily in 2.6, about 2.4.25 that should be ready. Then when what we have
is working as well as it can, we can add features.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
