Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267902AbUGaD5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267902AbUGaD5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 23:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUGaD5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 23:57:04 -0400
Received: from mail.aei.ca ([206.123.6.14]:58606 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267902AbUGaD5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 23:57:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Shane Shrybman <shrybman@aei.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091232345.1677.20.camel@mindpipe>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
	 <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
	 <1091232345.1677.20.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091246064.2389.9.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 23:54:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 20:05, Lee Revell wrote: 
> On Fri, 2004-07-30 at 19:21, Felipe Alfaro Solana wrote:
> > On Fri, 2004-07-30 at 13:38 -0400, Shane Shrybman wrote:
> > 
> > > > M5 does that differently, yes - so could you try it? If you still get
> > > > problems, does this fix it:
> > > 
> > > Ok, M5 locked up the whole machine within a few seconds of starting X.
> > 
> > Me too, with voluntary-preempt=3... It seems I can trigger this randomly
> > by heavily moving the mouse around while logging in into my KDE session.
> > 
> > However, with voluntary-preempt=2 I've been unable to lock the machine
> > yet.
> 
> It looks like this is a mouse problem, I have a PS/2 keyboard and USB
> mouse and have not had any problems yet with M5. 

I have a usb mouse and PS/2 keyboard as well. The mouse kept functioning
and the keyboard didn't, except when the whole machine hung. I am
recompiling M5 from fresh sources to confirm the behaviour there.

Hmm, M5 still no go here. Keyboard and display updates stop working
quickly once in X, although the mouse is able to keep moving. This was
with voluntary-preempt=2 this time.

Shane

