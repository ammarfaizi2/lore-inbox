Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUKGJlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUKGJlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 04:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUKGJlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 04:41:37 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52410 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261565AbUKGJld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 04:41:33 -0500
Message-ID: <418DEDA5.8060107@t-online.de>
Date: Sun, 07 Nov 2004 10:40:53 +0100
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-usb-users@lists.sourceforge.net
CC: =?ISO-8859-1?Q?J=F6rg_Spilker?= <js@jetsys.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Apple Ipod doesn't work with USB on linux (but works with FireWire)
References: <200411071004.15605.js@jetsys.de>
In-Reply-To: <200411071004.15605.js@jetsys.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: EPSbA4Zp8ePb+rDtj+z74kYpkrmlgU2aukC82b9vKT1py8qApECkUC
X-TOI-MSGID: f3642f3e-3b45-44e3-9fba-0c8d904d9ee0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jörg Spilker wrote:
| Hi,
|
| i recently purchased a new Ipod Mini which i initially used via Firewire on my Laptop with windows.
| Then i tried to change to Linux (using gtkpod for managing my playlists). Because i want to leave the
| firewire cable connected to the laptop, i tried using the USB variant on Linux. My first try was with
| SuSE 9.0 and a 2.4.x kernel. Unfortunately with no success. Same errors as you see here (now with
| SuSE 9.2 and kernel 2.6.8).
|
| Nov  7 00:45:17 lotus kernel: usb 4-5: new high speed USB device using address 8
| Nov  7 00:45:17 lotus kernel: usb 4-5: Product: iPod mini
| Nov  7 00:45:17 lotus kernel: usb 4-5: Manufacturer: Apple
| Nov  7 00:45:17 lotus kernel: usb 4-5: SerialNumber: 0000009056D9
| Nov  7 00:45:17 lotus kernel: scsi4 : SCSI emulation for USB Mass Storage devices
| Nov  7 00:45:17 lotus kernel:   Vendor: Apple     Model: iPod              Rev: 1.61
| Nov  7 00:45:17 lotus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
| Nov  7 00:45:18 lotus kernel: SCSI device sda: 7999488 512-byte hdwr sectors (4096 MB)
| Nov  7 00:45:18 lotus kernel: sda: Write Protect is off
| Nov  7 00:45:18 lotus kernel: sda: Mode Sense: 64 00 00 08
| Nov  7 00:45:18 lotus kernel: sda: assuming drive cache: write through
| Nov  7 00:45:18 lotus kernel:  sda:end_request: I/O error, dev sda, sector 7999480
| Nov  7 00:45:18 lotus kernel: Buffer I/O error on device sda, logical block 999935
| Nov  7 00:45:18 lotus kernel: end_request: I/O error, dev sda, sector 7999480
| Nov  7 00:45:18 lotus kernel: Buffer I/O error on device sda, logical block 999935
| Nov  7 00:45:18 lotus kernel:  sda1 sda2
| Nov  7 00:45:18 lotus kernel: Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
| Nov  7 00:45:18 lotus kernel: Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
| Nov  7 00:45:18 lotus kernel: USB Mass Storage device found at 8
| Nov  7 00:45:28 lotus /etc/dev.d/block/50-hwscan.dev[17084]: new block device /block/sda/sda1
| Nov  7 00:45:28 lotus /etc/dev.d/block/50-hwscan.dev[17085]: new block device /block/sda/sda2
| Nov  7 00:45:28 lotus /etc/dev.d/block/51-subfs.dev[17100]: mount block device /block/sda/sda1
| Nov  7 00:45:28 lotus /etc/dev.d/block/51-subfs.dev[17105]: mount block device /block/sda/sda2
| Nov  7 00:45:28 lotus kernel: end_request: I/O error, dev sda, sector 80325
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 0
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 1
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 2
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 3
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 4
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 5
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 6
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 7
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 8
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 9
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 10
| Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 11
|

Metoo. I've got a similar problem with an external USB disk.
Not an ipod, but just a mass storage device.

Kernel is 2.6.10-rc1 .

Please mail if I can help.


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBje2lUTlbRTxpHjcRAhvBAJ42LLg2MalAuRXU/9rS39G+PGhITgCfX7m3
8Qc9f1UMK8l0b3PI7I0sP+Y=
=DGNN
-----END PGP SIGNATURE-----
