Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTHSUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTHSUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:06:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6418 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261358AbTHSUGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:06:09 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: 19 Aug 2003 19:57:57 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bhtvg5$8t1$1@gatekeeper.tmr.com>
References: <20030819191010.43d83b79.skraw@ithnet.com> <20030819100712.2470d18d.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1061323077 9121 192.168.12.62 (19 Aug 2003 19:57:57 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030819100712.2470d18d.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
| On Tue, 19 Aug 2003 19:10:10 +0200
| Stephan von Krawczynski <skraw@ithnet.com> wrote:
| 
| > Well, then you have a problem, at least with RFC-985 as quoted in my other
| > email.
| 
| RFC-985 does not take into consideration a system model where IP
| addresses are owned by the host not specific interfaces which is a
| valid system model that the RFC standards allow.

No one who has read the RFC would argue that the current implementation
is wrong, what people are saying is that in many common case it just
doesn't bloody *work*!

To say that the solution for common cases is to set a bunch of flags and
run source routing is not going to make the endless discussion,
complaints, and really bad patches go away. Why are you opposed to
having a tunable to allow *easy* selection of the functionality which is
needed by many people, particularly when you have stated that such
behaviour also conforms to RFCs?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
