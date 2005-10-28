Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbVJ1VXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbVJ1VXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbVJ1VXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:23:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51089 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751757AbVJ1VXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:23:42 -0400
Date: Fri, 28 Oct 2005 23:23:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028212305.GA2447@elf.ucw.cz>
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz> <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com> <1130532239.4363.125.camel@mindpipe> <20051028205132.GB11397@elf.ucw.cz> <20051028205916.GL4464@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028205916.GL4464@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, keyboard detected and reported an error. Kernel reacted with
> > printk(). You are removing that printk(). I can understand that,
> > printk is really annoying, but I really believe _some_ error handling
> > should be added there if you remove the printk.
> 
> What do you suggest?

Well, having error counter for each input device would probably be
enough. Or perhaps add some rate-limiting. One message per boot should
be adequate.

> Having a TP 380XD which regularly produces this annoying message,
> it's just logspam.  There's no noticable failure.

I do notice lost keys on x32 here. You need to press some weird
combination...
							Pavel
-- 
Thanks, Sharp!
