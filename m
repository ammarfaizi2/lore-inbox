Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTIPGNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 02:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbTIPGNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 02:13:22 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:8615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261777AbTIPGNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 02:13:21 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.44.0309160011540.24675-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309160011540.24675-100000@deadlock.et.tudelft.nl>
Message-Id: <1063692749.585.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Sep 2003 08:12:29 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Same problem for me :)
> 
> I did post the driver on the Linux-fbdev and LinuxPPC mailinglists.
> Replies: 0. I also asked you, you didn't have time, no problem, but again
> no test. It gets merged, people start testing...

I know the problem, but I'm opposed to doing that in the middle
of a stable release.

> I agree the stable series should have a stable driver, I proposed that
> Marcelo would merge the driver, I would aggressively investigate problems,
> and in case of serious trouble a revert.

Ok, but then, we need to make sure it works. Most people won't test
before 2.4.23 is final and released by distros and at this point it
will be too late.

> > Why don't you push it to 2.6 first then backport to 2.4 ? That would
> > be better imho...
> 
> It's a possibility, Alexander Kern is porting the code to 2.6. But
> please wait a few days, it's quite likely things will be fixed and stable then.

Let's see...

Ben.


