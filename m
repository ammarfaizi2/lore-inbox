Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLQQmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTLQQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:42:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65036 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264464AbTLQQmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:42:18 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Date: 17 Dec 2003 16:30:46 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brq0bm$69i$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
X-Trace: gatekeeper.tmr.com 1071678646 6450 192.168.12.62 (17 Dec 2003 16:30:46 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>,
Thomas Voegtle  <thomas@voegtle-clan.de> wrote:
| 
| Hello,
|   
| cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows this:
|   
| scsibus0:
|         0,0,0     0) '' '' '' NON CCS Disk
|         0,1,0     1) '' '' '' NON CCS Disk
| 
|   
| but this works well with 2.6.0-test11.
| =>
|   
|         0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable CD-ROM
|         0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable CD-ROM
|   
| SuSE 9.0
|   
| please cc me, I'm not subscribed

I see the same results, also using wli-2. I'll try mm1 as soon as it
completes compilation.

I assume that this breakage is unintentional, but it's not clear if it's
a bug in the kernel or cdrecord not coping with something actually fixed
in the kernel.

I may get a chance to look at it tomorrow, I don't think I have a stock
test11 kernel left :-(
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
