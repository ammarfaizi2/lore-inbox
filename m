Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUGMJa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUGMJa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGMJa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:30:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:44245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264685AbUGMJaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:30:39 -0400
Date: Tue, 13 Jul 2004 02:29:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713022919.67c991db.akpm@osdl.org>
In-Reply-To: <1089710638.20381.41.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<1089687168.10777.126.camel@mindpipe>
	<20040712205917.47d1d58b.akpm@osdl.org>
	<1089707483.20381.33.camel@mindpipe>
	<20040713014316.2ce9181d.akpm@osdl.org>
	<1089708818.20381.36.camel@mindpipe>
	<20040713020025.7400c648.akpm@osdl.org>
	<1089710638.20381.41.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Tue, 2004-07-13 at 05:00, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > > framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
> > >  > vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
> > >  > but make sure you're wearing ear protection.
> > >  > 
> > > 
> > >  OK, I figured this was not an easy one.  I can just not do that.
> > 
> > Why not?  You can certainly try removing those [un]lock_kernel() calls.
> > 
> 
> Maybe I missed something.  What exactly do you mean by 'make sure you're
> wearing ear protection'?
> 

It might go boom.  If it does screw up, it probably won't be very seriously
bad - maybe some display glitches.  Just an experiment.
