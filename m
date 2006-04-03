Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWDCDrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWDCDrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 23:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWDCDrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 23:47:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964829AbWDCDrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 23:47:08 -0400
Date: Sun, 2 Apr 2006 20:47:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.17-rc1
Message-ID: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 it's two weeks since 2.6.16, and the merge window is closed.

As usual, the -rc1 patch is pretty damn large, and even the ShortLog is 
too big to pass the linux-kernel mailing list posting size limits, but my 
gut feel is that a large portion of that ends up being things like new 
drivers, and a lot of it is less scary than the early 2.6.16 changes, for 
example.

Of course, my gut feel is usually wrong.

The most notable change here might be the merged support for Sun's Niagara 
architecture, but there's a lot of other stuff going on too: DVB 
re-organizations, nfs/knfsd updates, x86-64/parisc/mips/powerpc updates, 
ALSA, SCSI, Infiniband.. 

At the same time, a there's also a fair amount of just cleanups (BUG_ON 
conversion, semaphore->mutex conversions, bitops cleanups etc). 

Go wild. As usual, if you're a git user, the way to see what has changed 
is

	git log v2.6.16..v2.6.17-rc1 | git-shortlog | less

and if you're interested in just a particular sub-area, give it as a 
restriction to "git log" (ie you can do "git log v2.6.16.. drivers/net/ |.." 
to see just changes that affected network drivers).

For the rest of you, there's the tar-balls, patches, and full ChangeLog.

		Linus
