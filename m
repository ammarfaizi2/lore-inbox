Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUDPGvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUDPGvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:51:05 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:44226 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S262538AbUDPGvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:51:03 -0400
Message-ID: <407F821A.3040908@debian.org>
Date: Fri, 16 Apr 2004 08:50:02 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compile error in main.c [2.6.bk]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since few days I cannot recompile the kernel.
Do I have some very strange configuration?
[ i386, pentium 4, SMP, $KB stack,...
full .config at request]

   CC      init/main.o
In file included from include/linux/proc_fs.h:6,
                  from init/main.c:17:
include/linux/fs.h:23:25: linux/audit.h: No such file or directory
In file included from include/asm/irq.h:16,
                  from include/linux/kernel_stat.h:5,
                  from init/main.c:34:
include/asm-i386/mach-default/irq_vectors.h:87:32: irq_vectors_limits.h: No such file or directory
In file included from init/main.c:34:
include/linux/kernel_stat.h:28: error: `NR_IRQS' undeclared here (not in a function)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

ciao
	cate
