Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290203AbSALBYo>; Fri, 11 Jan 2002 20:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290205AbSALBYf>; Fri, 11 Jan 2002 20:24:35 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:27810 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S290203AbSALBYZ>; Fri, 11 Jan 2002 20:24:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 11 Jan 2002 17:24:24 -0800
Message-Id: <200201120124.RAA10614@adam.yggdrasil.com>
To: dcd@tc.fluke.com
Subject: Re: Patch: linux-2.5.2-pre7/drivers/cdrom additional kdev_t fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I had been testing 2.5.2-pre11 and earlier, but hadn't looked at
>reading from my cdrom for a while.  Yesterday I created examined several
>large cdrom sets that had been readable earlier and they read partially
>but get read errors.  These same cdroms can be read reliable on
>2.4.18-pre3 using the same hardware, and are readable on other
>PC's runing older kernels.

>Has anyone else seen cdrom read errors with 2.5.2-pre* kernels?

> David

	Please indicate what kind of interface your CDROM drive
has (and preferably make and model of the drive) and what
errors you saw.

	If you are using an IDE or SCSI CDROM drive, then the problems
you are experiencing have nothing to do with my patch.  My patch was
only for the very old "proprietary interface" CDROM drives, which are
almost all "1X" or "2X" speed drives.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
