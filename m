Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131601AbRCURDF>; Wed, 21 Mar 2001 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbRCURCq>; Wed, 21 Mar 2001 12:02:46 -0500
Received: from snipe.prod.itd.earthlink.net ([207.217.120.62]:5274 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131601AbRCURCd>; Wed, 21 Mar 2001 12:02:33 -0500
Date: Wed, 21 Mar 2001 09:02:57 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Message-ID: <Pine.LNX.4.31.0103210900050.2648-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Ok, I see. Currently, the sleep process is started from an ioctl sent to
>another driver, which will in turn call various notifier functions to
>shut down bits of hardware and finally put the machine to sleep. It's not
>a direct ioctl to the /dev/fb (which may not be opened).

[snip]...

I need to ask you where is this code? I like to take a look at it to
figure out what you are doing.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

