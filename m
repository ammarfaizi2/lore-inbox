Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUCQWqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUCQWqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:46:40 -0500
Received: from main.gmane.org ([80.91.224.249]:15242 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262124AbUCQWqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:46:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Wed, 17 Mar 2004 23:46:34 +0100
Message-ID: <MPG.1ac2f3b3ae2e948c989687@news.gmane.org>
References: <MPG.1ac04509fe5b83d7989685@news.gmane.org> <Pine.LNX.4.44.0403172149140.19415-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-171-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > > I tried vga=ask, and no VESA modes are detected.
> > 
> > Ok, I'm stupid. I tried vga=ask, told him to scan, still got no VESA 
> > modes in the list, but thenand tried 318; it gave me 1024x768 (so did 
> > 718 too, any reason why?). Can't get to 1600x1200, though (or at 
> > least I don't know how.)
> 
> For some reason it never list the VESA modes with vga=ask. I just go by 
> the does in Documentation/fb/vesafb.txt to set my mode. Let me look...
> 
> I need to add more info to the docs on what modes are supported. 
> 	1600x1200		
> 	---------
> 256	0x119	  0x145	
> 32K	0x11D	  0x146
> 64K	0x11E
> 16M		  0x14E
> 
> For lilo translate them to decimal number. I'm curious if the 14X numbers 
> work.

I guess I would have to input 31e or 34e at the vga=ask prompt, 
right? Well, I never managed to get a code with letters to work :( I 
will try again ...

> > Now that I can work with the VESA driver, I'm feeling much better, 
> > but if I load the rivafb driver I *still* get the problem (I cannot 
> > touch it, not even with fbset -i). Using 2.6.4;
> > 
> > Just for reference, these are the logs from vesafb, rivafb and lspci:
> 
> > >From rivafb:
> > ===
> > rivafb: nVidia device/chipset 10DE0112
> > rivafb: On a laptop.  Assuming Digital Flat Panel
> > rivafb: Detected CRTC controller 1 being used
> > rivafb: RIVA MTRR set to ON
> > rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 
> > 32MB @ 0xE0000000) 
> > ===
> > 
> > In this case, fbset -i returns (well, doesn't because the screen goes 
> > black, but the computer is still fully functional):
> 
> That a bug I have to work. I have a newer driver but I need to run more 
> test.

If you want, I can try and test it on my computer too (if you can 
guarantee it doesn't format my hard drive and give my syphilis ;))

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

