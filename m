Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269118AbUHXX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269118AbUHXX1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUHXXXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:23:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:54192 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269109AbUHXXWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:22:35 -0400
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin
	and others)
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: spaminos-ker@yahoo.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412BC984.6060408@bigpond.net.au>
References: <20040824211141.13585.qmail@web13921.mail.yahoo.com>
	 <412BC984.6060408@bigpond.net.au>
Content-Type: text/plain
Message-Id: <1093389752.841.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 19:22:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 19:04, Peter Williams wrote:
> spaminos-ker@yahoo.com wrote:
> > 
> > Could I do something more useful than just displaying those deltas? Maybe I
> > could dump the process list in some way, or enable some debugging code in the
> > kernel to find out what is going on?
> 
> You could try Lee Revell's (rlrevell@joe-job.com) latency measuring 
> patches and also try applying Ingo Molnar's (mingo@elte.hu) 
> voluntary-preempt patches.
> 

Most of the tools I am using are probably too specific to the audio
subsystem to be of much use to you.  Just use Ingo's voluntary
preemption patch; if this is a scheduler/preemption problem, then it
will definitely show up in the traces.

Lee

