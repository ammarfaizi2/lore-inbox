Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVAGN0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVAGN0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVAGN0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:26:03 -0500
Received: from gprs214-191.eurotel.cz ([160.218.214.191]:7040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261404AbVAGNZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:25:59 -0500
Date: Fri, 7 Jan 2005 14:25:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050107132546.GA1405@elf.ucw.cz>
References: <20050103122653.GB8827@hugang.soulinfo.com> <20050103221718.GC25250@elf.ucw.cz> <20050106160306.GA20127@hugang.soulinfo.com> <20050106223132.GD25913@elf.ucw.cz> <20050107014023.GA29740@hugang.soulinfo.com> <20050107095316.GB1300@elf.ucw.cz> <20050107131231.GA5345@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107131231.GA5345@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (When it was printing around 900, I switched to another console and
> > tried swsusp (worked ok), then tried again when it printed 1023).
> > 
> > I'm using patched kernel, however, and this patch might be
> > relevant. Can you try to apply it and see if problem goes away? [This
> > patch is ugly hack, but if it helps, we'll simply ask akpm to fix
> > free_some_memory :-)].
> 
> Yes, It works. :) 
>  36880 * 4096  ~151MB
> 
> Stopping tasks: ==========================================|
> Freeing memory... done (36880 pages freed)
> Freeing memory... done (5720 pages freed)
> Freeing memory... done (2816 pages freed)
> Freeing memory... done (1999 pages freed)
> Freeing memory... done (1954 pages freed)

Okay, so we have to fix free_some_memory, instead of hacking
refrigerator. Sorry.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
