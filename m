Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTLCOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 09:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTLCOR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 09:17:28 -0500
Received: from web41215.mail.yahoo.com ([66.218.93.48]:44701 "HELO
	web41215.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264568AbTLCOR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 09:17:27 -0500
Message-ID: <20031203141725.3429.qmail@web41215.mail.yahoo.com>
Date: Wed, 3 Dec 2003 06:17:25 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: Re: [2.6.0-test11]: It doesn't boot with a bootcd
To: Jonathan Fors <etnoy@myrealbox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3FCDAD1D.5080001@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use Lilo way as following:

append initrd=ramdisk.img root=/dev/ram0 rootfs=tmpfs vga=791
The "vga=normal" acts like no framebuffer (same problem). If I don't use the
framebuffer, I don't pass vga=791.

I don't see any boot ptompt and I watch the little led on cdrom. It doen't seem
to load anything. When I push the cd eject button, the cd comes out. Usually
when it loads, it doesn't come out by pushing the button.
Jin

--- Jonathan Fors <etnoy@myrealbox.com> wrote:
> Are you booting with Lilo? Then you could try to pass the vga=normal 
> parameter to the bootloader in lilo.conf . I'm not sure with Grub, but I 
> bet somebody else here is.
> 
> If you let the booting progress continue blind-headed, can you login or 
> wait for X to start? It's possible that the system actually boots, just 
> that you don't see it.
> 
> Jonathan
> 
> Jin Suh wrote:
> 
> >With framebuffer option on, it went to out ot range on my monitor shortly
> after
> >I see Loading Linux.... and about 10 lines of boot messages (couldn't read
> the
> >messages).
> >Without framebuffer option, my monitor goes to a messed-up color right after
> I
> >see Loading Linux... and few other lines. 
> >
> >Thanks,
> >Jin
> >
> >  
> >
> 


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
