Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264055AbTKGWCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTKGWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:02:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46860 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264406AbTKGPYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:24:34 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Suspend to disk panicked in -test9.
Date: 7 Nov 2003 15:14:06 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bogcru$l3g$1@gatekeeper.tmr.com>
References: <200310291857.40722.rob@landley.net>
X-Trace: gatekeeper.tmr.com 1068218046 21616 192.168.12.62 (7 Nov 2003 15:14:06 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310291857.40722.rob@landley.net>,
Rob Landley  <rob@landley.net> wrote:
| Unfortunately, while I was writing down the panic on a piece of paper, the 
| screen blanking code kicked in while I was still copying down the register 
| values.  I remember that the call trace mentioned some variant of a 
| write_stuff_to_disk call, but that's not that useful...
| 
| When is the last time that the screen blanking code actually accomplished 
| something useful?  These days it seems to exist for the purpose of destroying 
| panic call traces and annoying people.  (I seem to remember that pressing a 
| key used to make it come back, but now we're forced to use the input core 
| that no longer seems to be the case...)
| 
| I also seem to remember a patch floating by on the list that would make 
| console screen blanking go away.  I really think console screen blanking NOT 
| being enabled should be the default these days.  Or at the very least, when 
| there's a panic it should get shut off.  I'll add looking into that to my 
| to-do list, but will probably get to it somewhere around 2009...

Or people who want it that way could put the setterm call in their
rc.local, of course. No patches required and the rest of the world
doesn't have to turn it on.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
