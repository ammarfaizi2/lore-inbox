Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSGRHru>; Thu, 18 Jul 2002 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGRHru>; Thu, 18 Jul 2002 03:47:50 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:59597 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317349AbSGRHru>; Thu, 18 Jul 2002 03:47:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.26 hotplug failure
Date: Thu, 18 Jul 2002 09:50:42 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207180950.42312.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave 2.5.26 a whirl.  The first thing I noticed was
that the hotplug system didn't run the script for my usb
modem...

kernel: usb.c: USB disconnect on device 2
kernel: hub.c: new USB device 00:0b.0-2, assigned address 4
kernel: usb.c: USB device 4 (vend/prod 0x6b9/0x4061) is not claimed by any active driver.
/etc/hotplug/usb.agent: ... no modules for USB product 6b9/4061/0

however this works just fine with 2.4.19-rc1 and 2.5.24 (i.e. only difference
is the change in kernel)...

All the best,

Duncan.
