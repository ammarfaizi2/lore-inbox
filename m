Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313258AbSDJPpX>; Wed, 10 Apr 2002 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSDJPpW>; Wed, 10 Apr 2002 11:45:22 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:51234 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S313258AbSDJPpV>; Wed, 10 Apr 2002 11:45:21 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A78177E34@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'davidsen@tmr.com'" <davidsen@tmr.com>, gandalf@winds.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: Using video memory as system memory
Date: Wed, 10 Apr 2002 10:43:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> In article 
> <Pine.LNX.4.44.0204091816380.13516-100000@winds.org> you write:
> | I have an old 586 that has low memory and no ability for 
> further upgrades.
> | I had an idea to use the framebuffer memory of a 32MB video 
> card lying around
> | the office as system memory and implemented the following patch:

I thought that this was interesting as well, and had a couple of questions,
as I am no expert in this stuff.

You don't have the frame buffer enabled for display when trying to use this
as system memory, correct?

Are there implications of the BIOS shadowing video memory to system memory,
or is that not an issue once Linux takes over memory control?

That is a neat idea, though.  The PCI/AGP bus may be a limiting factor for
this as well, correct?  As far as speed, I believe most video cards have
fast memory, vram, or sram, but it's only useful transferring between the
Video GPU, and Video cards memory, as the bus to the video card is the
bottleneck.

Just some random thoughts, cool idea, though..

Bruce H.


