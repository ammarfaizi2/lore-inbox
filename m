Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVGHKCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVGHKCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVGHKCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:02:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41702 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262443AbVGHKAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:00:44 -0400
Date: Fri, 8 Jul 2005 12:00:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
Message-ID: <20050708100007.GA6446@elte.hu>
References: <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu> <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain> <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707164831.GA25696@elte.hu> <Pine.LNX.4.58.0507080242560.8133@localhost.localdomain> <Pine.LNX.4.58.0507080552030.8133@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507080552030.8133@localhost.localdomain>
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

> > To try and reproduce it again, I've added in /etc/rc3.d an S98reboot that
> > will switch the system to runlevel 6 again, and repeat the process over
> > and over. All this while connect to minicom and capturing.  Hopefully it
> > will eventually show the same bug.  If not, maybe it was just a fluke.
> 
> OK, I just rebooted the machine a 100 times, and not one error.  Maybe 
> it was just because the system failed on an earlier boot?  I don't 
> know, but I can't spend any more time on it.  I'll keep my minicom's 
> active at all times now.

hm, the "dead task enqueued!" is a real message that signals some real 
nastiness. It should not occur under any circumstance - nor have i seen 
it during the past couple of months. So lets keep an eye on it, but if 
100 reboots didnt trigger it there's not much we can do but wait and 
see.

	Ingo
