Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbUKRPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUKRPro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKRPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:45:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:2967 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262475AbUKRPoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:44:19 -0500
Date: Thu, 18 Nov 2004 17:46:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041118164612.GA17040@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118123521.GA29091@elte.hu>
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


i have released the -V0.7.29-0 Real-Time Preemption patch, which can be
downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

this is a pure merge of -V0.7.28-2 to 2.6.10-rc2-mm2. -rc2-mm2 itself is
a fixes-only release.

to create a -V0.7.29-0 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm2-V0.7.29-0

	Ingo
