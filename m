Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVFPNzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFPNzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFPNzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 09:55:06 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:58198 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261549AbVFPNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 09:55:01 -0400
Message-ID: <42B184AB.7050108@yahoo.com.au>
Date: Thu, 16 Jun 2005 23:54:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB mouse problems in (2.6.12-rc6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both 2.6.12-rc6 and rc6-mm1 make the mouse move around very strangely.
Very noticable lag and infrequent updates of the position.

System is a dual PIII. Some more info below. Anyone got any ideas or
patches to try? Thanks.

            CPU0       CPU1
   0:     356256     420442    IO-APIC-edge  timer
   1:        715       1563    IO-APIC-edge  i8042
   9:          0          0   IO-APIC-level  acpi
  14:       4555       2951    IO-APIC-edge  ide0
  15:         54          6    IO-APIC-edge  ide1
  17:        996        436   IO-APIC-level  SysKonnect SK-98xx
  18:        584       1071   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
0000:00:0a.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
0000:00:0b.0 Ethernet controller: D-Link System Inc Gigabit Ethernet Adapter (rev 11)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15)

Send instant messages to your online friends http://au.messenger.yahoo.com 
