Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTKXWpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTKXWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:45:22 -0500
Received: from web40908.mail.yahoo.com ([66.218.78.205]:12297 "HELO
	web40908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261500AbTKXWpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:45:15 -0500
Message-ID: <20031124224514.56242.qmail@web40908.mail.yahoo.com>
Date: Mon, 24 Nov 2003 14:45:14 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0311241429330.15101@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Torvalds,

--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 24 Nov 2003, Bradley Chapman wrote:
> >
> > What sort of information would you like me to provide, sir? The bug you're
> > discussing here isn't affecting me; CONFIG_PREEMPT has been solid on
> 2.6.0-test10.
> > This is on a Gateway 600S laptop with a P4-M 2Ghz processor and an i845
> Brookdale
> > chipset.
> 
> Basically, there's something strange going on, which _seems_ to be memory
> corruption, and seems to correlate reasonable well (but not 100%) with
> CONFIG_PREEMPT.

Ah, I see. I thought there was a definite issue with a certain subsystem that
just hadn't been fixed yet when CONFIG_PREEMPT=y.

> 
> It's actually unlikely to be preemption itself that is broken: it's much
> more likely that some driver or other subsystem is broken, and preempt is
> just better at triggering it by making some race conditions much easier to
> see due to bigger windows for them to happen.
> 
> The problem is finding enough of a pattern to the reports to make sense of
> what seems to be the common thread. A lot of people use preemption without
> any trouble.

Indeed. Do the same subsystems usually show the memory corruption issue with
preempt active, or does it just pop up all over the place, unpredictably?

> 
> 		Linus

Brad


=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
