Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTHSTyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHSTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:54:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:530 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261338AbTHSTug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:50:36 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: 19 Aug 2003 19:42:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bhtuj0$8oh$1@gatekeeper.tmr.com>
References: <1061317825.3744.7.camel@athena.fprintf.net> <20030819112912.359eaea6.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1061322144 8977 192.168.12.62 (19 Aug 2003 19:42:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030819112912.359eaea6.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
| On 19 Aug 2003 14:30:26 -0400
| Daniel Gryniewicz <dang@fprintf.net> wrote:
| 
| > If you are not on a shared lan, then it will *ONLY* work if linux is
| > on the other end.  No other system will work.
| 
| And these other systems are broken.  (actually, older Cisco equipment
| correctly responds to the ARP regardless of source IP)
| 
| Just because some Cisco engineer says that it is correct doesn't
| make it is.

What you say is true, but in the real world being able to work with the
most commonly used network hardware is a hard requirement. When
"conforms to RFC" colides with "works" there's an issue, particularly
when the RFC allows several behaviours (bad RFC!).

I would hope that it is possible to get a single flag to force all
packets out of a NIC configured with the source IP in the packet, I
don't feel the need to make that the default behaviour, just to find
some alternative to patches or source routing.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
