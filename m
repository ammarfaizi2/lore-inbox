Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWCIJGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWCIJGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWCIJGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:06:35 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:4833 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750736AbWCIJGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:06:34 -0500
Date: Thu, 9 Mar 2006 10:05:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] Split PREEMPT_RCU implementation into separate rcupreempt.c
Message-ID: <20060309090516.GA19472@elte.hu>
References: <20060227224008.GA2347@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227224008.GA2347@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> This patch splits the PREEMPT_RCU implementation out from rcupdate.c 
> into a separate rcupreempt.c, and creates an rcucommon.h containing 
> common code (e.g., synchronize_rcu()).  I should have done this long 
> ago to reduce both confusion and the number of #ifdefs in rcupdate.c!
> 
> Signed-off-by: <paulmck@us.ibm.com>

great - i've applied this, and it looks much cleaner now.

	Ingo
