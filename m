Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUKOXo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUKOXo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKOXmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:42:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51451 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261658AbUKOXkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:40:37 -0500
Subject: 2.6.10-rc2 doesn't compile
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100561061.4987.99.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Nov 2004 15:24:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to use 2.6.10-rc2 on my AMD64 machine.
I can't get it to compile. I did usual make clean, 
make oldconfig etc..

BTW, I don't use modules or initrd. I compile all
the drivers I need into the kernel.

Any ideas ? 2.6.10-rc1 works fine.

Thanks.
Badari

# make -j40 bzImage
  CHK     include/linux/version.h
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CHK     usr/initramfs_list
  /usr/src/linux-2.6.10rc2/scripts/gen_initramfs_list.sh: Cannot open
'n' (CONFIG_INITRAMFS_SOURCE)
make[1]: *** [usr/initramfs_list] Error 1
make: *** [usr] Error 2
make: *** Waiting for unfinished jobs....
  CHK     include/linux/compile.h
make: *** wait: No child processes.  Stop.


