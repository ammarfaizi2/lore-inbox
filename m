Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSCSWH2>; Tue, 19 Mar 2002 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSCSWHT>; Tue, 19 Mar 2002 17:07:19 -0500
Received: from prosecco.gmx.net ([213.165.64.8]:47841 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293048AbSCSWHK>;
	Tue, 19 Mar 2002 17:07:10 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Felix Seeger <felix.seeger@gmx.de>
To: Greg KH <greg@kroah.com>
Subject: Re: System hanging at boot with ms natural pro keyboard in usb port (2.4.18)
Date: Tue, 19 Mar 2002 22:58:12 +0100
X-Mailer: KMail [version 1.4]
In-Reply-To: <200203192204.32846.felix.seeger@gmx.de> <20020319215001.GD463@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203192258.12676.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 19. März 2002 22:50 schrieb Greg KH:
> On Tue, Mar 19, 2002 at 10:04:28PM +0100, Felix Seeger wrote:
> > Hi
> > I tried to connect my MS Natural Pro keyboard and than I get this error.
> > The Logitech mouse works great ;)
> >
> > Is this solved in 2.4.19-pre3 ?
> >
> > The error:
> >
> > hub.c USB new device connect on bus 1/1, assinged device number 2
> > invalid operand: 0000
> > CPU:		0
> > EIP:		0010:[<d98730a0>] Not tainted
> > EELAGS:	0010046
> > ... write me if you need more ...
>
> Yes we need more, after you run the oops through ksymoops too.
Ok, I will do that tomorrow evening.

> And what USB host controller driver are you using, and is this a SMP
> kernel?
No SMP kernel.

have fun
Felix

- From .config:
#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Controllers
#
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_WACOM is not set
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8l7R0S0DOrvdnsewRAnPkAJ9+AM/fjghWz9LrPdYsw/t3YgloTwCffz+5
WFhpLE0jXpMYCO5i5eBUz/w=
=xsYN
-----END PGP SIGNATURE-----

