Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVHaCjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVHaCjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 22:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVHaCjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 22:39:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62645 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932339AbVHaCjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 22:39:07 -0400
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: jackit-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU
In-Reply-To: <1125453795.25823.121.camel@cmn37.stanford.edu>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 22:39:03 -0400
Message-Id: <1125455943.19563.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 19:03 -0700, Fernando Lopez-Lezcano wrote:
> Hi, I'm starting to look at a strange problem. The configuration is:
> hardware: AMD X2 4400+ dual core, NForce3 chipset, Midiman 66 soundcard
> software: 2.6.13 smp + patch-2.6.13-rt1, PREEMPT_DESKTOP
>           jack 0.100.4, current cvs
>           alsa 1.0.10rc1
> 

Enable all latency debug options and post the contents
of /proc/latency_trace when this happens.  Also what file system are you
using?  And is the SMT scheduler enabled?

Lee

