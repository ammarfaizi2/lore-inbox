Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314454AbSEBOIE>; Thu, 2 May 2002 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314456AbSEBOID>; Thu, 2 May 2002 10:08:03 -0400
Received: from [62.112.80.99] ([62.112.80.99]:7692 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S314454AbSEBOIB>;
	Thu, 2 May 2002 10:08:01 -0400
Date: Thu, 2 May 2002 16:07:53 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Cc: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: airo_cs on ARM 2.4.13 vs. 2.5.6
Message-ID: <Pine.LNX.4.33.0205021544480.2626-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Brief description of the problem: airo driver (Aironet 350 card) works
with 2.5.6 and doesn't work with 2.4.13 on a StrongARM (Trizeps) board.

Details: Loading the modules (airo.o and airo_cs.o) works fine, the
packets get transmitted, ping host&; tcpdump host host shows packets
transmitted and received, but ping reports all packets lost. Same if I
ping the board - tcpdump only sees packets received, none are transmitted.
In /var/log/messages the IO-address, reported by airo looks like a PC
(ix86) address - 0xf6000000-0xf600003f. With 2.5.6 everything works and
the address-range is 0xc2872000-0xc287203f. Any ideas?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

