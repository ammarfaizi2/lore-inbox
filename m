Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULWGh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULWGh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULWGh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:37:59 -0500
Received: from holomorphy.com ([207.189.100.168]:56500 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261167AbULWGht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:37:49 -0500
Date: Wed, 22 Dec 2004 22:37:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Subject: 2.6.10-rc3-wli-1
Message-ID: <20041223063730.GY771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is. All sparc32 updates.

Most critical here are the HyperSPARC and sun4d updates as they get
things booting that weren't before, though neither fixes things all
the way. Another pretty nasty failure-to-boot issue that brings down
distro kernels is also resolved with Jurij Smakov's initrd memcpy() fix.

The main purpose of all this is so that sparc32 hackers and users can
see what's in and what isn't so they can complain about the fixes that
didn't get in and then I can include those when they remind me.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.6.10-rc3/2.6.10-rc3-wli-1/2.6.10-rc3-wli-1.patch.bz2

+ linus.patch
	sync with last night's bk
+ fix-hypersparc-dvma.patch
	fix DVMA on UP HyperSPARC
+ newport-sun4d.patch
	Christ Newport and Thomas Bogendoerfer's sun4d work
+ jurij-initrd-memcpy.patch
	Jurij Smakov's memcpy() fixes
+ svr4-setcontext-return.patch
	return something in an error path of svr4_setcontext()
+ pcic-warnings.patch
	kill off some warnings in pcic.c
+ sunsu-warnings.patch
	kill off some warnings in sunsu.c
+ rtc-warnings.patch
	kill off some sparc RTC driver warnings
+ vm-fault-codes.patch
	fix up VM fault code handling
+ spot-floppy-fix.patch
	Tom Callaway's include/asm-sparc/floppy.h fixes
+ spot-exit-fix.patch
	Tom Callaway's include/asm-sparc/unistd.h fixes
+ defconfig-update.patch
	Tentative defconfig update. Bug wli if you want an option
	turned on in the defconfig.
+ kropelin-breuer-cg6.patch
	Adam Kropelin and Bob Breuer's cg6 fixes


-- wli
