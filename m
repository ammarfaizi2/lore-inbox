Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265491AbTLIMXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTLIMXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:23:32 -0500
Received: from tweedy.ksc.nasa.gov ([128.217.76.165]:13447 "EHLO
	tweedy.ksc.nasa.gov") by vger.kernel.org with ESMTP id S265491AbTLIMX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:23:28 -0500
Subject: Re: may be silly question..
From: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
To: neel vanan <neelvanan@yahoo.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031209102937.88660.qmail@web9505.mail.yahoo.com>
References: <20031209102937.88660.qmail@web9505.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1070972605.8456.5.camel@tweedy.ksc.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 07:23:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 05:29, neel vanan wrote:
> Hi folks,
> currently, i am running RedHat9.0 kernel 2.4.20-8 on
> my SMP server machine with 4GB of RAM, Now i am trying
> to upgrade to ver 2.6.0-test11.I did the following
> steps.
> 
> make bzImage
> make modules
> make modules_install
> mkinitrd 
> cp bzImaze to /boot/
> 
> when I reboot the machine I had the following error 
> ......
> scsi: A:0:0: Tagged Queuing enabled. Depth 32
> SCSI device sda: 35843670 512-byte hdwr sectors (18352
> MB)
> SCSI device sda: drive cache write back
> sda: unknown partition table
> Attached scsi disk sda at scsi0, channel0, id0, lun0
> mounting /proc file system
> creating block devices
> creating Root devices
> Mounting root filesystem
> mount : erro 6 mounting ext3
> pivotroot : pivot_root (/sysroot, /sysroot/initrd)
> failed:2
> umount /initrd/proc failed :2
> freeing unused kernel memory : 464k freed
> Kernel panic: no init found. Try passing init= option
> to kernel
> 
> Then the system seems to hang at this point

Just a thought:  Try upgrading modutils, and mkinitrd.  The Fedora
(Rawhide) versions should work.  Fedora uses modutils-2.4.25-13 and
mkinitrd-3.5.14-1.

Bob...

