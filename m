Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSL3Saa>; Mon, 30 Dec 2002 13:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbSL3Saa>; Mon, 30 Dec 2002 13:30:30 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:5826 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267057AbSL3Sa2>; Mon, 30 Dec 2002 13:30:28 -0500
Date: Mon, 30 Dec 2002 13:35:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PDA USB hotplug activates eth1 instead of usb0 in 2.4.21-pre2
Message-ID: <Pine.LNX.4.44.0212301331440.27562-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  again, with 2.4.21-pre2, i plugged in my sharp zaurus 5500 into
a USB port and, while /var/log/messages and /proc/bus/usb/devices
both recognized it right away (yippee!), the interface that was
associated with this was not usb0 (as i expected), but eth1
instead:

Dec 30 13:31:07 dell kernel: hub.c: new USB device 00:1f.2-1, assigned address 5
Dec 30 13:31:07 dell kernel: CDCEther.c: eth1: Sharp SL Series 
Dec 30 13:31:07 dell /etc/hotplug/net.agent: invoke ifup eth1
Dec 30 13:31:10 dell /etc/hotplug/usb.agent: Setup acm CDCEther usbnet for USB product 4dd/8004/0


  should i have expected this?

rday

