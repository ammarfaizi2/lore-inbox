Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUI1JKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUI1JKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 05:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUI1JKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 05:10:14 -0400
Received: from gprs214-20.eurotel.cz ([160.218.214.20]:19588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263795AbUI1JKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 05:10:08 -0400
Date: Tue, 28 Sep 2004 11:06:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ed Schouten <edschouten@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] i386: Xbox support
Message-ID: <20040928090641.GC18819@elf.ucw.cz>
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210> <4158AA5B.8090601@yahoo.com.au> <dc54396f040927214651393131@mail.gmail.com> <415915F0.2000803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415915F0.2000803@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Any real point to merging this? (I honestly don't know, I don't follow the
> >>xbox hacking scene).
> >
> >
> >Yes, it does (in my opinion). This small 7 KB patch allows you to run
> >a vanilla kernel on the machine (with exception of the video driver).
> >
> >I also noticed my previous mailclient (Squirrelmail) did some
> >linebreaking. Please notice:
> >
> >+ if ((bus == 0) && !PCI_SLOT(devfn) && ((PCI_FUNC(devfn) == 1) ||
> >(PCI_FUNC(devfn) == 2)))
> >
> >should be one line ;-)
> >
> >Yours sincerely,
> 
> Well, I ask because there is probably quite a large number of embedded type
> devices devices that you could "just add a small patch for" to get it 
> working.

Yes, and we support most of them :-). This is not really different
from all the arm platforms etc.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
