Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVLUXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVLUXQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVLUXQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:16:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:15552 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964951AbVLUXQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:16:03 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135204629.14810.43.camel@localhost.localdomain>
References: <1135145065.29182.10.camel@mindpipe>
	 <1135204629.14810.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 18:19:45 -0500
Message-Id: <1135207186.31433.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 17:37 -0500, Steven Rostedt wrote:
> So it really does improve the latency here.  Now is this worth the
> overhead?  This might be useful in other places to. 

Thanks, I'll try this.

But, AFAICT CONFIG_PREEMPT_SOFTIRQS is a much smaller patch... ;-)

Lee

