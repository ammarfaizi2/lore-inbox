Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWFRUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFRUyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFRUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 16:54:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:28470 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWFRUyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 16:54:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dN8xSebsMYr55Zn6vqa9MaF9qZUdzKnhzwpAu2Za1k/5L5pUAk4kNjjE1gQw32R8S1GnX8OV4UyDYBe6YEh5oBaipIYEE+2ht1mrXIoWP9X2PdjrHaI0lTmKTynaW0yMkA2TsHSzbdcQ1rP5+w/vPIVv7XBH5+IRb5Y0cDeKWKA=
Message-ID: <32124b660606181354w1c57f733l211af48cd37f988e@mail.gmail.com>
Date: Sun, 18 Jun 2006 22:54:36 +0200
From: "Ojciec Rydzyk" <69rydzyk69@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Several errors in kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I have compiled new kernel to my laptop and I found several errors.
Please help me to solve them:
*****
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI: PCI Root Bridge [PCI0] (0000:00)
*****

and also:

*****
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Failed to allocate mem resource #6:10000@f4000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
******

and my lspci:

*****
00:00.0 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:06.0 Network controller: RaLink Ralink RT2500 802.11G
Cardbus/mini-PCI (rev 01)
00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem
Controller (rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome
Pro VGA Adapter (rev 02)
*****

Please help.
Greetings,
Jacek Jablonski
