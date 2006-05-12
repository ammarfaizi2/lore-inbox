Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWELQBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWELQBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWELQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:01:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWELQBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:01:02 -0400
Date: Fri, 12 May 2006 09:03:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-Id: <20060512090323.252d8600.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0605121136060.4281@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net>
	<Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
	<4461E53B.7050905@compro.net>
	<Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
	<446207D6.2030602@compro.net>
	<Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
	<44623157.9090105@compro.net>
	<Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
	<20060512081628.GA26736@elte.hu>
	<Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
	<20060512092159.GC18145@elte.hu>
	<Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
	<20060512071645.6b59e0a2.akpm@osdl.org>
	<Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
	<20060512074929.031d4eaf.akpm@osdl.org>
	<Pine.LNX.4.58.0605121110320.3328@gandalf.stny.rr.com>
	<20060512082340.3e169128.akpm@osdl.org>
	<Pine.LNX.4.58.0605121136060.4281@gandalf.stny.rr.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> On Fri, 12 May 2006, Andrew Morton wrote:
> 
> >
> > Well, only if the hardware's fratzed.  Normally this is quick.
> >
> > otoh vortex_timer() will play with the MII interface, which is slooooow.
> >
> 
> The vortex_timer is a timeout,

err, it's actually a function.

> will it go off often?

Every five seconds if the cable's unplugged.  Every 60 seconds otherwise.
