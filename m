Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755843AbWKQUEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbWKQUEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755847AbWKQUEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:04:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:13518 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755845AbWKQUEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:04:46 -0500
Date: Fri, 17 Nov 2006 21:03:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-rt3, yum repo
Message-ID: <20061117200357.GA736@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0075]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've released the 2.6.18-rc6-rt3 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

the -rt YUM repository for Fedora Core 6 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
   yum update kernel

lots of fixes since -rt0. The latency tracer got more modularized, now 
event tracing, function tracing and latency timing/tracing can be 
selected independently as well.

to build a 2.6.19-rc6-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt3

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
