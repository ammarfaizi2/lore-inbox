Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTIAWTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTIAWTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:19:35 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:49042 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263316AbTIAWTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:19:33 -0400
Date: Tue, 2 Sep 2003 00:19:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901221920.GE342@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901225243.D22682@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > He just thinks he can fix his code, and I want that code to be
> > reverted, reviewed, tested, and than merged back. There's no way
> > current mess can be fixed in reasonable time.
> 
> Please don't - that means undoing all the work I've put in to make
> ARM work again, and I don't have time to play silly games like this.

Okay, so Patrick broke ARM and you fixed it. But he also broke i386 and
x86-64; and it is not at all clear that his "newer" version is better
than the old one. [Really, what's the advantage? AFAICS it is more
complicated and less flexible, putting "suspend" method to bus as
oppossed to device].

I guess I could survive dm changes going in, but breaking both driver
model, sleep support and all the drivers at same time is a bit too
much...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
