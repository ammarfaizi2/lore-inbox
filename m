Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUIPXkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUIPXkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUIPXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:36:28 -0400
Received: from holomorphy.com ([207.189.100.168]:10920 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268301AbUIPXdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:33:19 -0400
Date: Thu, 16 Sep 2004 16:33:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Bill Huey <bhuey@lnxw.com>, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040916233312.GW9106@holomorphy.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org> <cic7f9$i4m$1@gatekeeper.tmr.com> <20040916222903.GA4089@nietzsche.lynx.com> <20040916154011.3f0dbd54.davem@davemloft.net> <20040916225102.GA4386@nietzsche.lynx.com> <20040916155412.47649ba6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916155412.47649ba6.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 15:51:02 -0700 Bill Huey (hui) wrote:
>> Judging from how the Linux code is done and the numbers I get from
>> Bill Irwin in casual conversation, the Linux SMP approach is clearly
>> the right track at this time with it's hand honed per-CPU awareness of
>> things. The only serious problem that spinlocks have as they aren't
>> preemptable, which is what Ingo is trying to fix.

On Thu, Sep 16, 2004 at 03:54:12PM -0700, David S. Miller wrote:
> This is what Linus proclaimed 6 or 7 years ago when people were
> trying to convince us to do things like Solaris and other big
> Unixes at the time.

Just in case, I didn't claim it was my idea, I merely gave empirical
evidence.


-- wli
