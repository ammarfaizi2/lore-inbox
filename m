Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUHHCkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUHHCkC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUHHCkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:40:02 -0400
Received: from holomorphy.com ([207.189.100.168]:31447 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264991AbUHHCj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:39:59 -0400
Date: Sat, 7 Aug 2004 19:39:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040808023941.GQ17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu> <1091932214.1150.3.camel@mindpipe> <20040808023306.GP17188@holomorphy.com> <1091932615.1150.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091932615.1150.6.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 22:33, William Lee Irwin III wrote:
>> This seems to be 996us spent in do_IRQ() when it interrupts idle tasks.

On Sat, Aug 07, 2004 at 10:36:55PM -0400, Lee Revell wrote:
> I am not sure I understand how preemption can be disabled for 996us and
> not cause an xrun.

You were idling at the time, so the latency affected nothing, except
perhaps task migration on SMP.


-- wli
