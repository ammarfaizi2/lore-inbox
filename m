Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTAJGvk>; Fri, 10 Jan 2003 01:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbTAJGvk>; Fri, 10 Jan 2003 01:51:40 -0500
Received: from adsl-64-175-242-153.dsl.sntc01.pacbell.net ([64.175.242.153]:37202
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S263291AbTAJGvj>; Fri, 10 Jan 2003 01:51:39 -0500
From: brian@worldcontrol.com
Date: Thu, 9 Jan 2003 23:00:02 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 USB Yes, 2.4.20 USB No
Message-ID: <20030110070002.GA2113@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone know why USB support for my FXA32 disappeared between Linux kernel
2.4.19 to 2.4.20?

When I boot with 2.4.19 I get:

Jan  9 22:35:25 top kernel: usb-uhci.c: $Revision: 1.275 $ time 12:19:03 Nov 23 2002
Jan  9 22:35:25 top kernel: usb-uhci.c: High bandwidth mode enabled
Jan  9 22:35:25 top kernel: PCI: Setting latency timer of device 00:07.2 to 64
Jan  9 22:35:25 top kernel: usb-uhci.c: USB UHCI at I/O 0x1c00, IRQ 9
Jan  9 22:35:25 top kernel: usb-uhci.c: Detected 2 ports
Jan  9 22:35:25 top kernel: usb.c: new USB bus registered, assigned bus number 1
Jan  9 22:35:25 top kernel: hub.c: USB hub found
Jan  9 22:35:25 top kernel: hub.c: 2 ports detected
Jan  9 22:35:25 top kernel: PCI: Setting latency timer of device 00:07.3 to 64
Jan  9 22:35:25 top kernel: usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
Jan  9 22:35:25 top kernel: usb-uhci.c: Detected 2 ports
Jan  9 22:35:25 top kernel: usb.c: new USB bus registered, assigned bus number 2
Jan  9 22:35:25 top kernel: hub.c: USB hub found
Jan  9 22:35:25 top kernel: hub.c: 2 ports detected
Jan  9 22:35:25 top kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Jan  9 22:35:26 top kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Jan  9 22:35:26 top kernel: dc2xx.c: USB Camera #0 connected, major/minor 180/80
Jan  9 22:35:29 top /etc/hotplug/usb.agent: ... no modules for USB product 0/0/0
Jan  9 22:35:29 top /etc/hotplug/usb.agent: ... no modules for USB product 0/0/0
Jan  9 22:35:29 top /etc/hotplug/usb.agent: Setup dc2xx for USB product 40a/111/100  
Jan  9 22:35:29 top /etc/hotplug/usb.agent: Setup usbcam for USB product 40a/111/100 
Jan  9 22:35:29 top /etc/hotplug/usb.agent: Module setup usbcam for USB product 


When I boot with 2.4.20 I get:

Jan  9 22:54:00 top kernel: usb-uhci.c: $Revision: 1.275 $ time 23:08:09 Dec 23 2002
Jan  9 22:54:00 top kernel: usb-uhci.c: High bandwidth mode enabled
Jan  9 22:54:00 top kernel: usb-uhci.c: USB UHCI at I/O 0x1c00, IRQ 9
Jan  9 22:54:00 top kernel: usb-uhci.c: Detected 2 ports
Jan  9 22:54:01 top kernel: usb.c: new USB bus registered, assigned bus number 1
Jan  9 22:54:01 top kernel: hub.c: USB hub found
Jan  9 22:54:01 top kernel: hub.c: 2 ports detected
Jan  9 22:54:01 top kernel: usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
Jan  9 22:54:01 top kernel: usb-uhci.c: Detected 2 ports
Jan  9 22:54:01 top kernel: usb.c: new USB bus registered, assigned bus number 2
Jan  9 22:54:01 top kernel: hub.c: USB hub found
Jan  9 22:54:01 top kernel: hub.c: 2 ports detected
Jan  9 22:54:01 top kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Jan  9 22:54:04 top /etc/hotplug/usb.agent: ... no modules for USB product 0/0/0
Jan  9 22:54:04 top /etc/hotplug/usb.agent: ... no modules for USB product 0/0/0

It is completely repeatable.

-- 
Brian Litzinger
