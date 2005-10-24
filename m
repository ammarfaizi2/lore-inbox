Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVJXWJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVJXWJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVJXWJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:09:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24728 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750968AbVJXWJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:09:11 -0400
Date: Tue, 25 Oct 2005 00:09:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Sharp brick c-3000
Message-ID: <20051024220901.GD10057@elf.ucw.cz>
References: <20051024211632.GA7127@elf.ucw.cz> <1130191145.8345.185.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130191145.8345.185.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure what I did wrong... I can still access "flasher" menu, by
> > holding down okay after reset, I press 4, 2, Y after that, screen just
> > goes black, but I do not get "update screen" after that. SD inserted
> > or not, no change. I'll play a bit more.
> 
> Ah, I can guess :-(. Have a look at this:
> http://www.h5.dion.ne.jp/~rimemoon/zaurus/pic/nandmap.jpg (from
> http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm)
> 
> updater.sh writes the kernel into the space marked "2nd Kernel" - 1264kb
> long. I'd guess you wrote a kernel larger than this, you overwrite
> the

Last kernel I flashed was 1285752 bytes big...

> initrd.gz which is used to run updater.sh. We really need to add a size
> check to the OE copy of updater.sh. Anyhow, the damage has been done and
> that update route is now broken. I should have warned about this
> although I assumed Sharp might have fixed it on newer devices :-/.

Heh, apparently they did not :-(. Or I have some other problem.

> Your other alternative is to perform a NAND Restore, if you can find a
> NAND backup for the C3000. The D+M menu has an option for this and I'm
> sure it will also be documented on the web. When in this state I
> couldn't get that to work on my c760 though it could have been the image
> I was trying to restore it with or my CF card...

I can't seem to enter D+M menu. Instructions say "wait for up-to an
hour", so I guess that's what I should do.

> Incidentally OE has safeguards that warn you if the kernel is too big...

I should really learn how to use that framework...
								Pavel

-- 
Thanks, Sharp!
