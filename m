Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUKKLPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUKKLPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbUKKLON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:14:13 -0500
Received: from [195.135.223.242] ([195.135.223.242]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262208AbUKKLLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:39 -0500
Date: Thu, 11 Nov 2004 00:44:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [no problem] PC110 broke 2.6.9
Message-ID: <20041110234442.GF1099@elf.ucw.cz>
References: <20041106232228.GA9446@apps.cwi.nl> <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org> <1099791769.5564.118.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099791769.5564.118.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ahh.. Interesting. One improvement might be to make sure that this driver 
> > links in very late in the game, so that if any other drivers have 
> > allocated the IO, at least it won't override that. Also, it might make 
> > sense to say that the dang thing can share interrupts.
> 
> It can't share interrupts.
> 
> > But yes, we should probably make sure to make it harder to enable the
> > driver by mistake, and try to do minimal probing of it. I have no idea how
> > to probe for the thing, though.
> 
> I never found anything. 

Perhaps disable the driver is machine is not intel 486?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
