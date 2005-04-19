Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDSMGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDSMGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVDSMGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:06:38 -0400
Received: from v6.netlin.pl ([62.121.136.6]:47366 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261462AbVDSMGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:06:35 -0400
Message-ID: <4264F3DD.7090204@pointblue.com.pl>
Date: Tue, 19 Apr 2005 14:04:45 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: hama card reader 19in1 question on USB (not workie)
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello

Does anyone have sucessfully used device in subject ?
It doesn't seem to work here. All I get is:


Apr 19 14:03:44 thinkpaddie kernel: usb 1-1.4: new full speed USB device
using uhci_hcd and address 7
Apr 19 14:03:44 thinkpaddie kernel: scsi5 : SCSI emulation for USB Mass
Storage devices
Apr 19 14:03:44 thinkpaddie kernel: usb-storage: device found at 7
Apr 19 14:03:44 thinkpaddie kernel: usb-storage: waiting for device to
settle before scanning
Apr 19 14:03:46 thinkpaddie usb.agent[13125]:      usb-storage: already
loaded
Apr 19 14:03:49 thinkpaddie kernel:   Vendor: USB Read  Model: CF Card
     CF  Rev: 1.8D
Apr 19 14:03:49 thinkpaddie kernel:   Type:   Direct-Access
         ANSI SCSI revision: 00
Apr 19 14:03:50 thinkpaddie kernel: Attached scsi removable disk sda at
scsi5, channel 0, id 0, lun 0
Apr 19 14:03:50 thinkpaddie kernel: usb-storage: device scan complete
Apr 19 14:03:50 thinkpaddie scsi.agent[13167]:      sd_mod: loaded
sucessfully (for disk)
Apr 19 14:03:50 thinkpaddie udev[13180]: configured rule in
'/etc/udev/rules.d/devfs.rules' at line 23 applied, added symlink '%k %c{2}'
Apr 19 14:03:50 thinkpaddie udev[13180]: configured rule in
'/etc/udev/rules.d/devfs.rules' at line 23 applied, 'sda' becomes '%c{1}'
Apr 19 14:03:50 thinkpaddie udev[13180]: creating device node
'/dev/scsi/host5/bus0/target0/lun0/disc'


But no SD card is detected, and I can't mount the card.

- --
GJ
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCZPPdi0HtPCVkDAURAh39AJ4xIwn3X95ez+Kmn9v/vm6LbbXVDgCffdol
+pDKDEIgxyNUy7iTugUxHPY=
=riFn
-----END PGP SIGNATURE-----
