Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTJ1Sk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTJ1Sk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:40:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1798 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261240AbTJ1Skz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:40:55 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Blockbusting news, results end
Date: 28 Oct 2003 18:30:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnmckj$r90$1@gatekeeper.tmr.com>
References: <785F348679A4D5119A0C009027DE33C105CDB3CA@mcoexc04.mlm.maxtor.com>
X-Trace: gatekeeper.tmr.com 1067365843 27936 192.168.12.62 (28 Oct 2003 18:30:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <785F348679A4D5119A0C009027DE33C105CDB3CA@mcoexc04.mlm.maxtor.com>,
Mudama, Eric <eric_mudama@Maxtor.com> wrote:
| 
| 
| > -----Original Message-----
| > From: Norman Diamond

| > It is really hard to imagine a physical sector still being 
| > 512B because the inter-sector gaps would take some huge
| > multiple of the space occupied by the sectors.
| 
| We measure these gaps in nanoseconds.  They're not that huge.  But yes,
| moving to a larger standard sector size would get you a significantly larger
| disk drive built from the same parts.

Given that we did that back in the CP/M days (late 70's) on floppy, and
with MFM, RLL and finally SCSI drives in the 70's, I would hope that
current drives use large sectors since the drive now has local cache
and doesn't need a fancy driver to do the caching!

| > I'm sure the physical sectors are not 512B.
| 
| I'm sure you're wrong.
| 
| I'd imagine that since Seagate and WD and Maxtor are constantly duking it
| out to release the next generation of capacity, and we all wind up producing
| nearly-identical products when all is said and done, that they're using 512B
| data sectors also.

Given that the IRG is fixed size regardless of sector size, I certainly
hope I misread what you say or you are incorrect. The difference
between 512B and 4KB sectors should be about 20-40% added capacity per
track (seven IRG sizes). I would expect large sectors would be
standard.

We used to diddle interleave when formatting as well, until we put full
track caching in the device driver.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
