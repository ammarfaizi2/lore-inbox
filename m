Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWGILR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWGILR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWGILR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:17:58 -0400
Received: from oola.is.scarlet.be ([193.74.71.23]:51348 "EHLO
	oola.is.scarlet.be") by vger.kernel.org with ESMTP id S1030442AbWGILR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:17:57 -0400
Message-ID: <44B0E5E4.2090902@joow.be>
Date: Sun, 09 Jul 2006 13:17:56 +0200
From: Pieter Palmers <pieterp@joow.be>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394
 audio
References: <1152371924.4736.169.camel@mindpipe>	 <1152409894.32734.27.camel@localhost.localdomain> <1152411169.28129.24.camel@mindpipe>
In-Reply-To: <1152411169.28129.24.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-scarlet.be-Metrics: oola 2020; Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2006-07-08 at 21:51 -0400, Steven Rostedt wrote:
>> Lee, can you cause this problem with PREEMPT_DESKTOP with softirq as
>> threads?
>>
> 
> I am just posting this for Pieter - all followups should be directed to
> him.  (I don't even have the hardware to reproduce this)
> 
> IIRC the problem could only be reproduced with PREEMPT_RT.  Pieter, can
> you confirm?

It can only be reproduced with PREEMPT_RT. And the test kernel is 
configured with irq threading, I haven't tried it without irq threading.

Pieter
