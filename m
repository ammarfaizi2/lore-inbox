Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264581AbTLQV6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbTLQV6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:58:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45837 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264581AbTLQV6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:58:44 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Date: 17 Dec 2003 21:47:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brqit0$7p7$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.21.0312171721420.32339-100000@needs-no.brain.uni-freiburg.de> <200312171141.18132.gene.heskett@verizon.net> <20031217164933.GB2495@suse.de> <200312171227.53913.gene.heskett@verizon.net>
X-Trace: gatekeeper.tmr.com 1071697632 7975 192.168.12.62 (17 Dec 2003 21:47:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200312171227.53913.gene.heskett@verizon.net>,
Gene Heskett  <gene.heskett@verizon.net> wrote:

| I'm using /dev/hdc for burning in the k3b configuration screens, 
| however that path may actually be defined.  I haven't quite "grok"ed 
| all the details, but it works, and works with <10% of the cpu 
| involved when burning.
| 
| To me, thats a roaring success :-)

I'm burning on a 2.4 kernel, using ide-scsi, and taking <1% CPU at 16x
burn, so you might check if your CD is set to use DMA, or if it's still
doing PIO. I use about 10% doing an audio burn, which does use PIO in
2.4 AFAIK.

You may be able to drop the CPU a good bit more.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
