Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbTCUPEi>; Fri, 21 Mar 2003 10:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263635AbTCUPEi>; Fri, 21 Mar 2003 10:04:38 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.25]:35153 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263633AbTCUPEh>; Fri, 21 Mar 2003 10:04:37 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5 AGP no good (VIA KT333, radeon 7500)
Date: Fri, 21 Mar 2003 16:15:28 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303211615.28675.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest Linus 2.5 BK:

In system logs:

kernel: Linux agpgart interface v0.100 (c) Dave Jones
kernel: agpgart: Detected VIA Apollo Pro KT266/KT333 chipset
kernel: agpgart: Maximum main memory to use for agp memory: 439M
kernel: agpgart: AGP aperture is 128M @ 0xe0000000
...
(X-windows starts)
kernel: agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
kernel: agpgart: Putting AGP V2 device at 01:00.0 into 1x mode

X-windows starts, but the picture is horribly torn, only the grey stipple
pattern is recognizable.  Any thoughts?  Or should I start a binary
search for the last version that worked?

Thanks, Duncan.

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:07.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:0a.0 USB Controller: VIA Technologies, Inc. USB (rev 04)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
