Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTLCRVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTLCRVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:21:08 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35338 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265100AbTLCRVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:21:04 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: 3 Dec 2003 17:09:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bql5d3$id4$1@gatekeeper.tmr.com>
References: <3FCD21E1.5080300@netzentry.com> <1070411338.2452.66.camel@athlonxp.bradney.info> <3FCD32F5.2050002@gmx.de>
X-Trace: gatekeeper.tmr.com 1070471395 18852 192.168.12.62 (3 Dec 2003 17:09:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FCD32F5.2050002@gmx.de>,
Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
| > smp off, preempt off. lapic on, apic on, acpi on
| 
| Why haven't you enabled preempt? Does it lock with preempt on?

I haven't found preempt to cause problems with my applications, but
neither have I seen any significant gain in throughput or responsiveness
in 2.6. I did see small gains in 2.4, but not enough to motivate me to
add the feature as a patch or even, in 2.6, enable it as an option.

I don't know about the original poster, but the reports of problems
discourage exploration unless the application is likely to benefit from
slight gains in response and to have multiple tasks of different
priority running.

Have you seen a benefit from preempt? And if so, what application and
how much? I may not be doing anything which benefits from preempt enough
to notice (news, mail and dns servers, desktops), but other than dns on
2.4 I haven't seen improvement.

enlightenmet, please?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
