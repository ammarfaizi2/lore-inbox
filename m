Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268243AbUHWXMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUHWXMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHWXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:10:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8076 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263117AbUHWXEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:04:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823225255.GA16820@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
	 <20040823210151.GA10949@elte.hu> <1093300882.826.28.camel@krustophenia.net>
	 <20040823225255.GA16820@elte.hu>
Content-Type: text/plain
Message-Id: <1093302276.826.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 19:04:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 18:52, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P8
> > > 
> > Should this fix the 500+ usec latency I saw in rt_garbage_collect? 
> > This one took a while to occur (overnight).
> 
> i dont think it will. Does the patch below help?
> 

Probably.  This one is pretty rare, it might take a day to recur, and
it's pretty clear the patch will fix the problem, so I recommend adding
it to P9.

Lee

