Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVAWBlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVAWBlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVAWBls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:41:48 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:59544 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261177AbVAWBle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:41:34 -0500
Message-Id: <200501230141.j0N1fOAB022422@localhost.localdomain>
To: Con Kolivas <kernel@kolivas.org>
cc: "Jack O'Quin" <joq@io.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling 
In-reply-to: Your message of "Sun, 23 Jan 2005 12:31:45 +1100."
             <41F2FE81.7020002@kolivas.org> 
Date: Sat, 22 Jan 2005 20:41:24 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.197.206.140] at Sat, 22 Jan 2005 19:41:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The idea is to get equivalent performance to SCHED_FIFO. The results 
>show that much, and it is 100 times better than unprivileged 
>SCHED_NORMAL. The fact that this is an unoptimised normal desktop 
>environment means that the conclusion we _can_ draw is that SCHED_ISO is 
>as good as SCHED_FIFO for audio on the average desktop. I need someone 

no, this isn't true. the performance you are getting isn't as good as
SCHED_FIFO on a tuned system (h/w and s/w). the difference might be
the fact that you have "an average desktop", or it might be that your
desktop is just fine and SCHED_ISO actually is not as good as
SCHED_FIFO. 

>with optimised hardware setup to see if it's as good as SCHED_FIFO in 
>the critical setup.

agreed. i have every confidence that Lee and/or Jack will be
forthcoming :)

--p
