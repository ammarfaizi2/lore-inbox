Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSDYTko>; Thu, 25 Apr 2002 15:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSDYTko>; Thu, 25 Apr 2002 15:40:44 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:54739 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S313113AbSDYTkn>; Thu, 25 Apr 2002 15:40:43 -0400
Date: Thu, 25 Apr 2002 21:40:42 +0200 (CEST)
From: Michael De Nil <linux@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: USB Mass Storage -> Asus Stick
Message-ID: <Pine.LNX.4.44.0204252135440.16629-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyz

I have an Asus USB Mass Storage Stick here, but when connecting it to my
laptop running GNU/Linux 2.4.17, my system freezes... (It takes a couple
of seconds between connection & freez)

I don't get any oops or something like that, ...

I can find in the syslog:

Apr 25 21:28:51 tina kernel: hub.c: USB new device connect on bus1/2,
assigned device number 3
Apr 25 21:28:51 tina kernel: usb-storage: act_altsettting is 0
Apr 25 21:28:51 tina kernel: usb-storage: id_index calculated to be: 81
Apr 25 21:28:51 tina kernel: usb-storage: Array length appears to be: 83
Apr 25 21:28:51 tina kernel: usb-storage: USB Mass Storage device detected
Apr 25 21:28:51 tina kernel: usb-storage: Endpoints: In: 0xca1ad820 Out:
0xca1ad834 Int: 0xca1ad848 (Period 1)
Apr 25 21:28:51 tina kernel: usb-storage: New GUID
0d7d01000000171a0b0d01a7
Apr 25 21:28:51 tina kernel: usb-storage: GetMaxLUN command result is 1,
data is 0
Apr 25 21:28:51 tina kernel: usb-storage: Transport: Bulk
Apr 25 21:28:51 tina kernel: usb-storage: Protocol: Transparent SCSI
Apr 25 21:28:51 tina kernel: usb-storage: *** thread sleeping.
Apr 25 21:28:51 tina kernel: scsi1 : SCSI emulation for USB Mass Storage
devices
Apr 25 21:28:51 tina kernel: usb-storage: queuecommand() called
Apr 25 21:28:51 tina kernel: usb-storage: *** thread awakened.
Apr 25 21:28:51 tina kernel: usb-storage: Command INQUIRY (6 bytes)
Apr 25 21:28:51 tina kernel: usb-storage: 12 00 00 00 ff 00 00 00 95 c6 1e
c0
Apr 25 21:28:51 tina kernel: usb-storage: Bulk command S 0x43425355 T 0x3
Trg 0 LUN 0 L 255 F 128 CL 6
Apr 25 21:28:51 tina kernel: usb-storage: Bulk command transfer result=0
Apr 25 21:28:51 tina kernel: usb-storage: usb_stor_transfer_partial():
xfer 255 bytes
Apr 25 21:28:51 tina kernel: usb-storage: usb_stor_bulk_msg() returned 0
xferred 36/255
Apr 25 21:28:51 tina kernel: usb-storage: Bulk data transfer result 0x1
Apr 25 21:28:51 tina kernel: usb-storage: Attempting to get CSW...


grtz
	michael

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
       Linux LiSa 2.4.18 #4 SMP ma apr 1 11:11:48 CEST 2002 i686
  21:35:01 up 2 days,  1:58,  7 users,  load average: 0.35, 0.13, 0.06
-----------------------------------------------------------------------

