Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUBHDaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBHDaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:30:25 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:56843 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S261890AbUBHDaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:30:19 -0500
Date: Sat, 7 Feb 2004 22:09:14 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec aic7xxx driver problems?
Message-ID: <20040208030914.GE10344@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there known issues with the Adaptec drivers on x86 systems?

Since upgrading to kernel 2.6.1, I get system lockups every few days to
a few weeks.

There are no messages, no warnings, not even debugging information.

The only thing I notice is that the SCSI bus appears to be hung, and the
system halts.  Sometimes the bus hangs before the system stops, but not
always.

Doesn't happen under any 2.4.x kernel, and I do not believe it happened
on the 2.6 betas I tried.

What would be the possible reasons for not getting any debug
information?  I do not have kernel debugging enabled, but do have SCSI
debugging in place.

If I enable kernel debugging, is that more likely to find something?

In the past when I had this problem, it was usually a kernel or driver
issue, and I rarely was able to get any debug information, but I'm open
to suggestions.

I cannot reproduce this problem on demand though.  It does happen when
there is moderate SCSI traffic, but doesn't seem to happen at the
highest SCSI bus loads.

I tried to cause the crash this week, but could not.  Thirty minutes
after I finally gave up, it happened.

Still have no information to go on, but I thought I would ask here in
case someone else is seeing trouble.


-- 
shannon "AT" widomaker.com -- [4649 5920 4320 204e 4452 5420 5348 5920 4820
2056 2054 434d 2048 4d54 2045 204e 5259 4820 444e 0a53]
