Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbRFMUTl>; Wed, 13 Jun 2001 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRFMUTb>; Wed, 13 Jun 2001 16:19:31 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:24307 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263952AbRFMUT0>; Wed, 13 Jun 2001 16:19:26 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE32F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Maksim Krasnyanskiy'" <maxk@qualcomm.com>, esr@thyrsus.com,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: RE: Undocumented configuration symbols in 2.4.6pre2
Date: Wed, 13 Jun 2001 13:19:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you make these 5 instances of "Not unsure" be more
palatable and less confusing?

E.g., "Not sure" or "If not sure".
But not the double negative...

As is, it basically says:  "Sure ? say M."

~Randy

> -----Original Message-----
> From: Maksim Krasnyanskiy [mailto:maxk@qualcomm.com]
> 
> >CONFIG_BLUEZ
> >CONFIG_BLUEZ_HCIEMU
> >CONFIG_BLUEZ_HCIUART
> >CONFIG_BLUEZ_HCIUSB
> >CONFIG_BLUEZ_L2CAP
> 
> Here we go:
> 
> CONFIG_BLUEZ
...
> 
>    Say Y here to enable Linux Bluetooth support and to build HCI Core 
>    layer.
> 
...
> 
>    Not unsure ? say N.
> 
> CONFIG_BLUEZ_L2CAP
...
> 
>    Say Y here to compile L2CAP support into the kernel or say 
> M to compile it 
>    as module (l2cap.o).
> 
>    Not unsure ? say M.
> 
> CONFIG_BLUEZ_HCIUART
...
> 
>    Say Y here to compile support for Bluetooth UART devices 
> into the kernel 
>    or say M to compile it as module (hci_uart.o).
> 
>    Not unsure ? say M.
> 
> 
> CONFIG_BLUEZ_HCIUSB
...
> 
>    Say Y here to compile support for Bluetooth USB devices 
> into the kernel 
>    or say M to compile it as module (hci_usb.o).
> 
>    Not unsure ? say M.
> 
> CONFIG_BLUEZ_HCIEMU
...
> 
>    Not unsure ? say M.

