Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVJBVL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVJBVL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 17:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVJBVL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 17:11:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932069AbVJBVL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 17:11:26 -0400
Date: Sun, 2 Oct 2005 23:05:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051002210549.GA8503@elf.ucw.cz>
References: <20051001182056.GA1613@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001182056.GA1613@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch adds CONFIG_RCU_TORTURE_TEST, which enables a /proc-based
> intense torture test of the RCU infrastructure.  This is needed due to the
> continued changes to RCU infrastructure to accommodate dynamic ticks, CPU
> hotplug, and so on.  Most of the code is in a separate file that is compiled
> only if the CONFIG variable is set.  Documentation on how to run the test
> and interpret the output is also included.
> 
> This code has been tested on i386 and ppc64, and an earlier version of the
> code has seen extensive testing on a number of architectures as part of the
> PREEMPT_RT patchset.
> 
> Signed-off-by: <paulmck@us.ibm.com>

Can you just run the tests from time to time inside IBM?
									Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
