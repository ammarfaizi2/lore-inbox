Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUEQR1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUEQR1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUEQR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:27:44 -0400
Received: from stud4.tuwien.ac.at ([193.170.75.21]:34508 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S261932AbUEQRZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:25:54 -0400
Message-ID: <40A8F5A0.3010108@chello.at>
Date: Mon, 17 May 2004 19:25:52 +0200
From: Roland Lezuo <roland.lezuo@chello.at>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040505)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usb_storage / sd_mod problems
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

i have an traxdata usb stick (EZ drive) and encounter serious problems
on various kernels (vanilla-2.6.6, gentoo-2.6.5-r2, fedora-core
2.6.5-1.327)

This is the fedora-core dmesg trace:

usb 1-3: new high speed USB device using address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
~  Vendor: Generic   Model:                   Rev:
~  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
^^^^
delay of around 1 minute here

scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 0 lun 0
sda: asking for cache data failed
sda: assuming drive cache: write through
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

2.6.3-gentoo-r2 works, whereas gentoo-2.6.5-r2 on same motherboard fails
(similar message) 2.6.6 hangs usb_storage forever, even reboot not possible.

Please CC me personally

Regards
Roland Lezuo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAqPWg5qlVDPzJ7R4RAnidAJ9vh6Jxy+WV9LIltjrWEjNZ5JXpQACdF+rY
PV7CMVi2qDkyKxR5O3KdeEw=
=fWb3
-----END PGP SIGNATURE-----
