Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWDNLDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDNLDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWDNLDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:03:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12559 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751244AbWDNLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:03:51 -0400
Date: Fri, 14 Apr 2006 12:02:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>
Subject: ARM: collie_defconfig broken
Message-ID: <20060414110246.GA21060@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel, 2.6.17-rc1-git7:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-sa1100/built-in.o: In function `collie_init':
arch/arm/mach-sa1100/sleep.S:(.init.text+0x4b8): undefined reference to `platform_scoop_config'
make: *** [.tmp_vmlinux1] Error 1
make: Leaving directory `/var/tmp/kernel-orig'

Would be nice to have this fixed sometime.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
