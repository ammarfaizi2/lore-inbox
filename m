Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTHYNzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTHYNzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:55:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261853AbTHYNwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:52:21 -0400
Date: Mon, 25 Aug 2003 14:52:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bad serio/atkbd configuration possible (was: Re: Compilation errors in 2.6.0-test4, serial as modules)
Message-ID: <20030825145218.E30952@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <032c01c36a36$2335ea20$24ee4ca5@DIAMONDLX60> <20030824133026.D16635@flint.arm.linux.org.uk> <089b01c36b0f$67d723e0$24ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <089b01c36b0f$67d723e0$24ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Mon, Aug 25, 2003 at 10:46:17PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 10:46:17PM +0900, Norman Diamond wrote:
> The boot-time errors in 2.6.0-test1 through test3, and then in test4 after I
> changed the keyboard stuff back from "m" to "y", are that module serial is
> not found.  These are not serio, but serial.  As far as I can tell, the
> serial stuff other than keyboard and mouse are still modules, so I don't
> know what is not being found.  Those messages scroll off the screen very
> quickly during boot, and they don't get logged, so I can't report them
> exactly.

If they were serial (as in ttyS0) then you're not giving me much to go
on to work out what's up, so I'm afraid I can't take very much action
to solve your problem.

> One other message that I've seen during boot is that boot logging is
> disabled because the console doesn't differ from the console.  I don't
> exactly understand this one either, but it's sure telling the truth about
> disabling boot logging.

I don't understand that either.  I'm not aware of there being any such
message in the kernel source.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

