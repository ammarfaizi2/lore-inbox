Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTGaTvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274860AbTGaTvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:51:12 -0400
Received: from HDOfa-02p5-177.ppp11.odn.ad.jp ([61.196.11.177]:15525 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S269036AbTGaTvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:51:09 -0400
Date: Fri, 01 Aug 2003 04:50:07 +0900 (JST)
Message-Id: <20030801.045007.74743017.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [usb] Can't detect connected device w/ VT6206
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.0.56 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using VIA KT400+ as mainboard,it includes VIA VT6206 as USB 2.0 I/F.
When using kernel (2.4/2.6), this chip is probed as uhci or ehci,
but connected device (i.e. gamepad,serial adapter) is not detected as
right device.

-------
whatisthis@merchior:~$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198
00:09.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0a.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:14.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)
whatisthis@merchior:~$ lsusb
Bus 001 Device 001: ID 0000:0000  
------------
 I'm using usbmgr or hotplug,results is same.
 What's wrong ? :-(

Regards,
Ohta
