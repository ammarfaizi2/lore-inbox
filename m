Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263260AbVCKKx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbVCKKx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVCKKx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:53:57 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:43174 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263260AbVCKKx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:53:56 -0500
Date: Fri, 11 Mar 2005 05:53:52 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311024322.690eb3a9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503110553030.19798@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu>
 <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
 <20050311024322.690eb3a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >  No, I'll try that now. I just didn't want to modify the buffer head struct
> >  just for journaling.  But if it is the quickest and easiest fix, then I'll
> >  submit it and we can change it later.
>
> You'll need two spinlocks.  jbd_lock_bh_state() and jbd_lock_bh_journal_head().
>

Yep, already did that. Now I need to reboot the new kernel and give it a
try.

-- Steve

