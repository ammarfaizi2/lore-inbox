Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbTLHQJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTLHQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:09:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51205 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265489AbTLHQJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:09:13 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Date: 8 Dec 2003 15:57:54 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br2722$f9q$1@gatekeeper.tmr.com>
References: <20031206024251.GG8039@holomorphy.com> <20031206050908.GL8039@holomorphy.com> <1070687655.1166.6.camel@chevrolet.hybel> <20031206054031.GM8039@holomorphy.com>
X-Trace: gatekeeper.tmr.com 1070899074 15674 192.168.12.62 (8 Dec 2003 15:57:54 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031206054031.GM8039@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:

| The real problem with all this is that it was arranged around minimal
| impact code changes instead of adequately describing hardware, and so
| it gives rise to numerous corner cases and is generally brittle. Of
| course, 2.6 is too frozen to do anything with it now, and ia32 will
| likely be largely legacy during the course of 2.7, so the damage will
| probably be permanent.

  I don't follow your thinking here, 2.6.0 is certainly frozen, but I
see no reason this can't be fixed in 2.6 if someone cares to do so. The
amount of code is small, and as long as the interrupt gets serviced by
exactly one CPU I doubt the performance could get worse.

  I don't see ia32 going away, either, unless you see 2.7 in a more
distant timeframe than I do. Looking at the power issue I predict
significant ia32 in laptops, and due to cost issues in desktops and
servers. Also, I suspect that Linux hackers have a much higher
percentage of SMP ia32 machines than the general public, which
encourages enhancements in that area.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
