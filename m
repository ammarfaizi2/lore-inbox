Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTIEUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbTIEUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:42:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5762 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262887AbTIEUmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:42:04 -0400
Date: Fri, 5 Sep 2003 22:42:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905204215.GC220@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk> <1062498096.757.45.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062498096.757.45.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel, please keep in mind that proper PM is a difficult task, what we
> had before was full of holes, we spent a significant amount of time over
> the past year debating the right way to do all of this and Patrick spent
> even more time actually implementing it, so rather than just crying
> loud, I'd epxect you rather help us fixing what still need to be.

I was screaming out loud because I did not see the patch coming. It
simply materialized in Linus' tree. Exactly because PM is hard, I'd
expect "here's rewrite of driver model, please test it on your
hardware" mail on lkml before it is merged.

Anyway, ad uhci: it seemed to work well in -test3. What's current
status of pm_send_all() interface? I think pm_send_all() was
responsible for UHCI working...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
