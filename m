Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRDXBtg>; Mon, 23 Apr 2001 21:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDXBt0>; Mon, 23 Apr 2001 21:49:26 -0400
Received: from www.mammoth.org ([204.26.91.1]:23300 "EHLO www.mammoth.org")
	by vger.kernel.org with ESMTP id <S132668AbRDXBtN>;
	Mon, 23 Apr 2001 21:49:13 -0400
Date: Mon, 23 Apr 2001 20:49:11 -0500 (CDT)
From: josh <skulcap@mammoth.org>
To: linux-kernel@vger.kernel.org
Subject: USB problems since 2.4.2
Message-ID: <Pine.LNX.4.20.0104232027400.12476-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel: 2.4.2 - latest (2.4.3-ac12)
Platform: x86 on mangled Slack7.1
Hardware: MSI 694D Pro-AR
( http://www.msicomputer.com/products/detail.asp?ProductID=150 )

Problem: USB devices timeout on address assignment. Course thats with the
non JE driver, with the JE driver the bus doesnt even say that anything
gets connected.

messages when driver loads:
*************************************
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 00:58:23 Apr 23 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 19
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usblp
usb.c: registered new driver dc2xx
*************************************
  
when any device is plugged in:
*************************************
hub.c: USB new device connect on bus1/1, assigned device number 4
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 5
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=5 (error=-110)
*************************************



                          www.mammoth.org/~skulcap
**********************************************BEGIN GEEK CODE BLOCK************
"Sometimes, if you're perfectly      * GCS d- s: a-- C++ ULSC++++$ P+ L+++ E--- 
still, you can hear the virgin       * W+(++) N++ o+ K- w--(---) O- M- V- PS-- 
weeping for the savior of your will."* PE Y+ PGP t+ 5 X+ R !tv b+>+++ DI++ D++  
 --DreamTheater, "Lines in the Sand" * G e h+ r-- y-   (www.geekcode.com)
**********************************************END GEEK CODE BLOCK**************

