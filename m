Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVBDKEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVBDKEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBDKEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:04:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46801 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263499AbVBDKEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:04:05 -0500
Date: Fri, 4 Feb 2005 11:03:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050204100347.GA13186@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.38-01 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

Changes since -37-03:

 - merged to 2.6.11-rc3

 - deadlock-tracer fix from Eugeny S. Mints

 - converted an oprofile spinlock to raw, which should fix the bug 
   reported by Peter Zijlstra.

to create a -V0.7.38-01 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc3.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc3-V0.7.38-01

	Ingo
