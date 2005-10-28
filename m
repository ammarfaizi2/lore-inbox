Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVJ1UwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVJ1UwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJ1UwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:52:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43187 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750741AbVJ1UwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:52:07 -0400
Date: Fri, 28 Oct 2005 22:51:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>, vojtech@suse.cz,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028205132.GB11397@elf.ucw.cz>
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz> <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com> <1130532239.4363.125.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130532239.4363.125.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Remove most useless printk in the world
> > > 
> > > It warns about crappy keyboards. It triggers regulary for me on x32,
> > > (probably because of my weird capslock+x+s etc combination). It is
> > > usefull as a warning "this keyboard is crap" and "no, bad mechanical switch
> > > is not the reason for lost key".
> > 
> > Okay, if you want a message to remind you that your keyboard is crap
> > several times a day, please keep your own patch to do so.  Let the
> > rest of the world go with Andi's patch.
> 
> Plus keyboards are a dime a dozen these days, they give you one with
> every server whether or not you want it.  If you have rack full of 1U
> servers the pile of keyboards will be as high as the rack.  I wish our
> KVM vendor would come haul them away.

Well, keyboard detected and reported an error. Kernel reacted with
printk(). You are removing that printk(). I can understand that,
printk is really annoying, but I really believe _some_ error handling
should be added there if you remove the printk.
								Pavel
-- 
Thanks, Sharp!
