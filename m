Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWGICMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWGICMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 22:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWGICMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 22:12:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2715 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161045AbWGICMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 22:12:00 -0400
Subject: Re: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394
	audio
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Pieter Palmers <pieterp@joow.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1152409894.32734.27.camel@localhost.localdomain>
References: <1152371924.4736.169.camel@mindpipe>
	 <1152409894.32734.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 22:12:48 -0400
Message-Id: <1152411169.28129.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 21:51 -0400, Steven Rostedt wrote:
> Lee, can you cause this problem with PREEMPT_DESKTOP with softirq as
> threads?
> 

I am just posting this for Pieter - all followups should be directed to
him.  (I don't even have the hardware to reproduce this)

IIRC the problem could only be reproduced with PREEMPT_RT.  Pieter, can
you confirm?

Lee

