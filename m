Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUGMJ3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUGMJ3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGMJ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:29:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7048 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264677AbUGMJXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:23:48 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040713020025.7400c648.akpm@osdl.org>
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
Content-Type: text/plain
Message-Id: <1089710638.20381.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 05:23:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 05:00, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > > framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
> >  > vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
> >  > but make sure you're wearing ear protection.
> >  > 
> > 
> >  OK, I figured this was not an easy one.  I can just not do that.
> 
> Why not?  You can certainly try removing those [un]lock_kernel() calls.
> 

Maybe I missed something.  What exactly do you mean by 'make sure you're
wearing ear protection'?

Lee

