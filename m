Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291781AbSBTLkY>; Wed, 20 Feb 2002 06:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291782AbSBTLkO>; Wed, 20 Feb 2002 06:40:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:39355 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291781AbSBTLj7>;
	Wed, 20 Feb 2002 06:39:59 -0500
Date: Wed, 20 Feb 2002 12:39:31 +0100
From: Hanno Boeck <hanno@gmx.de>
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Radeon Framebuffer
Message-Id: <20020220123931.281e070a.hanno@gmx.de>
In-Reply-To: <DF415341-25A3-11D6-B291-000393843900@metaparadigm.com>
In-Reply-To: <20020219234939.0d8597fb.hanno@gmx.de>
	<DF415341-25A3-11D6-B291-000393843900@metaparadigm.com>
X-Mailer: Sylpheed version 0.7.2claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you have vesafb compiled in also (can tell by looking at the entire 
> dmesg)? This would explain why radeonfb can't map the framebuffer 
> memory. If so, try again without vesafb compiled in.

If I do that, my console is completely black!
I don't have a console any more. I can only run Xfree.

So that doesn't help either.

Btw, this is what lspci -v says about my graphics card:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80e7
	Flags: stepping, fast Back2Back, 66Mhz, medium devsel, IRQ 9
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
