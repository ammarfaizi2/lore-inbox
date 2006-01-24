Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWAXSLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWAXSLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWAXSLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:11:13 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:16865 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030471AbWAXSLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:11:11 -0500
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched
	(was: 2.6.15-rt12 bugs)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0601240737u3e77245g@mail.gmail.com>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
	 <1138112388.6695.26.camel@localhost.localdomain>
	 <6bffcb0e0601240737u3e77245g@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 13:11:02 -0500
Message-Id: <1138126262.6695.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 16:37 +0100, Michal Piotrowski wrote:
> Hi,
> 
> On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 2006-01-24 at 14:33 +0100, Michal Piotrowski wrote:
> [snip]
> > > And problems while loading ipv6 module
> > > Running ntpdate to synchronize clockCould not allocate 4 bytes percpu data
> > > modprobe: FATAL: Error inserting ipv6
> > > (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> > > memory
> > >
> > > Could not allocate 4 bytes percpu data
> > > modprobe: FATAL: Error inserting ipv6
> > > (/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
> > > memory
> >
> > Is this new with the -rt14? or has this happened before. If it has
> > happened before, then could you tell us when it started.
> 
> It's very hard to track down, because earlier versions of -rt ware too
> buggy for me and most of them doesn't compile/boot.

The 2.6.14-rtX series was pretty stable. How early did you go back?

-- Steve


