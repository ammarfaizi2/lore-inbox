Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbSLRWBC>; Wed, 18 Dec 2002 17:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbSLRWBA>; Wed, 18 Dec 2002 17:01:00 -0500
Received: from d4039.upc-d.chello.nl ([213.46.4.39]:28809 "EHLO
	nbkurt.garloff.de") by vger.kernel.org with ESMTP
	id <S267397AbSLRV7e>; Wed, 18 Dec 2002 16:59:34 -0500
Date: Wed, 18 Dec 2002 23:07:34 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with OnStream USB30 Tape drive on the USB ports on a FIC VA-503+ - VIA MVP3 Chipset
Message-ID: <20021218220734.GE5983@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DFC50E9.656B96D0@cinet.co.jp> <3DFC7C17.906E3211@cinet.co.jp> <OE36ErsoLZdagtbggcc0000e004@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <OE36ErsoLZdagtbggcc0000e004@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

to me this looks like a general USB or a specific usb-storage (FreeCom)
problem. Please send details of your USB setup (lsusb) to the usb-storage
developers. See=20
http://www2.one-eyed-alien.net/~mdharm/linux-usb/

On Sun, Dec 15, 2002 at 08:32:19AM -0500, Linux Kernel Developer wrote:
[...]
> CPU: AMD-K6(tm) 3D processor stepping 0c
[...]
> ACPI: Core Subsystem version [20011018]
> ACPI: Subsystem enabled
[...]
> VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
[...]
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 17:41:15 Dec 11 2002
> usb-uhci.c: High bandwidth mode enabled
> PCI: Assigned IRQ 11 for device 00:07.2
> usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> hub.c: new USB device 00:07.2-2, assigned address 2
> usb.c: USB device 2 (vend/prod 0x7ab/0xfc01) is not claimed by any active
> driver.
> SCSI subsystem driver Revision: 1.00
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: OnStream  Model: USB30             Rev: 1.09
>   Type:   Sequential-Access                  ANSI SCSI revision: 02
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
> USB Mass Storage support registered.
> osst :I: Tape driver with OnStream support version 0.9.10
> osst :I: $Id: osst.c,v 1.65 2001/11/11 20:38:56 riede Exp $
> osst :I: Attached OnStream USB30 tape at scsi0, channel 0, id 0, lun 0 as
> osst0
> usb-uhci.c: interrupt, status 30, frame# 1939
> usb-uhci.c: Host controller halted, trying to restart.
> usb-uhci.c: interrupt, status 2, frame# 1927
> freecom reset called
> hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
> usb.c: USB disconnect on device 00:07.2-2 address 2
> osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
> osst0:I: This warning may be caused by your scsi controller,
> osst0:I: it has been reported with some Buslogic cards.
> osst0:W: Command with sense data: Info fld=3D0xa00 (nonstd), Current
> osst:ce:00: sns =3D 70  2
> Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
> osst0:W: Command with sense data: Info fld=3D0xa00 (nonstd), Current
> osst:ce:00: sns =3D 70  2
> Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
[...]

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                        SuSE Labs
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+APGlxmLh6hyYd04RAsmoAKDGH0bD1b63gsjuCvgRU+9R9/rcVgCgioIG
TUzDf++XQ/dOjglhcGmvVZk=
=9ZIo
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
