Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269323AbUINLnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269323AbUINLnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269302AbUINLkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:40:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57532 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269314AbUINLi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:38:57 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914111207.GR2336@suse.de>
References: <20040914060628.GC2336@suse.de>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
	 <20040914070649.GI2336@suse.de> <20040914071555.GJ2336@suse.de>
	 <1095156542.16570.7.camel@localhost.localdomain>
	 <20040914111207.GR2336@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095158149.16520.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:35:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 12:12, Jens Axboe wrote:
> > Drive acked the command is all that proves. Maybe its a nop, maybe it
> > does it, maybe like the last time someone engaged in this kind of "lets
> > not check" approach it erases your firmware and leaves your CD-ROM drive
> > defunct as the Mandrake error of the same form did.
> 
> Alan, you are sounding like a broken record :)

Thats because someone else appears incapable of listening and learning
that issuing commands that may not be safe is not a good idea. I happen
to think users should be able to expect their hardware not to go boom

I've nothing against a well documented "actually I have a cache" option
with appropriate warnings (and of course possibly a whitelist if we can
get vendors to help). But one that like hdparm does bother to note when
you may be playing with fire.

Alan
