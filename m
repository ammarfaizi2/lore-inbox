Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269315AbUINLtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269315AbUINLtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269302AbUINLro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:47:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21438 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269314AbUINLpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:45:21 -0400
Date: Tue, 14 Sep 2004 13:43:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914114341.GS2336@suse.de>
References: <20040914060628.GC2336@suse.de> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net> <20040914070649.GI2336@suse.de> <20040914071555.GJ2336@suse.de> <1095156542.16570.7.camel@localhost.localdomain> <20040914111207.GR2336@suse.de> <1095158149.16520.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095158149.16520.24.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Alan Cox wrote:
> On Maw, 2004-09-14 at 12:12, Jens Axboe wrote:
> > > Drive acked the command is all that proves. Maybe its a nop, maybe it
> > > does it, maybe like the last time someone engaged in this kind of "lets
> > > not check" approach it erases your firmware and leaves your CD-ROM drive
> > > defunct as the Mandrake error of the same form did.
> > 
> > Alan, you are sounding like a broken record :)
> 
> Thats because someone else appears incapable of listening and learning
> that issuing commands that may not be safe is not a good idea. I happen
> to think users should be able to expect their hardware not to go boom

If you had actually read the mail, you'd see that this was just an
experiment to see what kind of drive he had. I'm not suggestion to add
this back to the kernel.

> I've nothing against a well documented "actually I have a cache" option
> with appropriate warnings (and of course possibly a whitelist if we can
> get vendors to help). But one that like hdparm does bother to note when
> you may be playing with fire.

You should be able to turn on support from user space, if you so wish,
if you know that the drive works.

-- 
Jens Axboe

