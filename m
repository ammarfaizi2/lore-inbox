Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRADUdL>; Thu, 4 Jan 2001 15:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135273AbRADUdB>; Thu, 4 Jan 2001 15:33:01 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:18306 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S132986AbRADUcl>; Thu, 4 Jan 2001 15:32:41 -0500
Date: Thu, 4 Jan 2001 15:32:36 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.18 bttv
Message-ID: <Pine.LNX.4.30.0101041524140.29919-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A follow-up to my previous report about 2.2.18 bttv's new (worse) behavior:
Replacing 2.2.18's bttv.c with 2.2.17's fixes the problems.

- The green and purple fuzzy flash on a screen capture or channel change is
  gone.
- The screen works after loading the module without TV->Composite->TV in
  XawTV. (Especially important with automatic module loading.)

Hauppauge WinTV 401
00:14.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppage computer works Inc.: Unknown device 13eb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at e4001000 (32-bit, prefetchable)

S3 Virge DX
00:11.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
        Subsystem: S3 Inc. ViRGE/DX
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at e0000000 (32-bit, non-prefetchable)

Tyan Tomcat IV -- Pentium 233 MMX x2
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
        Flags: bus master, medium devsel, latency 32

I can try to narrow it down further if someone has ideas or I'll just try
whatever I can in the large chunks changed.

-George Greer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
