Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSLTTzE>; Fri, 20 Dec 2002 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSLTTzE>; Fri, 20 Dec 2002 14:55:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:21254 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265222AbSLTTy6>; Fri, 20 Dec 2002 14:54:58 -0500
Date: Fri, 20 Dec 2002 20:03:00 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: vesafb no longer works on 2.5.50/51
In-Reply-To: <20021212192937.GA132@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0212202002270.8777-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On one of my machines, vesafb no longer works in 2.5.51 (other machine
> is okay?!).
> 
> Everything is okay, except I can not see anything on the display.
> 
> 2.4. (vesafb works):
> vesafb: framebuffer at 0xee000000, mapped to 0xd080d000, size 8192k
> vesafb: mode is 1024x768x16, linelength=2048, pages=4
> vesafb: protected mode interface info at c000:7652
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> 
> 2.5.51 (vesafb does not work):
> vesafb: framebuffer at 0xee000000, mapped to 0xd0815000, size 8192k
> vesafb: mode is 1024x768x16, linelength=2048, pages=4
> vesafb: protected mode interface info at c000:7652
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0

Can you try my patch to cfbimgblt.c in another post to see if that fixes 
teh problem.

