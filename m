Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUAFSdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUAFSbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:31:42 -0500
Received: from [212.28.208.94] ([212.28.208.94]:38159 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265080AbUAFSax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:30:53 -0500
From: Robin Rosenberg <roro.l@dewire.com>
To: linux-kernel@vger.kernel.org
Subject: USB timeout  Canon Powsrshot S30
Date: Tue, 6 Jan 2004 19:27:00 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401061927.00833.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problem with retrieving av big avi from my camera. I get a timeout. The avi is just above 10MB which
is about as large as it can be. Retrieving the thumbinail works fine. This is what comes in the log with USB_DEBUG set.

The camera uses PTP for picture transfer, not USB Mass Storage. I have not had any problems with this camera before,
but I have not had larger files that ~5MB either. The same problem occurs with any kernel (2.4 mandrake, 2.6 vanilla 
or 2.6 mandrake). 

Can I change the timeout somehow? There are lots of modules and I'm not sure which one is responsible for what. 

Jan  6 12:28:28 h6n2fls33o811 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jan  6 12:28:28 h6n2fls33o811 kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Jan  6 12:28:28 h6n2fls33o811 kernel: uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Jan  6 12:28:28 h6n2fls33o811 kernel: hub 1-0:1.0: USB hub found
Jan  6 12:28:02 h6n2fls33o811 usb: Initierar USB-kontroller (usb-uhci):  succeeded 
Jan  6 12:28:03 h6n2fls33o811 usb: Monterar USB-filsystem succeeded 
Jan  6 12:33:45 h6n2fls33o811 kernel: hub 1-0:1.0: new USB device on port 2, assigned address 2
Jan  6 12:33:57 h6n2fls33o811 kernel: usb 1-2: bulk timeout on ep3in

(The occasional swedish i18in is I believe close enough to the english original to be understood, but I don't like editing logs).

-- robin



