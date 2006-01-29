Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWA2XNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWA2XNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWA2XNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:13:50 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:34249 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S932068AbWA2XNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:13:50 -0500
Date: Mon, 30 Jan 2006 01:13:48 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: RAID autodetection not working when booting with initramfs
Message-ID: <Pine.LNX.4.64.0601300103110.2016@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 	Hi ,

 	I am building a diskless system with 2.6.15.1 kernel. Eveyrthing is built 
in the kernel ( no modules). It is booting with the help of pxelinux and 
then proceeds to nfsmount its root filesystem etc.The system has a raid1 
array on two scsi disks.
 	Recently I added an initramfs image to the boot procedure (append 
initrd=initramfs.img) for some tests. Since then the raid array is not 
autodetected (with identical kernel). If I remove the initramfs line and 
reboot , the array is autodetected. When I am using initramfs I can 
manually activate it using mdadm.

 	Is this by design or something is wrong ?

 	TIA,

--
============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
============================================================================
