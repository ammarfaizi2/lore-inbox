Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUIJQtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUIJQtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUIJQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:47:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58074 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267548AbUIJQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:45:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       kr@cybsft.com, mark_h_johnson@raytheon.com
In-Reply-To: <4d8e3fd30409100728bd6c9c1@mail.gmail.com>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
	 <20040909130526.2b015999.akpm@osdl.org> <20040910132841.GA8552@elte.hu>
	 <4d8e3fd30409100728bd6c9c1@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1094834712.15407.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 12:45:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 10:28, Paolo Ciarrocchi wrote:
> On Fri, 10 Sep 2004 15:28:41 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
> > > --- 25/mm/vmscan.c~swapspace-layout-improvements      2004-06-03 21:32:51.087602712 -0700
> > > +++ 25-akpm/mm/vmscan.c       2004-06-03 21:32:51.102600432 -0700
> > 
> > i've attached a merge against current BK-ish kernels. Lee, would you be
> > interested in testing it? It applies cleanly to an -S0 VP tree. I've
> > tested it only lightly - it compiles and boots and survives some simple
> > swapping but that's all.
> 
> Hello kernel folks,
> what's the plan regarding the inclusion of VP in mainstream ?
> 

I believe the plan is to merge the individual fixes one at a time.  See
Ingo's recent non-VP-related posts.  Once the fixes for all of the real
deficiencies in the kernel that the VP patches revealed are merged, then
we will have a very small patch.

Lee

