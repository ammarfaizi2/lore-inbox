Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272412AbTGaGwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272419AbTGaGwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:52:12 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:9856 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S272412AbTGaGwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:52:04 -0400
Date: Thu, 31 Jul 2003 14:52:00 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Kernel List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: USB problems encountered when offing Zaurus
Message-ID: <20030731065200.GA1226@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test2-mm2-kj1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I got this when I try to turn off Zaurus SL-5560.
Any idea what went wrong?

I am using 2.6.0-test2-mm2-kj1. I am trying to turn
off my Zaurus, and then turn it on again. When I turn
it off, I get the following messages. When I turn it
on, and try to do a samba mount, i get pretty unstable
connection.pretty unstable
connection.

Eugene

Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.0: remove, state 3
Jul 31 14:40:27 amaryllis kernel: usb usb1: USB disconnect, address 1
Jul 31 14:40:27 amaryllis kernel: Call Trace:
Jul 31 14:40:27 amaryllis kernel:  [__might_sleep+95/114] __might_sleep+0x5=
f/0x72
Jul 31 14:40:27 amaryllis kernel:  [hcd_endpoint_disable+388/1321] hcd_endp=
oint_disable+0x184/0x529
Jul 31 14:40:27 amaryllis kernel:  [hcd_endpoint_disable+0/1321] hcd_endpoi=
nt_disable+0x0/0x529
Jul 31 14:40:27 amaryllis kernel:  [nuke_urbs+128/135] nuke_urbs+0x80/0x87
Jul 31 14:40:27 amaryllis kernel:  [usb_disconnect+161/395] usb_disconnect+=
0xa1/0x18b
Jul 31 14:40:27 amaryllis kernel:  [usb_hcd_pci_remove+180/410] usb_hcd_pci=
_remove+0xb4/0x19a
Jul 31 14:40:27 amaryllis kernel:  [pci_device_remove+59/61] pci_device_rem=
ove+0x3b/0x3d
Jul 31 14:40:27 amaryllis kernel:  [device_release_driver+96/98] device_rel=
ease_driver+0x60/0x62
Jul 31 14:40:27 amaryllis kernel:  [driver_detach+34/49] driver_detach+0x22=
/0x31
Jul 31 14:40:27 amaryllis kernel:  [bus_remove_driver+87/143] bus_remove_dr=
iver+0x57/0x8f
Jul 31 14:40:27 amaryllis kernel:  [driver_unregister+26/68] driver_unregis=
ter+0x1a/0x44
Jul 31 14:40:27 amaryllis kernel:  [pci_unregister_driver+23/37] pci_unregi=
ster_driver+0x17/0x25
Jul 31 14:40:27 amaryllis kernel:  [_end+540895445/1068727528] uhci_hcd_cle=
anup+0x12/0x5c [uhci_hcd]
Jul 31 14:40:27 amaryllis kernel:  [sys_delete_module+295/409] sys_delete_m=
odule+0x127/0x199
Jul 31 14:40:27 amaryllis kernel:  [sys_munmap+87/117] sys_munmap+0x57/0x75
Jul 31 14:40:27 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 31 14:40:27 amaryllis kernel:=20
Jul 31 14:40:27 amaryllis kernel: Badness in device_release at drivers/base=
/core.c:84
Jul 31 14:40:27 amaryllis kernel: Call Trace:
Jul 31 14:40:27 amaryllis kernel:  [kobject_cleanup+129/131] kobject_cleanu=
p+0x81/0x83
Jul 31 14:40:27 amaryllis kernel:  [device_unregister+20/34] device_unregis=
ter+0x14/0x22
Jul 31 14:40:27 amaryllis kernel:  [usb_disconnect+237/395] usb_disconnect+=
0xed/0x18b
Jul 31 14:40:27 amaryllis kernel:  [usb_hcd_pci_remove+180/410] usb_hcd_pci=
_remove+0xb4/0x19a
Jul 31 14:40:27 amaryllis kernel:  [pci_device_remove+59/61] pci_device_rem=
ove+0x3b/0x3d
Jul 31 14:40:27 amaryllis kernel:  [device_release_driver+96/98] device_rel=
ease_driver+0x60/0x62
Jul 31 14:40:27 amaryllis kernel:  [driver_detach+34/49] driver_detach+0x22=
/0x31
Jul 31 14:40:27 amaryllis kernel:  [bus_remove_driver+87/143] bus_remove_dr=
iver+0x57/0x8f
Jul 31 14:40:27 amaryllis kernel:  [driver_unregister+26/68] driver_unregis=
ter+0x1a/0x44
Jul 31 14:40:27 amaryllis kernel:  [pci_unregister_driver+23/37] pci_unregi=
ster_driver+0x17/0x25
Jul 31 14:40:27 amaryllis kernel:  [_end+540895445/1068727528] uhci_hcd_cle=
anup+0x12/0x5c [uhci_hcd]
Jul 31 14:40:27 amaryllis kernel:  [sys_delete_module+295/409] sys_delete_m=
odule+0x127/0x199
Jul 31 14:40:27 amaryllis kernel:  [sys_munmap+87/117] sys_munmap+0x57/0x75
Jul 31 14:40:27 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 31 14:40:27 amaryllis kernel:=20
Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.0: USB bus 1 deregist=
ered
Jul 31 14:40:27 amaryllis kernel: Badness in kobject_cleanup at lib/kobject=
=2Ec:402
Jul 31 14:40:27 amaryllis kernel: Call Trace:
Jul 31 14:40:27 amaryllis kernel:  [kobject_cleanup+96/131] kobject_cleanup=
+0x60/0x83
Jul 31 14:40:27 amaryllis kernel:  [usb_hcd_pci_remove+328/410] usb_hcd_pci=
_remove+0x148/0x19a
Jul 31 14:40:27 amaryllis kernel:  [pci_device_remove+59/61] pci_device_rem=
ove+0x3b/0x3d
Jul 31 14:40:27 amaryllis kernel:  [device_release_driver+96/98] device_rel=
ease_driver+0x60/0x62
Jul 31 14:40:27 amaryllis kernel:  [driver_detach+34/49] driver_detach+0x22=
/0x31
Jul 31 14:40:27 amaryllis kernel:  [bus_remove_driver+87/143] bus_remove_dr=
iver+0x57/0x8f
Jul 31 14:40:27 amaryllis kernel:  [driver_unregister+26/68] driver_unregis=
ter+0x1a/0x44
Jul 31 14:40:27 amaryllis kernel:  [pci_unregister_driver+23/37] pci_unregi=
ster_driver+0x17/0x25
Jul 31 14:40:27 amaryllis kernel:  [_end+540895445/1068727528] uhci_hcd_cle=
anup+0x12/0x5c [uhci_hcd]
Jul 31 14:40:27 amaryllis kernel:  [sys_delete_module+295/409] sys_delete_m=
odule+0x127/0x199
Jul 31 14:40:27 amaryllis kernel:  [sys_munmap+87/117] sys_munmap+0x57/0x75
Jul 31 14:40:27 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 31 14:40:27 amaryllis kernel:=20
Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.2: remove, state 3
Jul 31 14:40:27 amaryllis kernel: usb usb2: USB disconnect, address 1
Jul 31 14:40:27 amaryllis kernel: Badness in device_release at drivers/base=
/core.c:84
Jul 31 14:40:27 amaryllis kernel: Call Trace:
Jul 31 14:40:27 amaryllis kernel:  [kobject_cleanup+129/131] kobject_cleanu=
p+0x81/0x83
Jul 31 14:40:27 amaryllis kernel:  [device_unregister+20/34] device_unregis=
ter+0x14/0x22
Jul 31 14:40:27 amaryllis kernel:  [usb_disconnect+237/395] usb_disconnect+=
0xed/0x18b
Jul 31 14:40:27 amaryllis kernel:  [usb_hcd_pci_remove+180/410] usb_hcd_pci=
_remove+0xb4/0x19a
Jul 31 14:40:27 amaryllis kernel:  [pci_device_remove+59/61] pci_device_rem=
ove+0x3b/0x3d
Jul 31 14:40:27 amaryllis kernel:  [device_release_driver+96/98] device_rel=
ease_driver+0x60/0x62
Jul 31 14:40:27 amaryllis kernel:  [driver_detach+34/49] driver_detach+0x22=
/0x31
Jul 31 14:40:27 amaryllis kernel:  [bus_remove_driver+87/143] bus_remove_dr=
iver+0x57/0x8f
Jul 31 14:40:27 amaryllis kernel:  [driver_unregister+26/68] driver_unregis=
ter+0x1a/0x44
Jul 31 14:40:27 amaryllis kernel:  [pci_unregister_driver+23/37] pci_unregi=
ster_driver+0x17/0x25
Jul 31 14:40:27 amaryllis kernel:  [_end+540895445/1068727528] uhci_hcd_cle=
anup+0x12/0x5c [uhci_hcd]
Jul 31 14:40:27 amaryllis kernel:  [sys_delete_module+295/409] sys_delete_m=
odule+0x127/0x199
Jul 31 14:40:27 amaryllis kernel:  [sys_munmap+87/117] sys_munmap+0x57/0x75
Jul 31 14:40:27 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 31 14:40:27 amaryllis kernel:=20
Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.2: USB bus 2 deregist=
ered
Jul 31 14:40:27 amaryllis kernel: drivers/usb/core/usb.c: deregistering dri=
ver audio
Jul 31 14:40:27 amaryllis kernel: drivers/usb/core/usb.c: deregistering dri=
ver Philips webcam

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KLyQcyGjihSg3eURAgfDAJ9NzBF2JQ2bxixNmccd2ORViOtXMQCePc6N
Fr4t58a0Ze+M4WHlfJEoIXo=
=B2hW
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
