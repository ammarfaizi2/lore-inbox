Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310475AbSCLHXx>; Tue, 12 Mar 2002 02:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCLHXm>; Tue, 12 Mar 2002 02:23:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:20740 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S310460AbSCLHXY>;
	Tue, 12 Mar 2002 02:23:24 -0500
Subject: Re: Few questions about 2.5.6-pre3
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203120842570.17313-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0203120842570.17313-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Mar 2002 02:22:51 -0500
Message-Id: <1015917775.4808.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-03-12 at 01:46, Zwane Mwaikambo wrote:

> Not sure wether this is a known issue but disabling CONFIG_PREEMPT booted 
> this box. Robert, here is the oops, if you want me to test a couple 
> things just send them my way, but its a high latency test box ;) so you 
> might have to wait a while between replies.

Thanks, Zwane.

I've never seen this.  I assume the box is SMP since you are hitting a
BUG in the spin_unlock code?  I almost want to think this is an SMP bug
(locking rules not being observed somewhere) and preemption is just
accelerating the race.

Ohh wait - this is 2.5.6-pre3 ?

Can you try 2.5.6 final (or anything later)?  There is a bug with SMP
and preempt and this could be it.  Let me know..

	Robert Love

