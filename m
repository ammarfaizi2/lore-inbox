Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTJUU5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTJUU5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:57:02 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22532 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263380AbTJUU4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:56:51 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
Date: 21 Oct 2003 20:46:49 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn45vp$itf$1@gatekeeper.tmr.com>
References: <20031021131915.GA4436@rushmore> <20031021135221.GA22633@localhost> <20031021143741.GB22633@localhost>
X-Trace: gatekeeper.tmr.com 1066769209 19375 192.168.12.62 (21 Oct 2003 20:46:49 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031021143741.GB22633@localhost>,
Marco Roeland  <marco.roeland@xs4all.nl> wrote:
| On Tuesday October 21st 2003 at 15:52 uur Marco Roeland wrote:
| 
| > > http://marc.theaimsgroup.com/?l=linux-kernel&m=106651554401143&w=2
| > > 
| > > It's supposed to fix test8 compile with gcc-2.96 for RedHat 7.x.
| > 
| > Perhaps if the huge sprintf with 40+ arguments (fs/proc/array.c, line 346)
| > amongst which several trinary operators, were to be split up into several
| > parts, might that not solve the problem more elegantly?
| 
| Does this compile (and work) for any of you friendly RedHat 7.[23] users? 
| In 2.6.0-test8 yet another argument was added to the monstrous sprintf.
| Perhaps this was just the droplet to overflow gcc-2.96's buckets? Here we
| split it into 3 distinct parts.

Thank you!
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
