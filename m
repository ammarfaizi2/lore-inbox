Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUB0KF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUB0KF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:05:26 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:58560 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261777AbUB0KFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:05:15 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: Known problems with megaraid under 2.4.25 highmem?
Date: Fri, 27 Feb 2004 11:07:42 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200402271107.42050.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have experienced an I/O lockup on my dual Xeon server with megaraid adapter 
when kernel was compiled with highmem and highmem i/o. It happened during 
compilation of mysql with no other load.

Then I recompiled the kernel wo/highmem and everything is stable.

As, this server is now in production on different location I cannot do much 
testing except giving detailed hw info.

00:00.0 Host bridge: Intel Corporation: Unknown device 254c (rev 01)
00:00.1 Class ff00: Intel Corporation: Unknown device 2541 (rev 01)
00:03.0 PCI bridge: Intel Corporation: Unknown device 2545 (rev 01)
00:03.1 Class ff00: Intel Corporation: Unknown device 2546 (rev 01)
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 02)
00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 02)
00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 42)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 2480 (rev 02)
00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02)
00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 04)
02:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04)
02:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 04)
02:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04)
03:04.0 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
03:04.1 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
04:02.0 RAID bus controller: Symbios Logic Inc. (formerly NCR): Unknown device 
1960 (rev 01)
04:05.0 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
04:05.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)


