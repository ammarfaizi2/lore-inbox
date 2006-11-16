Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424177AbWKPPhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424177AbWKPPhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424178AbWKPPhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:37:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51148 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424177AbWKPPhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:37:10 -0500
Date: Thu, 16 Nov 2006 16:35:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061116153553.GA12583@elte.hu>
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
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've released the 2.6.18-rc6-rt0 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

i also started an -rt YUM repository for Fedora Core 6, which can be 
activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
   yum update kernel

-rt0 is a rebase of -rt to 2.6.19-rc6, with lots of updates and fixes 
included. It includes the latest -hrt-dynticks tree and more.

to build a 2.6.19-rc6-rt0 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt0

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
