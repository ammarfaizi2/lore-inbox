Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271080AbUJUXRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271080AbUJUXRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271101AbUJUXPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:15:34 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:25607 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S271077AbUJUXHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:07:11 -0400
Date: Thu, 21 Oct 2004 16:06:29 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bill Huey <bhuey@lnxw.com>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021230629.GB25779@nietzsche.lynx.com>
References: <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <1098391421.27089.83.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098391421.27089.83.camel@thomas>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:43:41PM +0200, Thomas Gleixner wrote:
> Hey, let's stop this here.
> 
> You are both (in)correct :)
> 
> 1. It makes no sense to discuss, why X has been considered correct for
> time T.
> 
> 2. Counted semaphores are a valid use and should be marked explicit as
> counted semaphores.
> 
> 3. Using mutexes and semaphores for event and completion signalling
> should be converted to the appropriate interfaces. 
> 
> A bunch of work, but not really hard.

What's the verdict ? leave the lock detector alone or change it ?

bill

