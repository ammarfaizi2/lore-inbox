Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129994AbQK0Xpg>; Mon, 27 Nov 2000 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130127AbQK0Xp0>; Mon, 27 Nov 2000 18:45:26 -0500
Received: from nread2.inwind.it ([212.141.53.75]:2953 "EHLO relay4.inwind.it")
        by vger.kernel.org with ESMTP id <S129994AbQK0XpO>;
        Mon, 27 Nov 2000 18:45:14 -0500
Date: Tue, 28 Nov 2000 01:16:13 +0100
From: Gianluca Anzolin <root@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001128011613.A317@fourier.home.intranet>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <200011271849.eARInfc255418@saturn.cs.uml.edu> <8vubeq$r5r$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8vubeq$r5r$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 27, 2000 at 11:08:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno Mon, Nov 27, 2000 at 11:08:10AM -0800, H. Peter Anvin scrisse: 
|Yes, it can.  Unfortunately, some "legacy-free" PCs apparently are
|starting to take the tack that the KBC is legacy.  Therefore, the use
|of port 92h is mandatory on those systems.
|
|Port 92h dates back to at the very least the IBM PS/2.
|
|Either way, the video card of the original poster is broken in more
|ways than that.  Ports 0x00-0xFF are reserved for the motherboard
|chipset and have been since the original IBM PC.

I'd like to add only that the video card is integrated on the mainboard.
Maybe that register disables the integrated video card. I don't know.
Anyway I must also point out that on FreeBSD that register is used only
for IBM_L40 PC.
That said now I know how to make linux work again on this PC.
Let's see what will happen when 2.2.18 will come out as the new stable kernel.

Bye
	Gianluca

NB: the video card works without problems now. it's even found by lspci
(which couldn't find it before). I can also use any extended vga mode.
So the problem wasn't probably the video chipset.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
