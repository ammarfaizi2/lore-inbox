Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271391AbUJVPuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbUJVPuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbUJVPuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:50:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22447 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S271391AbUJVPt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:49:59 -0400
Date: Fri, 22 Oct 2004 17:50:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10
Message-ID: <20041022155048.GA16240@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022133551.GA6954@elte.hu>
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


i have released the -U10 Real-Time Preemption patch, which can be
downloaded from:
 
  http://redhat.com/~mingo/realtime-preempt/

this is purely a rebasing of -U9.3 to 2.6.9-mm1.

to create a -U10 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-U10

	Ingo
