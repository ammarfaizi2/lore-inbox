Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJCAnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJCAnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVJCAnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:43:07 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:58500 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbVJCAnG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:43:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kIPtvuP0LTiIAcq4Mos5bpirc1VtvCvYgkgZlLb49ANTKOaNYQfL0ZCkPqIREYNhiuBzzbl98MKbqgi0Ski/vUv7V59ZuLDe4Ii/pV8+U9q7x2JiGeJXPutpmOp4XqboB90n1Gh0x7x2KO+v3NQWVX3YXg1VxlcBPnhu10O+PBs=
Message-ID: <3e1162e60510021743q46948f93qaea4a0ce0dd61b8d@mail.gmail.com>
Date: Sun, 2 Oct 2005 17:43:05 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051003003615.GA2440@kurtwerks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002204703.GG6290@lkcl.net>
	 <20051003003615.GA2440@kurtwerks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it's a daft, monolithic design that is suitable and faster on
> > single-processor systems, and that design is going to look _really_
> > outdated, really soon.
>
> Andrew Tannenbaum said the same thing in the early 1990s. That we're
> here still having this discussion >10 years later is telling. Dr.
> Tannenbaum might have been acadmeically and theoretically correct,
> but, with a nod to OS X, the Linux kernel has proven itself by
> implementation and has proven to be remarkably adaptable.

Why are you nodding to OS X?  It's not a real micokernel either.  It
just happens to have all the foobage of a microkernel in a rather
monolithic design.  The reason that the bsd personality is in the same
address space as the mach bits is because they didn't want to deal
with the overheads of the message passing from kernel to userspace.

The L4 people figured out how to get a lot of those inefficiencies to
disappear and L4Linux is quite "performant".  In some cases, L4Linux
can be used to provide a device driver for other L4 threads that would
normally have to write their own [in user space and even with
respectable performance
http://www.ertos.nicta.com.au/Research/ULDD/Performance.pml]

That's an interesting re-use and combination of several philosophies
if you ask me.

There is a lot of "what's next for linux" going on behind the scenes
and the current path of linux is apparently good enough for
accomplishing it.

- Dave
