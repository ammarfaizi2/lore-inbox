Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289128AbSAGFoX>; Mon, 7 Jan 2002 00:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289129AbSAGFoD>; Mon, 7 Jan 2002 00:44:03 -0500
Received: from oflmta01bw.bigpond.com ([139.134.6.21]:38625 "EHLO
	oflmta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S289128AbSAGFoC>; Mon, 7 Jan 2002 00:44:02 -0500
Message-Id: <5.1.0.14.0.20020107163253.00b48790@mail.bigpond.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 16:43:47 +1100
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
From: Dylan Egan <crack_me@bigpond.com.au>
Subject: Re: 2.4.17 - hanging due to usb
In-Reply-To: <20020107025057.GA4110@kroah.com>
In-Reply-To: <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com>
 <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com>
 <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com>
 <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Can you not load the usb-storage driver, load the usbcore module, and
>the USB host driver that you are using, and point hotplug to somewhere
>else:
>         echo /bin/true > /proc/sys/kernel/hotplug
>
>Then plug in your device, and send the output of /proc/bus/usb/devices
>to the list (and the linux-usb-devel list, which is a better place for
>this :)

I only got this extra bit of infomation from the way you said for me to do it.
When i loaded usbcore this time it said cant get major 180 for usb....
Ok i loaded it as you said it all went find but it never gave me anything 
when i went to do "cat /proc/bus/usb/devices".
Also this is the most information i can get when it is initialzing the usb 
device(insmod usb-storage):

Using /lib/modules/2.4.17/kernel/drivers/usb/storage/usb-storage.o
usb.c: registered new driver usb-storage
scsi0: SCSI Emulation for USB Mass Storage devices
usb-uhci.c: ENXIO 800000200, flags 0,urb ccaeb440, burb ccaeb4c0
usb-uhci.c: interrupt, status 3, frame #1758
usb.c USB disconnect on device 2
hub.c USB new device connect on bus3/2, assigned device number 3
Manufactuar: ScanLogic USBIDE
Product: ScanLogic USBIDE
usb-storage:host_reset() requested but not implemented
scsi: device set offline - command error recover failed; host0 channel 0 id 
0 lun 0

i had to write this out i hope its perfect to what it said

Regards,

Dylan 

