Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVHBKSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVHBKSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVHBKSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:18:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57816 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261475AbVHBKSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:18:39 -0400
Date: Tue, 2 Aug 2005 12:19:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050802101920.GA25759@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122920564.6759.15.camel@localhost.localdomain> <1122931238.4623.17.camel@dhcp153.mvista.com> <1122944010.6759.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122944010.6759.64.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> In my custom kernel, I have a wchan field of the task that records 
> where the task calls something that might schedule. This way I can see 
> where things locked up if I don't have a back trace of the task.  This 
> field is always zero when it switches to usermode.  Something like 
> this can also be used to check how long the process is in kernel mode.  
> If a task is in the kernel for more than 10 seconds without sleeping, 
> that would definitely be a good indication of something wrong.  I 
> probably could write something to check for this if people are 
> interested.  I wont waste my time if nobody would want it.

this would be a pretty useful extension of the softlockup checker!

	Ingo
