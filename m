Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVDEH0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVDEH0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDEHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:25:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14512 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261601AbVDEHWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:22:46 -0400
Date: Tue, 5 Apr 2005 00:20:58 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs
Message-Id: <20050405002058.3d90a2de.pj@engr.sgi.com>
In-Reply-To: <m1d5t91zqn.fsf@muc.de>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403150102.GA25442@elte.hu>
	<20050403153056.0ad6ee8e.pj@engr.sgi.com>
	<m1d5t91zqn.fsf@muc.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> There is already an arch neutral mechanism in sysfs, see
> /sys/devices/system/node/node*/distance

Excellent - thank-you.

> But of course SLIT doesn't know anything about cache latencies.

Of course.  Though SLIT does know about basic node distances, which
tend to correlate with cache migration costs, apparently closely enough
for our current modest needs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
