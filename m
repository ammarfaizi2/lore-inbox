Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJPTkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJPTkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUJPTg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:36:57 -0400
Received: from brown.brainfood.com ([146.82.138.61]:5248 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S266683AbUJPTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:35:54 -0400
Date: Sat, 16 Oct 2004 14:35:51 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
In-Reply-To: <20041016192402.GA10445@elte.hu>
Message-ID: <Pine.LNX.4.58.0410161434580.1223@gradall.private.brainfood.com>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161353530.1219@gradall.private.brainfood.com>
 <20041016192402.GA10445@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > >    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4
> > >
> > > this is a fixes-only release, and it is still experimental code.
> >
> > You forgot to lowercase RT and U in the EXTRAVERSION.
>
> i changed my mind because lowercase it looks pretty ugly in uname,
> appended to the already lowercase -mm string. Why does Debian need to
> have it in lowercase anyway? It doesnt seem to make much sense.

It's only a minor annoyance right now.  I have to edit Makefile before
starting make-kpkg, and before backing out the previous patch.  I'll file a
bug on kernel-package at some point, but it probably won't be fixed anytime
soon(debian is preparing to release soon(HAHA!)).
