Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTJ1NTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTJ1NTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:19:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18949 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263961AbTJ1NTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:19:53 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: status of ipchains in 2.6?
Date: 28 Oct 2003 13:09:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnlpql$pmq$1@gatekeeper.tmr.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com> <20031028015032.734caf21.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1067346581 26330 192.168.12.62 (28 Oct 2003 13:09:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031028015032.734caf21.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
| On Mon, 27 Oct 2003 17:27:22 -0800
| David Mosberger <davidm@napali.hpl.hp.com> wrote:
| 
| > I recently discovered that ipchains is rather broken.  I noticed the
| > problem on ia64, but suspect that it's likely to affect all 64-bit
| > platforms (if not 32-bit platforms).  A more detailed description of
| > the problem I'm seeing is here:
| > 
| > 	http://tinyurl.com/sm9d
| > 
| > Unlike ipchains, iptables works perfectly fine, so perhaps we just
| > need to update Kconfig to discourage ipchains on ia64 (and/or other
| > 64-bit platforms)?
| 
| Might want to post this to the netfilter lists or netdev....
| Nah, that might actually get the bug fixed.
| 
| linux-kernel is always the wrong place to report networking
| problems, most networking developers do not read linux-kernel.
| They do read netdev@oss.sgi.com so please post things there.

The other side of the problem is that most people reading here don't
read netdev, so you don't trigger the "I have that too, and didn't
report it because I thought it was just me" replies. That's an imperfect
way to run the world, but it does reflect human nature.

I personally hesitate to post to netdev until I have really researched
a problem, as opposed to reporting that something working in testN
fails in test{N+1}. Given my free time, that often means that someone
else reports a bug (usually here) first.

Your continued reminders when appropriate are useful, perhaps an
occasional forward of a message would be as well.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
