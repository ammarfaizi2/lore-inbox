Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLBS4w>; Mon, 2 Dec 2002 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSLBS4w>; Mon, 2 Dec 2002 13:56:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28435 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264853AbSLBS4u>; Mon, 2 Dec 2002 13:56:50 -0500
Date: Mon, 2 Dec 2002 14:02:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
In-Reply-To: <Pine.LNX.4.33L2.0212020904210.27194-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1021202134845.433G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Randy.Dunlap wrote:

> On Wed, 27 Nov 2002, Bill Davidsen wrote:
> 
> | Knowing that modules are still broken, I changed all modules to be
> | built-in and dropped all support for modules and retried the compile. I
> | have disabled all but the features I really want to test on the new
> | kernel, so I will not be reducing the features any more.
> 
> I haven't seen any replies or fixes for this.  Have you?

No. I have pretty much assumed that there is no interest in having this
work. The modules are broken to the point where either the author or
someone who has documentation on how they should work will have to fix
them. Clearly the policy of "if you want your change in the kernel you
have to fix what it breaks" is dead.

> drivers/built-in.o(.data+0x31e14): undefined reference to `local symbols
> in discarded section .exit.text'
> 
> Please visit http://www.kernelnewbies.org/scripts/ and download
> the 'reference-discarded.pl' script, run it, and let us know where the
> problem is.

I posted that to the list, if it didn't make it for any reason I can't
easily recreate it, the machine has been converted to BSD, the 2.5 work is
on a removable drive which is removed, since we can't make any progress
with it for the moment.

It was the old tulip driver which had the problem, de21{something}x.c as I
recall. Without a doc on what causes that I gave up trying to fix it by
comparing to other modules.

Thanks for asking.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

