Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272401AbTGZJP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 05:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272420AbTGZJP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 05:15:27 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22025 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272401AbTGZJP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 05:15:26 -0400
Subject: Ingo Molnar and Con Kolivas 2.6 scheduler patches
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org, mingo@elte.hu
Content-Type: text/plain
Message-Id: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 11:30:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone,

In first place, let me publicly thanks both of you (Info and Con) for
your great work at fixing/tuning the 2.6 scheduler to its best.

Now that Ingo seems to be working again on the scheduler, I feel that
Con and Ingo work is starting to collide. I have been testing Con's
interactivity changes to the scheduler for a very long time, since it's
first O1int patch and I must say that, for my specific workloads, it
gives me the best end-user experience with interactive usage.

I just only wanted to publicly invite Con Kolivas to keep on working
with the scheduler patches he has been doing and that have required a
constant and fair amount of time from him. I don't know if Con patches
do work as good for others in this list as for me, so I also invite
everyone who is/has been testing them to express their feelings so we
all can know what's the current status of the 2.6 scheduler.

As the last point, I do want to invite Ingo and Con to work together to
fix things up definitively. I feel Con scheduler patches give better
interactive results (at least for me) but still feels a little bit slow
when the system is under heavy load and I try to launch new processes,
like a new xterm, for example. On the other side, Ingo patch makes the
system feel much more responsive under heavy loads when launching new
processes, like opening a new konsole tab, but still suffers from
jerkyness on interactive tasks, like the X server.

I think the more people working on the scheduler, the more probability
we have of fixing/tuning the last pieces of code so we can enjoy a full
enterprise-level, but well-behaved with interactive jobs, 2.6 scheduler.

Thanks for listening.

   Felipe Alfaro
   Scheduler tester :-)


