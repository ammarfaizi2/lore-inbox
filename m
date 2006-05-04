Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWEDVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWEDVYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWEDVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:24:54 -0400
Received: from web.bloglines.com ([65.214.39.152]:16512 "HELO
	blw10.io.askjeeves.info") by vger.kernel.org with SMTP
	id S1750808AbWEDVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:24:54 -0400
Message-ID: <1146777893.3982259993.25862.sendItem@bloglines.com>
Date: 4 May 2006 21:24:53 -0000
From: grfgguvf.29601511@bloglines.com
To: linux-kernel@vger.kernel.org
Subject: Weird framebuffer bug?
MIME-Version: 1.0
Content-Type: text/plain;charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having a really strange bug where every fifth or so vertical line
is not displayed when running X using the framebuffer (so the right fifth
of the screen is also left black). And it's not the monitor settings. If the
image is stretched to fill the screen the lines are still omitted (It's an
LCD and it interpolates the lines so the whole image looks blurred).

However,
when taking a screenshot and later viewing with correct display, everything
looks OK on it.

Text mode on the framebuffer is OK, the whole screen is
filled. X using the video card directly is also OK.

Maybe this is an X
bug if yes then sorry for reporting at the wrong place.

Software used:

* Linux kernel 2.6.16, the binary version from Debian for 686
* vesafb framebuffer
driver as shipped with the kernel, loaded from module
* X11R7 Xorg server
1.0, again the Debian binary
* fbdev X driver as shipped with Xorg
* [nv
X driver (non-accelerated) when using X directly on the card]

The framebuffer
and X with both drivers is set to 24bit color mode.

Hardware:
* NVidia
GeForce 2, on AGP
* Samsung TFT LCD connected on a VGA cable
* [x86 machine]


Anyone else experienced a similar bug or know what can it be? I tried searching
around but nothing relevant.
