Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUG3Vdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUG3Vdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267853AbUG3Vdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:33:43 -0400
Received: from mail.aei.ca ([206.123.6.14]:11770 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267852AbUG3Vdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:33:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Shane Shrybman <shrybman@aei.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091210620.800.61.camel@mindpipe>
References: <1091196403.2401.10.camel@mars>
	 <1091210620.800.61.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091223099.2356.17.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 17:31:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 14:03, Lee Revell wrote:
> On Fri, 2004-07-30 at 10:06, Shane Shrybman wrote:
> > Twice while using -L2 my IBM PS2 keyboard has become completely
> > non-responsive. USB mouse and everything else seems to be fine, but no
> > LEDs or anything from the keyboard.
> > 
> > On both occasions the last key I hit on the keyboard was numlock and the
> > numlock did not come on and I had to reboot after that.
> > 
> > UP, x86, gcc 2.95, scsi + ide, bttv
> > 
> 
> This happened to me, also twice necessitating a reboot.  I am pretty
> sure I did *not* hit Num Lock last, though the system was under load -
> multiple builds going on, jackd running, and video playback.  I tried to
> toggle Num Lock to see if the machine was really locked hard, and it
> worked for a while (though it did not go on/off exactly once for each
> time I hit it), then stopped responding.
> 

Did this happen with both the rc2-L2 and rc2-M5 kernels for you too?

Ingo, I have been running a previous version ( -I1 I think ) of
voluntary-preempt patch successfully for a few days, so I think the
problem was introduced since the -I1 version.

Shane

