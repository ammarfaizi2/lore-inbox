Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDSQ7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDSQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:59:35 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:45707 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S261389AbUDSQ73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:59:29 -0400
Message-ID: <40840565.6000304@debian.org>
Date: Mon, 19 Apr 2004 18:59:17 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
References: <407F821A.3040908@debian.org>	<20040418040111.GR3445@bakeyournoodle.com>	<40836E12.8000402@debian.org> <20040419092155.1614862a.rddunlap@osdl.org>
In-Reply-To: <20040419092155.1614862a.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 19 Apr 2004 08:13:38 +0200 Giacomo A. Catenazzi wrote:
> | 
> | I've still the same error on newer bk:
> | 
> | 
> |    CC      init/main.o
> | In file included from include/linux/proc_fs.h:6,
> |                   from init/main.c:17:
> | include/linux/fs.h:23:25: linux/audit.h: No such file or directory
> | In file included from include/asm/irq.h:16,
> |                   from include/linux/kernel_stat.h:5,
> |                   from init/main.c:34:
> | include/asm-i386/mach-default/irq_vectors.h:87:32: irq_vectors_limits.h: No such file or directory
> | In file included from init/main.c:34:
> | include/linux/kernel_stat.h:28: error: `NR_IRQS' undeclared here (not in a function)
> | make[1]: *** [init/main.o] Error 1
> | 
> | 
> | Attached my .config
> 
> 
> 2.6.6-rc1-bk4 builds for me with your .config file.
> Were you using something earlier than (before) rc1-bk4 ?


I'm using the latest linus bk version

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 6
EXTRAVERSION =-rc1
NAME=Zonked Quokka


hmm:

cate@catee:~/kernel/5,v2.5/bk/linus-2.5$ find include/ | grep audit
include/linux/SCCS/s.audit.h
include/config/audit.h

but no include/linux/audit.h as used in include/linux/fs.h

Corrupted local bk?


ciao
	cate
