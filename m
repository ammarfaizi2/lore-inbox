Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVC2SQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVC2SQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVC2SQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:16:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42466 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261283AbVC2SQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:16:06 -0500
Date: Tue, 29 Mar 2005 20:15:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: romano@dea.icai.upco.es, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Message-ID: <20050329181551.GA8125@elf.ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es> <20050329170238.GA8077@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329170238.GA8077@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >    swsusp is not working for me with 2.6.12rc1. I compiled the kernel
> > >    preempt, I am compiling now without preempt to test it. -mm3 has a
> > >    similar behaviour.
> > 
> > Tested with no-preempt -rc1-mm3. No joy; the suspend stops exactly at the
> > same point. 
> 
> Double auto-answer. I have a serial console now; if anybody can help me to
> explain why (after booting with console=ttyS0,115200 console=tty0) if I do a
> sysrq-t on the serial console appears just the "[4295210.188000] SysRq :
> Show State" and not the dump which appears only to the virtual console... 

I'd start with non-preempt 2.6.12-rc1, then remove all the
unneccessary drivers, boot init=/bin/bash, and see what happens.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
