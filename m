Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262950AbSJBDXP>; Tue, 1 Oct 2002 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262951AbSJBDXP>; Tue, 1 Oct 2002 23:23:15 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:40886 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S262950AbSJBDXN>; Tue, 1 Oct 2002 23:23:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: ATI/RIVA framebuffer, 2.4.20-pre8 freeze
Date: Tue, 1 Oct 2002 23:29:41 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210012329.41638.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two graphics cards listed below (2.4.20-pre5 /proc/pci).
With both framebuffers enabled...

CONFIG_FB_RIVA
CONFIG_FB_ATY
CONFIG_FB_ATY_CT

...the kernel freezes after printing the ATY messages.

With FB_RIVA enabled, and ATY disabled, the framebuffer works.

I've experienced the same problem on earlier 2.4 kernels.
=======================================

  Bus  0, device  10, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 
92).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0000fff].

  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti200] (rev 
163                                                               ).
      IRQ 5.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd4000000 [0xd7ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xd807ffff].

