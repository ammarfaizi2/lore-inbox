Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUJSASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUJSASW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUJSASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 20:18:22 -0400
Received: from [69.4.201.55] ([69.4.201.55]:60304 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S268031AbUJSASO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 20:18:14 -0400
Message-ID: <41745D41.50306@bitworks.com>
Date: Mon, 18 Oct 2004 19:18:09 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
References: <200410160946.32644.adaplas@hotpop.com>	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com>	 <9e47339104101814166bf4cfe5@mail.gmail.com>	 <41744505.4080507@bitworks.com> <9e47339104101816282ba385d2@mail.gmail.com>
In-Reply-To: <9e47339104101816282ba385d2@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> LinuxBIOS can do things the real kernel probably shouldn't be doing.
> For example on an x86 it can find the expansion ROMs and post all of
 > the video cards. On non-x86 it can embed emu86 and run the ROMs that
 > way. And for a few cards that we have the docs on it can directly
 > initialize them.  These options should be selected when LinuxBIOS is
 > built for the hardware.

Well we see it the other way around.  We want to do a little as possible 
and let Linux handle as much as possible.  Otherwise your bios turns 
into a mini-OS.  The path is littered with dead projects that went that 
route.  Keeping current with driver support kills them.

> But getting Int10 video up and running does not mean that the kernel
> framebuffer/DRM subsystem has to be up and running. Int10 or Open

Agreed.

> it, then it is the hardware manufacturer responsibility to acquire
> enough documentation from the graphics vendor so that a boot display
> can be implemented.

If only it were that easy. *grin*

Ok well I really don't want to start a off-topic argument here so I'll 
shut up after this. Especially since I'm not really argueing anything 
that hasn't already be thrashed over many times.

I and many others would like to see a unified int10 solution that could 
be used by as many projects that need it rather than the fragmented 
setup we have now.  The kernel proper may or may not be one of those.

-- 
Richard A. Smith


