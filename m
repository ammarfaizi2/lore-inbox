Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVADGlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVADGlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 01:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVADGll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 01:41:41 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:11268 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262305AbVADGld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 01:41:33 -0500
Date: Mon, 3 Jan 2005 22:40:13 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20050104064013.GA19528@nietzsche.lynx.com>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214132834.GA32390@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 02:28:34PM +0100, Ingo Molnar wrote:
> to create a -V0.7.33-0 tree from scratch, the patching order is:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2

>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc3.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/2.6.10-rc3-mm1.bz2

>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc3-mm1-V0.7.33-0

Forward port of this patch to 2.6.10-mm1 here:
	http://people.lynuxworks.com/~bhuey/realtime/Ingo_forward_port-mm1-V0.7.33-04

Obviously, you'll need to patch a plain 2.6.10 with -mm1 from Andrew Morton,
but folks should be able to do this by now. ;)

You'll have to apply Ingo's patch so that it gets rejects and then apply
this patch on top of it so that it resolves those issues. It's a bit
sloppy, but this'll at least be somewhat workable until Ingo comes back
and pounds us with patches. :)

bill


