Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271699AbTG2Mtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271700AbTG2Mtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:49:31 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S271699AbTG2Mta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:49:30 -0400
Date: Tue, 29 Jul 2003 13:59:41 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307291259.h6TCxfC3000230@81-2-122-30.bradfords.org.uk>
To: helgehaf@aitel.hist.no, jamie@shareable.org
Subject: Re: The well-factored 386
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I didn't realise he was talking about an x86 emulator.  I thought he
> > was analyzing real hardware.
> > 
> > The one thing that made it on-topic for me was his quiet suggestion
> > that "forreal" mode interrupts are faster, and that it might, perhaps,
> > be possible to modify a Linux kernel to run in that mode - to take
> > advantage of the faster interrupts.
>
> That would have to be a kernel for very special use.  The "forreal"
> mode has protection turned off.  As far as I know, that
> means any user process can take over the cpu as if
> it was running in kernel mode.
>
> Perhaps useful for some embedded use with only a couple well-tested
> processes running.  Still, a programming error could overwrite
> kernel memory instead of segfaulting.

Anything that's single user and non-networked isn't beyond the realms
of feasability - it would be useful for a games console, or high
performance graphics work.

It would be an interesting project, but what concerns me is how well
implemented these non-standard modes actually are.  It's possible that
there are processors out there that don't work reliably with them, or
don't implement them at all.

John.
