Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272341AbTGYSR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTGYSR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:17:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44301 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272341AbTGYSRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:17:53 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Date: 25 Jul 2003 18:25:29 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfrsmp$rc$1@gatekeeper.tmr.com>
References: <200307232046.46990.bernie@develer.com> <20030724050655.GA11947@beast> <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk> <20030724120441.GC16168@beast>
X-Trace: gatekeeper.tmr.com 1059157529 876 192.168.12.62 (25 Jul 2003 18:25:29 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030724120441.GC16168@beast>,
David McCullough  <davidm@snapgear.com> wrote:

| So should the trend be away from inlining,  especially larger functions ?
| 
| I know on m68k some of the really simple inlines are actually smaller as
| an inline than as a function call.  But they have to be very simple,  or
| only used once.

Actually, I would think that the compiler would make the decision in a
perfect world. (no smiley) Clearly some programmers think the compiler
isn't aggressive about this, and that may be the root problem. Certainly
if the compiler makes the choice then -Os should avoid the inline.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
