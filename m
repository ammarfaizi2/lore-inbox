Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULAKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULAKKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULAKKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:10:19 -0500
Received: from gprs214-108.eurotel.cz ([160.218.214.108]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261347AbULAKJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:09:26 -0500
Date: Wed, 1 Dec 2004 11:08:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041201100854.GA1015@elf.ucw.cz>
References: <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de> <1101766833.4343.425.camel@desktop.cunninghams> <41AC6480.6020002@suse.de> <1101849416.5715.13.camel@desktop.cunninghams> <20041130222027.GE1361@elf.ucw.cz> <1101893275.5073.0.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101893275.5073.0.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > >>Putting only the absolutely necessary things into the kernel (the same
> > > > >>is true for the interactive resume thing - if someone wants interactive
> > > > >>startup at a failing resume, he has to use an initrd, i don't see a
> > > > >>problem with that) will probably increase the acceptance a bit :-)
> > > > > 
> > > > > That's fine if your initrd is properly configured and you're willing to
> > > > 
> > > > This is something distributions have to take care of.
> > > 
> > > No; it's something the users will have to take care of. Distro makers
> > > might make the process more automated, but in the end it's the user's
> > > problem if it doesn't work.
> > 
> > Actually, no, its not like that. 
> > 
> > User will click icon in KDE, and if it does not suspend & resume
> > properly, distribution has problem to fix. And yes, it works well in
> > SUSE9.2.
> 
> I didn't know you had support for initramfs and initrd configurations
> already. You are making progress.

Well, no, not that one.

OTOH for SUSE9.2 these things basically can not happen. (There's no
wrong kernel you can click on ;-) -- either you boot normally, then
there's just one kernel to boot, or you boot failsafe, and then you
want to kill signatures etc.) 
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
