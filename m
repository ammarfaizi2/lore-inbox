Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVCNKNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVCNKNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCNKNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:13:10 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:63900 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262102AbVCNKLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:11:03 -0500
Date: Mon, 14 Mar 2005 05:10:50 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>  <1108789704.8411.9.camel@krustophenia.net>
  <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> 
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> 
 <20050311095747.GA21820@elte.hu>  <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
  <20050311101740.GA23120@elte.hu>  <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
  <20050311024322.690eb3a9.akpm@osdl.org>  <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
  <20050311153817.GA32020@elte.hu>  <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
  <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2005, Steven Rostedt wrote:
>
> I just downloaded -40 and applied my patch, compiled it with
> PREEMPT_DESKTOP and data=ordered, ran it and everything seems OK, except
> I'm getting the following...
>
> BUG: Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> c0213438
> *pde = 00000000

[snip]

>
>
> I'll see if this happens without the patch, and if so, then I'll look into
> this further.
>

Well, I took out my patch and this bug didn't happen, so I guess it's may
fault!  OK, I'll dig into it further.

-- Steve

