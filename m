Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUA0Xjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0XjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:39:21 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:58630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264925AbUA0Xhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:37:39 -0500
Date: Tue, 27 Jan 2004 23:37:32 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Kiko Piris <kernel@pirispons.net>
cc: Xan <DXpublica@telefonica.net>, Zack Winkles <winkie@linuxfromscratch.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
In-Reply-To: <20040127225909.GA5271@sacarino.pirispons.net>
Message-ID: <Pine.LNX.4.44.0401272331410.19265-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I did _not_ booted fine. I tried if with vga=795 it booted fine as you and the 
> > same result as 791 obtained: black screen until X window appears. When I 
> > switch to pty, black screen or color (and deformed) puzzle of X window 
> > contain.
> 
> In 2.6.1 I could use framebuffer through vesafb just with that parameter
> (vga=795, ie. 1280x10224 16M).

This is very strange. 

> In 2.6.2-rc* it does not work for me, just blank screen if I try to use
> vesafb.

I know this is not my recent patch I sent to linus since I just sent it to 
him yesterday.

> Zack Winkles pointed me that I could try passing
> video=vesafb:ywrap,pmipal,mtrr,vga=795 to get vesafb working.
> 
> Thanks for it. Right now I'm on travel and I can not try it, I will be
> able to do so on thursday.

Give it a try. If you have problems use my patch at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> Althoug, I would prefer to use radeonfb instead of vesafb (radeonfb
> turns off my monitor and vesafb does not).
> 
> Anyone with a Radeon 9200 does use radeonfb ? If yes, any special boot
> parameter?

Try my newest patch. It has a updated radeon driver.


