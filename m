Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLZL1i>; Thu, 26 Dec 2002 06:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLZL1h>; Thu, 26 Dec 2002 06:27:37 -0500
Received: from smtp006.mail.tpe.yahoo.com ([202.1.238.137]:48877 "HELO
	smtp006.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S261286AbSLZL1h>; Thu, 26 Dec 2002 06:27:37 -0500
Message-ID: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Date: Thu, 26 Dec 2002 19:35:43 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've tested ASUS USB2.0 CD-RW 40x/12x/48x under 2.5.53.
  The CD-RW device cannot be mounted.  but it shows in
/proc/scsi/usb-storage-0/0.
  Run "cat /proc/scsi/usb-storage-0/0", I got
***
  Host scsi0: usb-storage
  Vendor: ASUSTek ODD
  Product: USB Storage Device
  Serial Number: 7438401210600019
  Protocol: Transparent SCSI
  Transport: Bulk
  GUID: 282150017438401210600019
  Attached: Yes
***
  Run "dmesg", I got
****
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2002-Nov-29
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
hub 1-0:0: debounce: port 5: delay 100ms stable 4 status 0x501
hub 1-0:0: new USB device on port 5, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
input: PS/2 Logitech Mouse on isa0060/serio1
input: PS/2 Logitech Mouse on isa0060/serio1
****
Any idea? Thank in advance.

Best Regards,
             Joseph(@@)

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
