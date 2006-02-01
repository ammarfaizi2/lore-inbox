Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422960AbWBAVsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWBAVsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWBAVsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:48:03 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:12798 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422960AbWBAVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:48:02 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138819142.18762.10.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 16:47:56 -0500
Message-Id: <1138830476.6632.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 12:39 -0600, Clark Williams wrote: 
> On Wed, 2006-02-01 at 13:32 -0500, Steven Rostedt wrote:
> > 
> > I'm still curious to what's happening with your kernel.  I'm currently
> > running my x86_64 (typing right now on it) with CONFIG_SMP=n and
> > CONFIG_LATENCY=y.  I know you probably sent a config before, but could
> > you send it to me again.  (probably best to send it to me off list)
> 
> yeah, it's been gnawing at me too. Not really stopping me, but I've seen
> it happen on two Athlon64's (3000+ and 3400+). 
> 
> I'll send the .config offlist.

Clark,

Could you make sure that your modules in the initrd that you use are the
ones created with the LATENCY_TRACE option.  After converting all the
modules into compiled in options, I successfully booted the kernel.  So
you might have an incompatibility with the modules in initrd, when you
turn on LATENCY_TRACE.

-- Steve


