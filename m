Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJRV3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJRV3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUJRVZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:25:09 -0400
Received: from brown.brainfood.com ([146.82.138.61]:55424 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267405AbUJRVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:21:40 -0400
Date: Mon, 18 Oct 2004 16:21:38 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
In-Reply-To: <20041018210644.GA14072@elte.hu>
Message-ID: <Pine.LNX.4.58.0410181621100.1218@gradall.private.brainfood.com>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
 <20041018145008.GA25707@elte.hu> <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com>
 <20041018181826.GC2899@elte.hu> <Pine.LNX.4.58.0410181557190.1218@gradall.private.brainfood.com>
 <20041018210644.GA14072@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Mon, 18 Oct 2004, Ingo Molnar wrote:

> > Too late, it's gone.  It'd be nice if there was some way to have
> > history on that file.
>
> well - if it's gone it's always replaced by a larger latency (if you use
> the preempt_max_latency method), which in most cases is more interesting
> than the one you wanted to save.

I reset the minimum to 50, and it's only gotten up to 83.
