Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRAEEnD>; Thu, 4 Jan 2001 23:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRAEEmx>; Thu, 4 Jan 2001 23:42:53 -0500
Received: from [200.222.195.131] ([200.222.195.131]:3589 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129325AbRAEEmt>; Thu, 4 Jan 2001 23:42:49 -0500
Date: Fri, 5 Jan 2001 02:42:11 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig: where's USB Mass Storage?
Message-ID: <20010105024211.B225@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
X-Mailer: Mutt/1.3.12i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this just me? Configuring 2.4.0 with make menuconfig with
CONFIG_EXPERIMENTAL=y I get no prompt for USB Mass Storage,
but the .config is saved with # CONFIG_USB_STORAGE is not set

I have the following:

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set

I checked a lot of times, and there's no such option here.

< >   OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support
--- USB Device Class drivers
< >   USB Audio support
< >   USB Bluetooth support (EXPERIMENTAL)
< >   USB Modem (CDC ACM) support

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
