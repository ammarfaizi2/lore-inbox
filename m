Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUHHCtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUHHCtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUHHCtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:49:05 -0400
Received: from holomorphy.com ([207.189.100.168]:36055 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265029AbUHHCtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:49:02 -0400
Date: Sat, 7 Aug 2004 19:48:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040808024852.GS17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu> <1091932214.1150.3.camel@mindpipe> <20040808023306.GP17188@holomorphy.com> <1091932615.1150.6.camel@mindpipe> <20040808023941.GQ17188@holomorphy.com> <1091933229.1150.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091933229.1150.15.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 22:39, William Lee Irwin III wrote:
>> You were idling at the time, so the latency affected nothing, except
>> perhaps task migration on SMP.

On Sat, Aug 07, 2004 at 10:47:09PM -0400, Lee Revell wrote:
> Would it be possible to detect this situation and treat it like a
> preemptible section, just so the sheer volume of printks does not cause
> a problem?

It's probably actually a false positive. What I was explaining was why,
if it were in fact a non-preemptible critical section, it wouldn't cause
xruns.


-- wli
