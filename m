Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSL0MQG>; Fri, 27 Dec 2002 07:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSL0MQF>; Fri, 27 Dec 2002 07:16:05 -0500
Received: from jalapeno.jellybean.co.uk ([212.78.70.100]:45577 "EHLO
	jalapeno.crazydogs.org") by vger.kernel.org with ESMTP
	id <S264908AbSL0MQF>; Fri, 27 Dec 2002 07:16:05 -0500
Date: Fri, 27 Dec 2002 12:24:21 +0000
From: Ben Bell <bjb@deus.net>
To: linux-kernel@vger.kernel.org
Subject: Hangs (no Sysrq) on Duron + KT333?
Message-ID: <20021227122421.GA26589@deus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing random hangs on my Linux box using 2.4.x kernels.
I have tried numerous versions (up to and including 2.4.20) with no luck.

I can not reliably reproduce the hangs. They seem to occur more frequently
when using e.g. USB, audio (an ES1938 under ALSA) or the parallel port,
but sometimes I come back to the machine having left it idle (in X) and
find it hung. There is no message or oops, the SysRq combinations don't
appear to work, the machine is dead to ping and even keyboard LEDs don't
do anything.

Hardware is:
Soltek SL-75DRV5 motherboard (Via Apollo KT333 [though lspci says KT266])
AMD Duron 1200

bjb@muttley [21] lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:08.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
00:0a.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 40)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF

I've searched and not found anything in the archives so I'm guessing it
might be bad hardware or a bad combination of hardware. This is a box I
built to replace another machine which was also suffering frequent hangs
so I'm loath to try replacing hardware at random again.

Please CC me in replies.

-- 
+-----Ben Bell - "A song, a perl script and the occasional silly sig.-----+
  ///      email: bjb@deus.net            www: http://www.deus.net/~bjb/
  bjb    Don't try to drive me crazy... 
  \_/                                        ...I'm close enough to walk. 
