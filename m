Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTIAVwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTIAVwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:52:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8455 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263314AbTIAVwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:52:47 -0400
Date: Mon, 1 Sep 2003 22:52:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901225243.D22682@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901211220.GD342@elf.ucw.cz>; from pavel@suse.cz on Mon, Sep 01, 2003 at 11:12:20PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 11:12:20PM +0200, Pavel Machek wrote:
> He just thinks he can fix his code, and I want that code to be
> reverted, reviewed, tested, and than merged back. There's no way
> current mess can be fixed in reasonable time.

Please don't - that means undoing all the work I've put in to make
ARM work again, and I don't have time to play silly games like this.

We have the majority of the driver model power management back into
a working state (there are still some quirks left, but they are
trivially solvable - I just haven't had the time to sort them out
with Pat yet.)

Whether you like it or not, people are using and developing against
the new driver model code.  ARM uses the driver model pretty extensively,
and reverting these changes will only cause more work (which means I
get less time to look at serial, PCMCIA stuff and other stuff.)

The driver model at least should stay as is.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

