Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbTLHEWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTLHEWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:22:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48900 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265328AbTLHEWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:22:32 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Hyperthreading Patch Results
Date: 8 Dec 2003 04:11:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br0tl3$cas$1@gatekeeper.tmr.com>
References: <119145131687.20031206041918@webspires.com>
X-Trace: gatekeeper.tmr.com 1070856675 12636 192.168.12.62 (8 Dec 2003 04:11:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <119145131687.20031206041918@webspires.com>,
Russell \"Elik\" Rademacher <elik@webspires.com> wrote:
| Hello linux-kernel,
| 
|   Okay folks.  I have installed it on 28 production servers with that patch contributed by William Lee Irwin III including Dell Servers and 2 Compaq servers among other types of hardware with 3ware, MPT SCSI, straight IDE, MylexRaid in the mix.  I have reported no problems with them and they all correctly reported the HyperThreading CPUs.  Previous versions since 2.4.21 have problems reporting the Hyperthreaded Dual Xeons and report it as 2 CPUs instead of 4.
| 
|   So..I recommend this patch being pushed to 2.4.x tree for inclusion.

Marcello has announced a freeze on any new features in 2.4, so unless
this is considered a bug fix it may not get in.

More to the point, unless Ingo's new HT scheduler changes are accepted
at the same time, I'm not sure this is going to help most people. I will
let people discuss that or not as they please, based on reports of HT
performance, there may actually be regression. I have not tries this
with 2.4 yyet, so I can't say.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
