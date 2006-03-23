Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWCWQi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWCWQi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWCWQi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:38:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50952 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422631AbWCWQi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:38:58 -0500
Date: Thu, 23 Mar 2006 16:38:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: 2.6.16-git6: build failure: ksysfs.c (h7201_defconfig)
Message-ID: <20060323163852.GC25849@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building h7201_defconfig on ARM provokes these build errors:

  LD      .tmp_vmlinux1
kernel/built-in.o: In function `uevent_seqnum_show':
ksysfs.c:(.text+0x1f258): undefined reference to `uevent_seqnum'
kernel/built-in.o: In function `uevent_helper_show':
ksysfs.c:(.text+0x1f280): undefined reference to `uevent_helper'
kernel/built-in.o: In function `uevent_helper_store':
ksysfs.c:(.text+0x1f2e0): undefined reference to `uevent_helper'
kernel/built-in.o:(.data+0xd1c): undefined reference to `uevent_helper'
make: *** [.tmp_vmlinux1] Error 1
make: Leaving directory `/var/tmp/kernel-orig'

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
