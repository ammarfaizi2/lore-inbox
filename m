Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313493AbSDEU3F>; Fri, 5 Apr 2002 15:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313494AbSDEU2z>; Fri, 5 Apr 2002 15:28:55 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:53648 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S313493AbSDEU2n>; Fri, 5 Apr 2002 15:28:43 -0500
Message-Id: <5.1.0.14.2.20020405112232.0a863da0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Apr 2002 12:27:51 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] Bluetooth subsystem sync up
Cc: alan@lxorguk.ukuu.org.uk, davem@redhat.com, torvalds@transmeta.com,
        Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

It's time to sync up our Bluetooth subsystem.
This patch updates:
         Documentation/Configure.help
         include/net/bluetooth
         net/bluetooth
         drivers/bluetooth
and removes EXPERIMENTAL status of the Bluetooth support.

Patch against 2.4.19-pre6 is available at
         http://bluez.sf.net/patches/bluez-2.0-patch-2.4.19-pre6.gz

Please apply.

ChangeLog:
         BlueZ Core:
                 New generic HCI connection manager.
                 Complete role switch and link policy support.
                 Security mode 1 and 3 support.
                 L2CAP service level security support.
                 HCI filter support.
                 HCI frame time-stamps.
                 SCO (voice links) support.
                 Improved HCI device unregistration (device destructors).
                 Support for L2CAP signalling frame fragmentation.
                 Improved L2CAP timeout handling.
                 New HCI ioctls for changing ACL and SCO MTU.
                 Killed HCI_MAX_DEV limit.
                 Security fixes.

         New HCI USB driver:
                 Performance improvements.
                 Firmware loading support.
                 Stability fixes. URB and disconnect handling rewrite.

         New HCI UART driver:
                 Support for multiple UART protocols.

         New HCI PCMCIA driver:
                 DTL1 driver for Nokia Bluetooth PC Cards.

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

