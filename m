Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUJEApg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUJEApg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268729AbUJEApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:45:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5086 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268724AbUJEApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:45:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       thewade <pdman@aproximation.org>
In-Reply-To: <20041005025642.4fbc0775@mango.fruits.de>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
	 <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu>
	 <1096936317.16648.103.camel@krustophenia.net>
	 <20041005025642.4fbc0775@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1096937122.16648.105.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 20:45:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 20:56, Florian Schmidt wrote:
> On Mon, 04 Oct 2004 20:31:58 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Mon, 2004-10-04 at 17:53, Ingo Molnar wrote:
> > > i've released the -S9 VP patch:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
> > > 
> > 
> > Does not compile:
> 
> The definition of hardirq_stack seem to depend on the 4k stacks option.
> with this enables it builds past irq.c.

Ah, OK.  I should have this enabled anyway, I think I disabled it way
back at Ingo's recommendation when were trying to get useful traces out
of ALSA's xrun debugging feature.

Lee

