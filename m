Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJXGiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTJXGiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:38:50 -0400
Received: from dp.samba.org ([66.70.73.150]:6851 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262033AbTJXGir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:38:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: PARTIAL success with ACPI S3 suspend to ram on Acer TravelMate 800LCi 
Cc: Martin Loschwitz <madkiss@madkiss.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: Your message of "Sat, 18 Oct 2003 22:34:11 +0200."
             <20031018203409.GN395@elf.ucw.cz> 
Date: Fri, 24 Oct 2003 14:19:01 +1000
Message-Id: <20031024063847.529F72C102@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031018203409.GN395@elf.ucw.cz> you write:
> Hi!
> 
> > The saga ([0] and [1]) continues, here are the latest facts about ACPI S3
> > suspend to ram mode with the Acer TravelMate 800LCi notebook.
> > 
> > With Linux 2.6.0-test8, there is some kind of partial success: After doing
> > "echo -n mem > /sys/power/state" the box suspends and after pressing a key
> > on the keyboard the box resumes. The box reacts to input afterwards, for
> > example one can do "reboot" as root and even pressing the power key does
> > what it is supposed to do. Unfortunately there is one big disadvantage:
> > The panel of the notebook stays completely black. I tried booting with
> > "acpi_sleep=s3_{mode,boot}" but in both cases, the box apparently hangs
> > while trying to resume (no [blind] keyboard input possible, pressing the
> > power button has no effect)
> 
> Good. [Well, good for me, very bad for you.]
> 
> This is known problem, see below. I don't really know what other dirty
> hack to try. I'm afraid its your turn.
> 
> Rusty, could you make this go in? This is becoming FAQ :-(. Perhaps
> some other ideas can be added if it is in the source tree.

Hmm, prefer not to take it.  Straight to Linus?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
