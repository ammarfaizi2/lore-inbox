Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131722AbRC0WcR>; Tue, 27 Mar 2001 17:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRC0WcI>; Tue, 27 Mar 2001 17:32:08 -0500
Received: from 46-ZARA-X26.libre.retevision.es ([62.82.241.46]:32781 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S131709AbRC0Wb6>;
	Tue, 27 Mar 2001 17:31:58 -0500
Message-ID: <3AC11468.9030308@zaralinux.com>
Date: Wed, 28 Mar 2001 00:30:00 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac24 i586; en-US; 0.8) Gecko/20010226
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linux Framebuffer <linux-fbdev@vuser.vu.union.edu>,
        "Rickard E. (Rik) Faith" <faith@valinux.com>,
        Daryll Strauss <daryll@valinux.com>, Hannu Mallat <hmallat@cc.hut.fi>
Subject: Voodoo 3 pci issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm using 2.4.2-ac24, Xfree86 4.0.2 + 4.0.3 upgrade, 
Glide_V3-2.60-16 & Glide_V3-DRI-3.10-6, and tdfx framebuffer.

My system is a 2x200MMX on a Gigabyte 586DX with 96Mb, a Voodoo3 2000 
pci and a bt848 tv card.

I have the card working ok, except for a few nonstopers.

- I cannot use the 3D part of my card with XFree 4.x (it worked with 
3.3.x) it doesn't matter whether I use or not tdfx.o or whether or not I 
put a LoadModule dri in the XF86Config. Only root can run the test3Dfx 
program, and when the program finish X is restored but freezed, so I 
have to do a SysRQ-K to kill it.

- If I try to use fbtv (watch tv in FB) the system hangs, the program 
starts, and I can see the tv on the screen, but the system is freezed.

- If I put a LoadModule dri in the XF86Config, I cannot use the virtual 
consoles. If I go to a text console (tdfx frame buffer at 100x37) I see 
the contents of the text console (issue and login prompt), but I see a 
line near the top of the console of random pixels of one pixel that 
paints pixels from left to rigth from top to botttom, and I cannont see 
what I'm typing. I can ony come back to X. When I'm on that VT if I 
switch to another VT I still see the contents of the first VT that I 
switched from X.

Thanks for your patience.

-- 
Jorge Nerin
<comandante@zaralinux.com>

