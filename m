Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbUKXL2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUKXL2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbUKXL2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:28:50 -0500
Received: from gprs214-182.eurotel.cz ([160.218.214.182]:7040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262618AbUKXL2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:28:47 -0500
Date: Wed, 24 Nov 2004 12:28:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATH] swsusp update 1/3
Message-ID: <20041124112834.GA1128@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com> <20041123221430.GF25926@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123221430.GF25926@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok, Now I finised ppc part, it works. :) 
> > 
> > Here is all of the patch relative with your big diff.
> >  core.diff - swsusp core part.
> >  i386.diff - i386 part.
> >  ppc.diff  - PowerPC part.
> > 
> > Now we have a option in /proc/sys/kernel/swsusp_pagecache, if that is
> > sure using swsusp pagecache, otherwise.
> 
> Hmm, okay, I guess temporary sysctl is okay. [I'd probably just put
> there variable, and not export it to anyone. That way people will not
> want us to retain that in future.]

I've tried 11-24 version here, and it killed my machine during
suspend. (While radeonfb was suspended -> no usefull output). Can you
enable CONFIG_PREEMPT and CONFIG_HIGHMEM and get it to work?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
