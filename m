Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUC3NYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUC3NYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:24:32 -0500
Received: from vse.vse.cz ([146.102.16.2]:18340 "EHLO vse.vse.cz")
	by vger.kernel.org with ESMTP id S263645AbUC3NY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:24:29 -0500
From: Zdenek Tlusty <tlusty@vse.cz>
To: linux-kernel@vger.kernel.org
Subject: via 6420 pata/sata controller
Date: Tue, 30 Mar 2004 15:24:25 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301524.26360.tlusty@vse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have problem with via 6420 controller under linux (I have mandrake 9.1 with 
kernel 2.4.25 with libata patch version 16).
This controller has two sata and one pata channels. Sata channel works fine 
with libata. My problem is with pata channel. I have pata hard disk on this 
controller. Bios of the controller detected this disk but linux did not.
What is the current status of the driver for this controller?
Thank you for your time.

        Zdenek Tlusty

cat /proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
c800-c8ff : PCI device 1106:3149 (VIA Technologies, Inc.)
  c800-c8ff : sata_via
cc00-cc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  cc00-cc7f : 01:0b.0
cf60-cf6f : PCI device 1106:3149 (VIA Technologies, Inc.)
  cf60-cf6f : sata_via
cf80-cf87 : PCI device 1106:3149 (VIA Technologies, Inc.)
  cf80-cf87 : sata_via
cf88-cf8b : PCI device 1106:3149 (VIA Technologies, Inc.)
  cf88-cf8b : sata_via
cf8c-cf8f : PCI device 1106:3149 (VIA Technologies, Inc.)
  cf8c-cf8f : sata_via
cf90-cf9f : PCI device 1106:4149 (VIA Technologies, Inc.)
cfa0-cfa7 : PCI device 1106:3149 (VIA Technologies, Inc.)
  cfa0-cfa7 : sata_via
cfa8-cfaf : PCI device 1106:4149 (VIA Technologies, Inc.)
cfe0-cfe3 : PCI device 1106:4149 (VIA Technologies, Inc.)
cfe4-cfe7 : PCI device 1106:4149 (VIA Technologies, Inc.)
cff0-cff7 : PCI device 1106:4149 (VIA Technologies, Inc.)
d000-dfff : PCI Bus #02
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corp. 82801BA/BAM SMBus
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

