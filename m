Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVJMUNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVJMUNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJMUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:13:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3524 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932469AbVJMUNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:13:40 -0400
Subject: Re: sched_clock -> check_tsc_unstable -> tsc_read_c3_time ?!?
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1129234306.27168.7.camel@cog.beaverton.ibm.com>
References: <1129233687.16243.52.camel@mindpipe>
	 <1129234306.27168.7.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 16:13:26 -0400
Message-Id: <1129234407.16243.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 13:11 -0700, john stultz wrote:
> Yea, you're right about the inlining. Although I'm not sure why those
> functions should take microseconds to execute. That's very strange. 

Latency tracing overhead plus a slow (600MHz) machine?

Lee

