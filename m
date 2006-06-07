Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWFGVPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWFGVPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWFGVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:15:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38049 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932421AbWFGVPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:15:30 -0400
Date: Wed, 7 Jun 2006 23:14:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: 2.6.17-rc6-rt1
Message-ID: <20060607211455.GA6132@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

the biggest change was the port to 2.6.17-rc6, and the moving to John's 
latest and greatest GTOD queue. Most of the porting was done by Thomas 
Gleixner (thanks Thomas!). We also picked up the freshest genirq queue 
from -mm and the freshest PI-futex patchset. There are also lots of ARM 
fixups and enhancements from Deepak Saxena and Daniel Walker.

if we accidentally dropped some fix in the process then please complain. 
x86 and x86_64 build and boot, but some initial rough edges are to be 
expected. Deepak, your ARM-GTOD patches are included but not tested yet.

to build a 2.6.17-rc6-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rc6-rt1

	Ingo
