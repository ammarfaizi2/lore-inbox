Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbTIHTtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTIHTtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:49:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6158 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263514AbTIHTta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:49:30 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Scaling noise
Date: 8 Sep 2003 19:40:36 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjilvk$9a1$1@gatekeeper.tmr.com>
References: <20030904015249.GF5227@work.bitmover.com> <20030903214233.24d3c902.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1063050036 9537 192.168.12.62 (8 Sep 2003 19:40:36 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030903214233.24d3c902.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
| On Wed, 3 Sep 2003 18:52:49 -0700
| Larry McVoy <lm@bitmover.com> wrote:
| 
| > On Thu, Sep 04, 2003 at 03:50:31AM +0200, Daniel Phillips wrote:
| > > There are other arguments, such as how complex locking is, and how it will 
| > > never work correctly, but those are noise: it's pretty much done now, the 
| > > complexity is still manageable, and Linux has never been more stable.
| > 
| > yeah, right.  I'm not sure what you are smoking but I'll avoid your dealer.
| 
| I hate to enter these threads but...
| 
| The amount of locking bugs found in the core networking, ipv4, and
| ipv6 for a year or two in 2.4.x has been nearly nil.
| 
| If you're going to try and argue against supporting huge SMP
| to me, don't make locking complexity one of the arguments. :-)

If you count only "bugs" which cause hang or oops, sure. But just
because something works doesn't make it simple (or non-complex if you
prefer). But look at all the "lockless" changes and such in 2.4, and I
think you will agree that there have been a number and it is complex. I
don't think stable and complex are mutually exclusive in this case.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
