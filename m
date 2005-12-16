Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVLPO4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLPO4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLPO4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:56:31 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:2263
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932322AbVLPO4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:56:31 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: debian-devel@lists.debian.org
Cc: linux-kernel@vger.kernel.org
Subject: gtkpod and Filesystem
Date: Fri, 16 Dec 2005 08:56:34 -0600
Message-Id: <20051216145234.M78009@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.90.18.24 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Debian Sid with 2.6.15-rc5, I wonder if this could be either with a bug
in gtkpod or the kernel (FS Panic).

Whenever I try to sync my Ipod it comes up and says the FS is Write-Procteted
or Read-Only. (This is on the gtkpod interface)
"Error opening '/media/IPOD/iPod_Control/Music/F15/gtkpod108107.mp3' for
writing (Read-only file system)."

drivers/usb/core/inode.c: creating file '003'
Initializing USB Mass Storage driver...
usb-storage 1-4:1.0: usb_probe_interface
usb-storage 1-4:1.0: usb_probe_interface - got id
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Apple     Model: iPod              Rev: 1.62
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 3999743 512-byte hdwr sectors (2048 MB)
sdb: Write Protect is off
sdb: Mode Sense: 68 00 00 08
sdb: assuming drive cache: write through
SCSI device sdb: 3999743 512-byte hdwr sectors (2048 MB)
sdb: Write Protect is off
sdb: Mode Sense: 68 00 00 08
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi removable disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
FAT: Filesystem panic (dev sdb2)
    fat_get_cluster: invalid cluster chain (i_pos 120196)
    File system has been set read-only
FAT: Filesystem panic (dev sdb2)
    fat_get_cluster: invalid cluster chain (i_pos 120196)
FAT: Filesystem panic (dev sdb2)
    fat_get_cluster: invalid cluster chain (i_pos 120196)
FAT: Filesystem panic (dev sdb2)
    fat_get_cluster: invalid cluster chain (i_pos 120196)
FAT: Filesystem panic (dev sdb2)
    fat_get_cluster: invalid cluster chain (i_pos 120196)


--
Open WebMail Project (http://openwebmail.org)

