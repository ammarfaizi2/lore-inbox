Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTJUSTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJUSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:19:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15123 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263267AbTJUSTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:19:17 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Circular Convolution scheduler
Date: 21 Oct 2003 18:09:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn3sob$ho6$1@gatekeeper.tmr.com>
References: <20031006161733.24441.qmail@email.com> <1066120643.25020.121.camel@www.piet.net> <20031014094655.GC24812@mail.shareable.org> <3F8BCAB3.2070609@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1066759755 18182 192.168.12.62 (21 Oct 2003 18:09:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F8BCAB3.2070609@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| I don't know anything about it, but I don't see what exactly you'd be
| trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
| obviously. Also, "best use of system resources" wrt scheduling is a big
| ask considering there isn't one ideal scheduling pattern for all but the
| most trivial loads, even on a single processor computer (fairness, latency,
| priority, thoughput, etc). Its difficult to even say one pattern is better
| than another.

I suspect that you've gotten hold of the wrong end of this stick... I
would assume that you start by stating which pattern is better, then use
the analysis to determine which of the possible actions is most likely
to make the pattern match the target. By pattern I mean response vs.
throughput, and similar tradeoffs.

This assumes:
 - that I understood what the o.p. meant
 - that the past is a useful predictor of the future


In any case, I think this scheduler proposal is interesting, I'd love to
see a working version.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
