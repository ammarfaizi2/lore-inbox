Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVBSGsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVBSGsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVBSGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:48:33 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:8148 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261641AbVBSGre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:47:34 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1108789704.8411.9.camel@krustophenia.net>
References: <20050204100347.GA13186@elte.hu>
	 <1108789704.8411.9.camel@krustophenia.net>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 01:47:33 -0500
Message-Id: <1108795653.8811.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 00:08 -0500, Lee Revell wrote:
> On Fri, 2005-02-04 at 11:03 +0100, Ingo Molnar wrote:
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> Testing on an all SCSI 1.3Ghz Athlon XP system, I am seeing very long
> latencies in the journalling code with 2.6.11-rc4-RT-V0.7.39-02.

If I mount all filesystems with 'data=writeback', it works perfectly.  I
can run 'dbench 64', JACK with Hydrogen at 32 frames and have been
unable to produce a single xrun.  The maximum wakeup latency I have seen
is 139us.  With 'data=ordered', just launching a web browser can produce
an xrun.

Lee

