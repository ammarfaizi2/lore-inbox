Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbSJJJKf>; Thu, 10 Oct 2002 05:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJJJKf>; Thu, 10 Oct 2002 05:10:35 -0400
Received: from ulima.unil.ch ([130.223.144.143]:14208 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263356AbSJJJKe>;
	Thu, 10 Oct 2002 05:10:34 -0400
Date: Thu, 10 Oct 2002 11:16:18 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.n* and atyfb: why such colours???
Message-ID: <20021010091618.GB2874@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since some kernels revision, it begins to boot with the white on black,
and the at atyfb initialisation, the white is remplaced by blue and I
can't read anymore???

>From dmesg:

atyfb: 3D RAGE PRO (BGA, AGP) [0x4742 rev 0x7c] 8M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI

And I use this in lilo.conf:

vga = extended
append="video=atyfb:1024x768-16@100"

I'll should maybe retry without the vga arg???

Thank you very much and have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
