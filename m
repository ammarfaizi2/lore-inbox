Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265602AbUFCPLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUFCPLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUFCPLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:11:00 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:47608 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264355AbUFCPJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:09:11 -0400
Message-ID: <40BF3F14.4080601@comcast.net>
Date: Thu, 03 Jun 2004 11:09:08 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Host Bridge mislabeled in lspci
Content-Type: multipart/mixed;
 boundary="------------040401040102010707090901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401040102010707090901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

While tracking a bug in 2.4.27-pre3, I noticed that my lspci showed my 
host bridge as "SiS 645xx" instead of "SiS 648" as it should. Could this 
have any negative impacts on stability?
Attached is my lspci output for 2.4.27-pre3.

Thanks,
David

--------------040401040102010707090901
Content-Type: text/plain;
 name="lspci-2.4.27-pre3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.4.27-pre3"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media IO] (rev 04)
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 91)
00:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
00:0e.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

--------------040401040102010707090901--

