Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265816AbUFDPaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUFDPaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUFDPad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:30:33 -0400
Received: from stud4.tuwien.ac.at ([193.170.75.21]:3838 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S265812AbUFDPaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:30:22 -0400
Message-ID: <40C0958C.8070008@chello.at>
Date: Fri, 04 Jun 2004 17:30:20 +0200
From: Roland Lezuo <roland.lezuo@chello.at>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040505)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sd_mod problems with 2.6.7rc2
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

this nasty scsi / usb_storage bug is still around.

usb 1-4: new high speed USB device using address 2
scsi0 : SCSI emulation for USB Mass Storage devices
~  Vendor: Generic   Model:                   Rev:
~  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2

here I modprobed sd_mod and wait 30 sec till modprobe returned to the
prompt.

SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 0 lun 0
sda: asking for cache data failed
sda: assuming drive cache: write through
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

I can't access /dev/sda, and there is no /dev/sda4 entry (using devfs)
as there should be. I'll provide any infos you need...


regards
Roland Lezuo

P.S.: please CC me personally
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAwJWM5qlVDPzJ7R4RAjWWAJ9Z4eCCI+aien2OMBVfemwYKFj4nwCggVFo
Ork7UMtjXMsXlYAYN9liKgs=
=5uue
-----END PGP SIGNATURE-----
