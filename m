Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWDDOTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWDDOTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWDDOTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:19:53 -0400
Received: from outmx027.isp.belgacom.be ([195.238.4.208]:56784 "EHLO
	outmx027.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932205AbWDDOTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:19:52 -0400
From: Jan De Luyck <ml_linuxkernel_20060301@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.16.1] Mouse oddities
Date: Tue, 4 Apr 2006 16:19:43 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/BoMEU3UaSn1aAe"
Message-Id: <200604041619.43826.ml_linuxkernel_20060301@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/BoMEU3UaSn1aAe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,

I've got some weird mouse problems. I've been seeing them since about 2.6.14 
(or 2.6.15, not sure) where my mouse keeps jumping to the lower left corner 
from time to time. I can say it happens about 20-30 times in a day. 

dmesg shows nothing out of the ordinary, the mouse just jumps.

I'm running X.Org  6.9

X Window System Version 6.9.0 (Debian 6.9.0.dfsg.1-5 20060320141153 David 
Nusinow <dnusinow@debian.org>)

Kernel in use is 2.6.16.1 at the moment.

Mouse in question (but this happens with other mice too) is a Dell Optical USB 
mouse:

Bus 003 Device 004: ID 413c:3010 Dell Computer Corp. Optical Wheel Mouse
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x413c Dell Computer Corp.
  idProduct          0x3010 Optical Wheel Mouse
  bcdDevice            2.30
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      52
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              10

Anything I can try to find the root of this problem?

Kernel .config in attachment.

Jan



-- 
If two people love each other, there can be no happy end to it.
		-- Ernest Hemingway

--Boundary-00=_/BoMEU3UaSn1aAe
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
I30miYDFDK/9/x/si+IHq6MAAA==

--Boundary-00=_/BoMEU3UaSn1aAe--
