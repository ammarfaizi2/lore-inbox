Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTIDEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTIDEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:49:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:34248 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264694AbTIDEt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:49:57 -0400
Date: Wed, 3 Sep 2003 21:49:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: mbligh@aracnet.com, piggin@cyberone.com.au, anton@samba.org,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-Id: <20030903214950.26e0b430.davem@redhat.com>
In-Reply-To: <20030903153901.GB5769@work.bitmover.com>
References: <20030903040327.GA10257@work.bitmover.com>
	<20030903041850.GA2978@krispykreme>
	<20030903042953.GC10257@work.bitmover.com>
	<20030903062817.GA19894@krispykreme>
	<3F55907B.1030700@cyberone.com.au>
	<27780000.1062602622@[10.10.2.4]>
	<20030903153901.GB5769@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 08:39:01 -0700
Larry McVoy <lm@bitmover.com> wrote:

> It's really easy to claim that scalability isn't the problem.  Scaling
> changes in general cause very minute differences, it's just that there
> are a lot of them.  There is constant pressure to scale further and people
> think it's cool.

So why are people still going down this path?

I'll tell you why, because as SMP issues start to embark upon
the mainstream boxes people are going to find clever solutions
to most of the memory sharing issues that cause all the "lock
overhead".

Things like RCU are just the tip of the iceberg.  And think Larry,
we didn't have stuff like RCU back when you were directly working
and watching people work on huge SMP systems.

I think it's instructive to look at hyperthreading from another
angle in this argument, that the cpu people invested billions of
dollars in work to turn memory latency into free cpu cycles.

Put that in your pipe and smoke it :-)
