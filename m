Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291869AbSBTOMp>; Wed, 20 Feb 2002 09:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291863AbSBTOM0>; Wed, 20 Feb 2002 09:12:26 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:45820 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S291859AbSBTOMU>; Wed, 20 Feb 2002 09:12:20 -0500
Subject: Re: Problems with Radeon Framebuffer
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020220123931.281e070a.hanno@gmx.de>
In-Reply-To: <20020219234939.0d8597fb.hanno@gmx.de>
	<DF415341-25A3-11D6-B291-000393843900@metaparadigm.com> 
	<20020220123931.281e070a.hanno@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 09:12:15 -0500
Message-Id: <1014214335.11442.58.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 06:39, Hanno Boeck wrote:
> > Did you have vesafb compiled in also (can tell by looking at the entire 
> > dmesg)? This would explain why radeonfb can't map the framebuffer 
> > memory. If so, try again without vesafb compiled in.
> 
> If I do that, my console is completely black!
> I don't have a console any more. I can only run Xfree.
> 
> So that doesn't help either.
> 
> Btw, this is what lspci -v says about my graphics card:
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Flags: stepping, fast Back2Back, 66Mhz, medium devsel, IRQ 9
> 	Memory at d8000000 (32-bit, prefetchable) [size=128M]
> 	I/O ports at 3000 [size=256]
> 	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [58] AGP version 2.0
> 	Capabilities: [50] Power Management version 2

Not this this answers your question, but I can say that this card works
with vesafb by passing 'vga=834' to the kernel-- I do that on a laptop
with the same chip.  But if I enable the frame buffer using this method,
I can't use the radeon driver in XFree86.  But, the radeon driver isn't
stable enough for me so I don't mind not using it.  Haven't tried
XFree86 4.2 yet though (or radeonfb for that matter).

Jamie Strandboge
-- 
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

