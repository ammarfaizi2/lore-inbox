Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270900AbTGPPJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270904AbTGPPJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:09:10 -0400
Received: from ATuileries-102-1-2-177.w193-253.abo.wanadoo.fr ([193.253.207.177]:36251
	"EHLO ttimo.net") by vger.kernel.org with ESMTP id S270900AbTGPPIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:08:42 -0400
Date: Wed, 16 Jul 2003 17:23:31 +0200
From: Timothee Besset <ttimo@idsoftware.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20030716172331.3bd3610e.ttimo@idsoftware.com>
In-Reply-To: <200307161608.34637.m.watts@eris.qinetiq.com>
References: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
	<200307161608.34637.m.watts@eris.qinetiq.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
X-SA-Exim-Mail-From: ttimo@idsoftware.com
Subject: Re: VESA Framebuffer dead in 2.6.0-test1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0 (built Sun Jun  8 21:12:30 CEST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem. It boots but I have no console. In 2.5 there was
an item 'enable virtual console' (in Character Devices) which I had
enabled, and the boot console was showing. I didn't see this option
displayed when I configured 2.6 from scratch (CONFIG_VT stuff)

TTimo

On Wed, 16 Jul 2003 16:08:34 +0100
Mark Watts <m.watts@eris.qinetiq.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > Hi.
> >
> > A number of people have experienced the same problem as I have; the VESA
> > framebuffer is just..black on boot. I haven't seen any reports on this,
> > though. dmesg says what it always have said before about the fb.
> >
> > I boot with vga=791 (as specified in lilo.conf).. Have something changed
> > or is it just broken? :o)
> >
> > Thanks.
> 
> I boot with vga=0x343 (1400x1050) and its working fine (2.6.0-test1)
> 
> This is a Dell Latitude C610 laptop, so it may be using the ati framebuffer 
> stuff, although I get this in dmesg:
> 
> vesafb: framebuffer at 0xe0000000, mapped to 0xd8800000, size 16384k
> vesafb: mode is 1400x1050x24, linelength=4200, pages=2
> vesafb: protected mode interface info at c000:5378
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
> fb0: VESA VGA frame buffer device
> Console: switching to colour frame buffer device 175x65
> 
> Mark.
> 
> - -- 
> Mark Watts
> Senior Systems Engineer
> QinetiQ TIM
> St Andrews Road, Malvern
> GPG Public Key ID: 455420ED
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE/FWpyBn4EFUVUIO0RAjqwAJ43U2vmUw7kMFkoeIsdDLyxhAbLBQCgmMST
> LO8Pk8CAhCD0Uq/kuPd9hBo=
> =W+2A
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


