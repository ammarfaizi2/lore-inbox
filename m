Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWAXPht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWAXPht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAXPht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:37:49 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:2688 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030356AbWAXPhs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:37:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dqJEcUtNd0wvZe+LH77cHMTw4JW8pZ+01J6nEV8yTHdpBYoBE6qpAeasa2CyvBttbAvUAwymVK4JkYDupF2XWiY0TYmhTntol1xFtbEOKnL6ie8g0m6/kf2BFKCqpQktEh6aQmNVkUiz1xQ9vIAThI6Fghak5MMc4DSx8zCTDVY=
Message-ID: <6bffcb0e0601240737u3e77245g@mail.gmail.com>
Date: Tue, 24 Jan 2006 16:37:47 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was: 2.6.15-rt12 bugs)
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1138112388.6695.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
	 <1138112388.6695.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2006-01-24 at 14:33 +0100, Michal Piotrowski wrote:
[snip]
> > And problems while loading ipv6 module
> > Running ntpdate to synchronize clockCould not allocate 4 bytes percpu data
> > modprobe: FATAL: Error inserting ipv6
> > (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> > memory
> >
> > Could not allocate 4 bytes percpu data
> > modprobe: FATAL: Error inserting ipv6
> > (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> > memory
>
> Is this new with the -rt14? or has this happened before. If it has
> happened before, then could you tell us when it started.

It's very hard to track down, because earlier versions of -rt ware too
buggy for me and most of them doesn't compile/boot.

Regards,
Michal Piotrowski
