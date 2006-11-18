Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755191AbWKRQbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbWKRQbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756253AbWKRQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 11:31:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32436 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755191AbWKRQbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 11:31:24 -0500
Date: Sat, 18 Nov 2006 17:30:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-rt4, changed yum repository
Message-ID: <20061118163032.GA14625@elte.hu>
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

i've released the 2.6.18-rc6-rt4 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

NOTE: the YUM repository has changed the -rt kernel's package name, it's 
now kernel-rt, so it does not override the kernel package. If you have 
rt.repo already then just do a "yum install kernel-rt".

If there's no rt repository yet, the -rt YUM repository for Fedora Core 
6 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
   yum install kernel-rt

a number of fixes were done since -rt3, and merges of Linus' latest -git 
tree.

to build a 2.6.19-rc6-rt4 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt4

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
