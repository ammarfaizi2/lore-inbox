Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRAXWS2>; Wed, 24 Jan 2001 17:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRAXWST>; Wed, 24 Jan 2001 17:18:19 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:49676 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S132984AbRAXWSE>;
	Wed, 24 Jan 2001 17:18:04 -0500
Date: Wed, 24 Jan 2001 23:17:45 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101242217.XAA21787@db0bm.ampr.org>
To: vandrove@vc.cvut.cz
Subject: Re: display problem with matroxfb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Petr,

> It looks like that there is some problem with screen offset computation then.
> Can you try 'video=matrox:cross4MB' instead of '...:nopan'? I did not

video=matrox:cross4MB  works too !

> XF4.0.x should work reasonably well. Or you can run accelerated XF on mga:
> matroxfb is compatible with accelerated XF 3.3.x, and with accelerated
> XF 4.0.x WITHOUT enabled DRI (as DRI code reprograms hardware even if
> X are on background) (and 'Option "UseFBDev"' is required if you are
> using both heads of G400/G450 with XF4).

I am lost !!
I've XFree86 Version 3.3.6
I've and ATI AGP video card with an S3 chipset and 4Mb plus the Matrox Mystique
(PCI) with 8Mb.

I've told the BIOS to boot the AGP first. So I boot normaly with the display on
the ATI card. Then the system switches to the matrox (and Framebuffer). At this
time, I move manually the display to the Matrox board and all si right (I'm
doing this test before doing some cabling / modification on the 19" IBM
screen). If I start Xwindows with the SVGA accelerated server then it starts on
the ATI card. If I start it with the FBdev server, I get it on the Matrox card.
I've read some stuff in Framebuffer-HOWTO but I think I've still some
experiment to do.
IFAIK, there is no DRI option for the Mystique ... ??

--------

Best Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
