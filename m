Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUKTWgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUKTWgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUKTWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 17:36:23 -0500
Received: from gprs214-248.eurotel.cz ([160.218.214.248]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263188AbUKTWeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 17:34:06 -0500
Date: Sat, 20 Nov 2004 22:41:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041120214139.GA984@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120081219.GA2866@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> > >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > > 
> > >   Test passed in my ppc and x86 laptop.
> > > 
> > >   ppc swsusp patch for 2.6.9
> > >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> > >   Have fun.
> > 
> > BTW here's my curent bigdiff. It already has some rather nice
> > swsusp speedups. Please try it on your machine; if it works for you,
> > try to send your patches relative to this one. I hope to merge these
> > changes during 2.6.11.
> 
> Here is the patch relative to your big diff. It tested pass with my x86
> pc, But the sysfs interface can't works, I using reboot system call.

Even without CONFIG_PREEMPT, it does NULL pointer dereference in
copy_data_pages.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
