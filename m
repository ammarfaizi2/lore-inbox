Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSG3Qbp>; Tue, 30 Jul 2002 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSG3Qbo>; Tue, 30 Jul 2002 12:31:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31757 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318342AbSG3Qbo>; Tue, 30 Jul 2002 12:31:44 -0400
Date: Tue, 30 Jul 2002 12:29:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: zhengchuanbo <zhengcb@netpower.com.cn>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: about the performance of netfilter
In-Reply-To: <200207242128878.SM00796@zhengcb>
Message-ID: <Pine.LNX.3.96.1020730122226.4042K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, zhengchuanbo wrote:

> 
> we use a linux router. i just tested the performance of the router. when
> the kernel is build without netfilter support,the throughput of 64bytes
> frame is about 45%. when i build the kernel with netfilter (only the
> ip_filter module),the throughput dropped to 24%, without any rules.  so
> is there some way to improve the performance? i just want some simple
> packet filter. is netfilter no so good on the performance compare to
> ipchains due to the improved functionality?  please cc.  thanks. 

I'm not sure what you mean by 24%, since you don't say of what. I'm not
sure what you expect, an old Pentium 133 gives me 6-8Mbit on 10Mbit cards,
with a fair number of rules installed. If you are trying to load up Gbit
with a 386-16 or something, it won't work well, but for typical small
office setups Linux routing seems to run about as fast as directly
connected machines on the same subnet, although there is latency going
through the router.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

