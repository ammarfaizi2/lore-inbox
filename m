Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTI2WIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTI2WIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:08:04 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56337 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263008AbTI2WIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:08:01 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: PROBLEM: kernel 2.6-test5 rmmod: kernel NULL pointer dereference
Date: 29 Sep 2003 21:58:34 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bla9ua$49p$1@gatekeeper.tmr.com>
References: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org> <20030928131511.A2490@ss1000.ms.mff.cuni.cz>
X-Trace: gatekeeper.tmr.com 1064872714 4409 192.168.12.62 (29 Sep 2003 21:58:34 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030928131511.A2490@ss1000.ms.mff.cuni.cz>,
Rudo Thomas  <thomr9am@ss1000.ms.mff.cuni.cz> wrote:
| > I wrote a CD so I did a modprobe ide-scsi ..
| 
| I believe you should not be using ide-scsi in 2.6.0-test at all. ide-cd should
| suffice if you have recent cdrtools.

You are correct that recent cdrecord can use devices without ide-scsi,
but if you are running both 2.4 and 2.6 your really avoid a lot of
config changes to just use ide-scsi all the time. And for other ATAPI
devices ide-scsi is still easier than rewriting applications to use the
new interface. SCSI-only code works with fewer portability issues.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
