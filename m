Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbTLaEGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbTLaEGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:06:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:16059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266105AbTLaEGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:06:31 -0500
Date: Tue, 30 Dec 2003 20:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: claas@rootdir.de, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.0: atyfb broken
Message-Id: <20031230200653.7bc8a8cf.akpm@osdl.org>
In-Reply-To: <20031230212609.GA4267@rootdir.de>
References: <20031230212609.GA4267@rootdir.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claas Langbehn <claas@rootdir.de> wrote:
>
> Hello,
> 
> I have got an HP omnibook 4150B. When booting with atyfb,
> the kernel messages look great:
> 
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> fb0: ATY Mach64 frame buffer device on PCI
> 
> But either the screen is black and I see only the cursor and Background
> colors (CONFIG_FRAMEBUFFER_CONSOLE disabled), but X11 starts fine.
> 
> 
> With CONFIG_FRAMEBUFFER_CONSOLE enabled it does not work at all:
> I get a completely broken picture that is not syncing and blinking and so on.
> Its completely useless. X11 will not work either :(
> 

The framebuffer drivers in 2.6.0 aren't very up to date, and don't work
very well.  There are many fixes sitting out in an external tree and we'll
try to start merging that work up next month.

Ben, if you could shoot me over a copy of the current linux-fbdev tree that
might help things along a bit.

