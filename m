Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRJCJaJ>; Wed, 3 Oct 2001 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRJCJaA>; Wed, 3 Oct 2001 05:30:00 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:22791 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S271906AbRJCJ3p> convert rfc822-to-8bit;
	Wed, 3 Oct 2001 05:29:45 -0400
Date: Wed, 3 Oct 2001 12:30:06 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: <linux-kernel@vger.kernel.org>
Subject: usb ov511 problem (kernel crash)
Message-ID: <Pine.LNX.4.33.0110031227510.4235-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I have an HP Omnibook 6000 laptop. When I plug in the D-LINK DRU-100C
(Ver. B2) usb-camera, and load the ov511 driver, the camera is detected
just fine. But, when I try to use the /dev/video0, the whole kernel
crashes! The same happens when I do "cat /dev/video0". There's nothing in
the syslog. Sysrq wont work.

I'm using Linux 2.4.10 and driver that comes with the kernel. I've also
tried the 1.42 ov511 driver from linux-usb.org. I use Debian GNU/Linux
(sid).

Any ideas?


usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 14:27:13 Oct  2 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 10 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1880, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver



Linux video capture interface: v1.00
usb.c: registered new driver ov511
ov511.c: OV511 USB Camera Driver v1.42
hub.c: USB new device connect on bus1/1, assigned device number 2
ov511.c: USB OV511+ camera found
ov511.c: camera: Generic OV511 Camera (no ID)
ov511.c: i2c write retries exhausted
ov511.c: i2c write: error -1
ov511.c: Sensor is an OV6620


Thanks for your help.


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


