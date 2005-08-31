Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVHaFMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVHaFMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVHaFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 01:12:52 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:53423 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932369AbVHaFMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 01:12:52 -0400
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jackit-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU
In-Reply-To: <1125455943.19563.38.camel@mindpipe>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	 <1125455943.19563.38.camel@mindpipe>
Content-Type: text/plain
Organization: 
Message-Id: <1125465127.15006.49.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Aug 2005 22:12:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 19:39, Lee Revell wrote:
> On Tue, 2005-08-30 at 19:03 -0700, Fernando Lopez-Lezcano wrote:
> > Hi, I'm starting to look at a strange problem. The configuration is:
> > hardware: AMD X2 4400+ dual core, NForce3 chipset, Midiman 66 soundcard
> > software: 2.6.13 smp + patch-2.6.13-rt1, PREEMPT_DESKTOP
> >           jack 0.100.4, current cvs
> >           alsa 1.0.10rc1
> > 
> 
> Enable all latency debug options and post the contents
> of /proc/latency_trace when this happens. 

Will try to, I'm about to go on a trip so that may have to wait. 

> Also what file system are you using? 

Ext3, Jack mounts its pipes and stuff in /dev/shm

>  And is the SMT scheduler enabled?

Is this it?: CONFIG_SCHED_SMT=y

-- Fernando


