Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUHJMyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUHJMyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUHJMyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:54:19 -0400
Received: from holomorphy.com ([207.189.100.168]:7145 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264980AbUHJMv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:51:59 -0400
Date: Tue, 10 Aug 2004 05:51:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: V13 <v13@priest.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810125140.GU11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	V13 <v13@priest.com>, Ingo Molnar <mingo@elte.hu>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101552.22501.v13@priest.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 14:53, William Lee Irwin III wrote:
>> Okay, these also failed as replacements for printk():
>> (c) local_irq_enable();
>> (d) local_irq_enable(); set_current_state(TASK_RUNNING);
>> 	schedule(); mdelay(1000);
>> (e) local_irq_enable(); set_current_state(TASK_RUNNING);
>> 	for (i = 0; i < 1000; ++i) mdelay(1);
>> 	set_current_state(TASK_RUNNING); schedule();

On Tue, Aug 10, 2004 at 03:52:20PM +0300, V13 wrote:
> Why don't you create a copy of printk() and start commenting out lines in 
> there?

This is a very good idea.

Thanks.


-- wli
