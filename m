Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUIHGju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUIHGju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUIHGju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:39:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47827 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268883AbUIHGjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:39:48 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Kevin Hilman <kjh-lkml@hilman.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <834qm92xvw.fsf@www2.muking.org>
References: <834qm92xvw.fsf@www2.muking.org>
Content-Type: text/plain
Message-Id: <1094625588.1362.94.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 02:39:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 00:22, Kevin Hilman wrote:
> At first glance, it appears to be the result of an accumulation of
> calls to __delay() from the 3c59x vortex driver.  Any ideas what's
> going on here?
> 
> Is there a way to disable the trace by default and enable it later via
> /proc?  I see that the preemption itself can be disabled via
> command-line and then enable later via /proc but I don't see the same
> for the latency trace.

echo 0 > /proc/sys/kernel/preempt_max_latency will reset the counter.   
There is probably no point in fixing boot time latencies.

Lee

