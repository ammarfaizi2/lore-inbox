Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWELQLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWELQLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWELQLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:11:34 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:2269 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932087AbWELQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:11:33 -0400
Date: Fri, 12 May 2006 12:11:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <20060512090323.252d8600.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0605121208350.5357@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
 <20060512071645.6b59e0a2.akpm@osdl.org> <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
 <20060512074929.031d4eaf.akpm@osdl.org> <Pine.LNX.4.58.0605121110320.3328@gandalf.stny.rr.com>
 <20060512082340.3e169128.akpm@osdl.org> <Pine.LNX.4.58.0605121136060.4281@gandalf.stny.rr.com>
 <20060512090323.252d8600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Andrew Morton wrote:

> >
> > The vortex_timer is a timeout,
>
> err, it's actually a function.

OK, I meant vp->timer

>
> > will it go off often?
>
> Every five seconds if the cable's unplugged.  Every 60 seconds otherwise.
>

OK, so the function is a service and not a fixup (or both).  Hmm, so
latency is an issue.

Thanks,

-- Steve

