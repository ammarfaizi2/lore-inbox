Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSE2Ufy>; Wed, 29 May 2002 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSE2Ufx>; Wed, 29 May 2002 16:35:53 -0400
Received: from dhcp024-210-218-255.woh.rr.com ([24.210.218.255]:19328 "HELO
	hoho.shacknet.nu") by vger.kernel.org with SMTP id <S315463AbSE2Ufw>;
	Wed, 29 May 2002 16:35:52 -0400
Subject: Re: Sony DSC-P71 Camera
From: Colin Slater <hoho@binbash.net>
To: sean darcy <seandarcy@hotmail.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF42C81.5030004@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-bEEVNq0bRkabpq2Sz52E"
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 May 2002 16:34:54 -0400
Message-Id: <1022704494.879.12.camel@neptune>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bEEVNq0bRkabpq2Sz52E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-05-28 at 21:18, sean darcy wrote:
> You don't say which kernel you're using. I have a p71 which I can't get=20
> to work with 2.5.18 - see the mass storage thread. OTOH, a stock rh=20
> 2.4.18 kernel works just fine.
>=20
> What does usbview show? What are the usb and scsi snips from .config.=20
> What hapens when you try to mount sd*  ?

Yes, I forgoht to mention that im running 2.4.18.=20
Here is a lsmod of all the relevent stuff I have loaded
root@neptune:~# lsmod
Module                  Size  Used by    Tainted: P
usb-storage            20820   0  (unused)
sr_mod                 11792   0  (autoclean) (unused)
scsi_mod               80648   1  (autoclean) [usb-storage sr_mod]

usbview doesnt show mutch more than /proc/bus/usb/devices. The cammera
does show up in red in the left pane though. And I dont have any
/dev/sd* devices. Are you useing the camera in "Normal" usb mode?
somewhere in the setup they have an alternate mode, but dont know what
the difference is.

Here's the usb & scsi sections from my .config:

# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_UHCI_ALT=3Dy
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=3Dy
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

# SCSI support
#
CONFIG_SCSI=3Dm
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set



--=20
-----
GPG Key 0x7E959232; wwwkeys.pgp.net
861C AE70 158F C440  EEE1 397C 7CBD 1148 7E95 9232=20

--=-bEEVNq0bRkabpq2Sz52E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA89TtufL0RSH6VkjIRApN4AJ9HUtkphGrUbHaQF6uNTlauD4Pd+ACfWxAC
rMFhDxTCBSBMiRid15R8e6k=
=J/9l
-----END PGP SIGNATURE-----

--=-bEEVNq0bRkabpq2Sz52E--
