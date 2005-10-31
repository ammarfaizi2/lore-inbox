Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVJaOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJaOIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJaOIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:08:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55219 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751236AbVJaOIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:08:16 -0500
Date: Mon, 31 Oct 2005 15:08:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051031140825.GA5933@elte.hu>
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031140459.GA5664@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> RCU signal handling: send signals RCU-read-locked instead of 
> tasklist_lock read-locked. This is a scalability improvement on SMP 
> and a preemption-latency improvement under PREEMPT_RCU.

this should read:

RCU tasklist_lock and RCU signal handling: send signals RCU-read-locked 
instead of tasklist_lock read-locked. This is a scalability improvement 
on SMP and a preemption-latency improvement under PREEMPT_RCU.

	Ingo
