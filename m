Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVG0Luj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVG0Luj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVG0Luj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:50:39 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:13973 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S262190AbVG0Luh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:50:37 -0400
Message-Id: <200507271150.j6RBoXn9018660@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc3-git8 make install error
Date: Wed, 27 Jul 2005 12:50:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just got the following with patch-2.6.13-rc3-git8:

# make install
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      init/do_mounts_initrd.o
In file included from include/asm/unistd.h:426,
                 from include/linux/unistd.h:9,
                 from init/do_mounts_initrd.c:2:
include/asm/ptrace.h: In function `user_mode_vm':
include/asm/ptrace.h:67: error: `VM_MASK' undeclared (first use in this
function)
include/asm/ptrace.h:67: error: (Each undeclared identifier is reported only
once
include/asm/ptrace.h:67: error: for each function it appears in.)
make[1]: *** [init/do_mounts_initrd.o] Error 1
make: *** [init] Error 2

Thanks 

Colin Harrison

