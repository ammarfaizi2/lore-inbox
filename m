Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUKXPei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUKXPei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUKXPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:30:24 -0500
Received: from lucidpixels.com ([66.45.37.187]:42129 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262689AbUKXNZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:25:49 -0500
Date: Wed, 24 Nov 2004 08:19:06 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 2nd SCSI Driver Compiliation Error w/GCC-3.4.2
Message-ID: <Pine.LNX.4.61.0411240818480.19627@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@p500b:/usr/src/linux# make modules
   CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   LD [M]  drivers/scsi/scsi_mod.o
   CC [M]  drivers/scsi/pci2000.o
drivers/scsi/pci2000.c: In function `Pci2000_QueueCommand':
drivers/scsi/pci2000.c:512: error: structure has no member named `address'
drivers/scsi/pci2000.c:537: error: structure has no member named `address'
drivers/scsi/pci2000.c: At top level:
drivers/scsi/pci2000.c:825: warning: initialization from incompatible 
pointer type
drivers/scsi/pci2000.c:826: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/pci2000.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

