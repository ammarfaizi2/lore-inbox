Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263010AbSJBJQ2>; Wed, 2 Oct 2002 05:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbSJBJQ1>; Wed, 2 Oct 2002 05:16:27 -0400
Received: from ulima.unil.ch ([130.223.144.143]:9603 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263010AbSJBJQ0>;
	Wed, 2 Oct 2002 05:16:26 -0400
Date: Wed, 2 Oct 2002 11:21:55 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Strange colours in console under 2.5.40 with atyfb
Message-ID: <20021002092155.GA3247@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the console are quiete unusable with atyfb here: everything is written
in blue ???

I have put the dmesg here:
http://ulima.unil.ch/greg/linux/dmesg-2.5.40
And the config file I used to compil the kernel here:
http://ulima.unil.ch/greg/linux/config-2.5.40

>From dmesg I don't see any problem:

tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A
atyfb: 3D RAGE PRO (BGA, AGP) [0x4742 rev 0x7c] 8M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI
pty: 256 Unix98 ptys configured

And in my lilo.conf:

append="video=atyfb:1024x768-16@100"

Have I done something wrong or is there a problem anywhere?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
