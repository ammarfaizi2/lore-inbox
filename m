Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTLCW2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTLCW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:28:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27915 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261606AbTLCW2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:28:42 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 22:17:32 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlnds$k45$1@gatekeeper.tmr.com>
References: <20031202002347.GD621@frodo> <bqlbuj$j03$1@gatekeeper.tmr.com> <200312032117.QAA20238@gatekeeper.tmr.com> <20031203214819.GD11065@ca-server1.us.oracle.com>
X-Trace: gatekeeper.tmr.com 1070489852 20613 192.168.12.62 (3 Dec 2003 22:17:32 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203214819.GD11065@ca-server1.us.oracle.com>,
Joel Becker  <Joel.Becker@oracle.com> wrote:

| 	Just another datapoint.  On my 300MHz PII laptop, ls and tab
| completion often hang, taking up 100% CPU on -test11.  2.4.19-pre3-ac2,
| my 2.4 kernel, doesn't even blip the CPU.

That's funny! I'm running 2.4.19-pre2-ac2 plus three patches which
solved something I'd have to rethink to describe. But most of my laptops
suspend fine with APM and 2.4, and suspend fine with 2.6 and ACPI but
never return to life... I realize APM is depreciated with 2.6, so I'm
resigned to 2.4 on those machines.

| 	That said, -test11 performs much better than 2.4.2[01], which
| used to pause the system entirely for 30 seconds or more.
| 	If there are any knobs I can turn to tweak this, I'm interested.

The last time I tried Nick's patches was on test15, there are only so
many hours in my day, and my best test machine is slow enough to
discourage building a lot of kernels. You might see if his version 15
patches will work on test11, or if test10-mm1 works better for you.
Since you're looking for knobs... You might also look at the swappiness
(/proc/sys/vm/swappiness) to see if that changes the stuff which bugs
you. 
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
