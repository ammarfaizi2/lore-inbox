Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTJIWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTJIWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:05:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11281 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262635AbTJIWFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:05:19 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
Date: 9 Oct 2003 21:55:37 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4lgp$6ir$1@gatekeeper.tmr.com>
References: <3F7CCEB8.8040803@spe.midco.net> <Pine.LNX.4.53.0310022146120.2108@montezuma.fsmlabs.com>
X-Trace: gatekeeper.tmr.com 1065736537 6747 192.168.12.62 (9 Oct 2003 21:55:37 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0310022146120.2108@montezuma.fsmlabs.com>,
Zwane Mwaikambo  <zwane@arm.linux.org.uk> wrote:
| On Thu, 2 Oct 2003, AG wrote:
| 
| > Hi 
| > 
| >  This is my first bug submission, so please have patience with my noobness :)
| 
| The general consensus is that you should be using the direct ATAPI 
| interface for cd-writing in 2.6. Be sure to get uptodate cdrtools and if 
| you want to use a gui, i hear k3b is able to grok the new interface. 

That's nice, but does that mean SCSI is being desupported? I only tried
one burn with test5, but that hung reset-button hard as well. My
controller works fine with my SCSI disks and tapes, I really don't want
to have to replace the CD burner.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
