Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUKWVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUKWVYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUKWVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:23:46 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:39300 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261561AbUKWVWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:22:10 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0,
	and 30-9
From: Steven Rostedt <rostedt@kihontech.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411231316300.2242@gradall.private.brainfood.com>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
	 <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
	 <20041123115201.GA26714@elte.hu>
	 <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411231316300.2242@gradall.private.brainfood.com>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 16:22:04 -0500
Message-Id: <1101244924.32068.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just curious to why you scale the interrupts from 49 down to 25.  What
would be wrong with keeping all of them at 49 (or whatever). Being a
FIFO, no interrupt would preempt another. Why would you want the first
IRQs to be registered have higher priority than (and thus will preempt)
irqs registered later.

-- 
Steven Rostedt
Senior Engineer
Kihon Technologies

