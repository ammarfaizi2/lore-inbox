Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbTCYLaI>; Tue, 25 Mar 2003 06:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTCYLaI>; Tue, 25 Mar 2003 06:30:08 -0500
Received: from [62.75.130.10] ([62.75.130.10]:55314 "EHLO server1.opaia.de")
	by vger.kernel.org with ESMTP id <S262059AbTCYLaC> convert rfc822-to-8bit;
	Tue, 25 Mar 2003 06:30:02 -0500
Date: Tue, 25 Mar 2003 12:41:10 +0100
Message-Id: <200303251141.h2PBfA0n007798@server1.opaia.de>
From: imre@molnar.info
To: linux-kernel@vger.kernel.org
Cc: imre@molnar.info
Subject: unsupported bridge with intel E7205 chipset 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After booting with the latest stable kernel (2.4.20):
-----------------------dmesg---------------------------
.			 :
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: Unsupported Intel chipset (device id: 255d), you might want
to try agp_try_unsupported=1.
agpgart: no supported devices found.
........................:............................ 

I found a patch under:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.3/0584.html

After patched the kernel:
-------------------------dmesg------------------------
.			   :
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: unsupported bridge
agpgart: no supported devices found.
.........................:...........................

The motherboard is from Asus (P4G8X-Deluxe):
o  North bridge controller: E7205
o  South bridge controller: ICH4

How is this problem to solve?

With best regards
Imre Molnar
Heidbuehlstr. 33
D-88697 BERMATINGEN
Tel: +49(7544)73165
Email: imre@molnar.info
