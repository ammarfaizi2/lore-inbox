Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUA0SBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUA0SBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:01:07 -0500
Received: from smtp.infonegocio.com ([213.4.129.150]:36572 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S262015AbUA0SBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:01:02 -0500
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: Kiko Piris <kernel@pirispons.net>
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Date: Tue, 27 Jan 2004 18:59:03 +0100
User-Agent: KMail/1.5.4
Cc: Zack Winkles <winkie@linuxfromscratch.org>, linux-kernel@vger.kernel.org
References: <200401270153.12568.DXpublica@telefonica.net> <200401271324.33883.DXpublica@telefonica.net> <20040127131922.GA20659@pirispons.net>
In-Reply-To: <20040127131922.GA20659@pirispons.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401271859.03309.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimarts 27 Gener 2004 14:19, en/na Kiko Piris (<Kiko Piris 
<kernel@pirispons.net>>) va escriure:

> On 27/01/2004 at 13:24, Xan wrote:
> > Sorry. My graphics cards is ATI Radeon 9200.
>
> Same graphics card here [1]. _Almost_ same problem:
>
> I booted 2.6.1 with vga=795. It booted fine.

I did _not_ booted fine. I tried if with vga=795 it booted fine as you and the 
same result as 791 obtained: black screen until X window appears. When I 
switch to pty, black screen or color (and deformed) puzzle of X window 
contain.

>
> In 2.6.2-rc[12] I get a blank screen booting with that vga parameter.
>
> With 2.6.1 if I tried to use radeonfb, system just booted with a vga
> console and no fbdevice was available. If I try to use radeonfb in
> 2.6.2-rc[12] it only works with 640x480 resolution (any other resolution
> results in an unsupported frequency on my monitor, system boots fine,
> tough).
>
> _Plus_, if I try to change the resolution (with fbset) on my radeonfb
> console, it changes; but when I switch to another tty, the monitor gets
> an unsupported frequency again and the only way to restore the image is
> to blindly set the resolution again to 640x480 with fbset.
>
> Relevant part of config follws:
>
> $ cat /boot/config-2.6.2-rc2 | grep ^CONFIG | egrep -i "fb|radeon|console"
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_DRM_RADEON=m
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FB_RADEON=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
>

I put the same in console and I obtain the same as you.
It's rare thing: I could promise that I compiled 2.6.0 with the same 
configuration and it worked.

We have to download 2.6.0 and try....

> This output is exactly the same for 2.6.1, 2.6.2-rc1 and 2.6.2-rc2.
>
> Please, let me know if I can provide any additional information.
>
> Thanks in advance.
>

Can you explain me what means 791, 795, ... and what number belongs to 
1024x768 and 16 colors, and if 800x600 and 256?...

Thank you very much,
Xan.

