Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUDSXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUDSXgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUDSXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:36:52 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:4006 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S261248AbUDSXgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:36:50 -0400
Organization: 
Date: Tue, 20 Apr 2004 02:36:41 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
In-Reply-To: <20040419101743.3c50e14b.rddunlap@osdl.org>
Message-ID: <Pine.GSO.4.58.0404200236250.948@thanatos.csd.uoc.gr>
References: <407F821A.3040908@debian.org> <20040418040111.GR3445@bakeyournoodle.com>
 <40836E12.8000402@debian.org> <20040419092155.1614862a.rddunlap@osdl.org>
 <40840565.6000304@debian.org> <20040419101743.3c50e14b.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also get the same problem here.

	Panagiotis Papadakos

On Mon, 19 Apr 2004, Randy.Dunlap wrote:

> On Mon, 19 Apr 2004 18:59:17 +0200 Giacomo A. Catenazzi wrote:
>
> | Randy.Dunlap wrote:
> | > On Mon, 19 Apr 2004 08:13:38 +0200 Giacomo A. Catenazzi wrote:
> | > |
> | > | I've still the same error on newer bk:
> | > |
> | > |
> | > |    CC      init/main.o
> | > | In file included from include/linux/proc_fs.h:6,
> | > |                   from init/main.c:17:
> | > | include/linux/fs.h:23:25: linux/audit.h: No such file or directory
> | > | In file included from include/asm/irq.h:16,
> | > |                   from include/linux/kernel_stat.h:5,
> | > |                   from init/main.c:34:
> | > | include/asm-i386/mach-default/irq_vectors.h:87:32: irq_vectors_limits.h: No such file or directory
> | > | In file included from init/main.c:34:
> | > | include/linux/kernel_stat.h:28: error: `NR_IRQS' undeclared here (not in a function)
> | > | make[1]: *** [init/main.o] Error 1
> | > |
> | > |
> | > | Attached my .config
> | >
> | >
> | > 2.6.6-rc1-bk4 builds for me with your .config file.
> | > Were you using something earlier than (before) rc1-bk4 ?
> |
> |
> | I'm using the latest linus bk version
> |
> | VERSION = 2
> | PATCHLEVEL = 6
> | SUBLEVEL = 6
> | EXTRAVERSION =-rc1
> | NAME=Zonked Quokka
> |
> |
> | hmm:
> |
> | cate@catee:~/kernel/5,v2.5/bk/linus-2.5$ find include/ | grep audit
> | include/linux/SCCS/s.audit.h
> | include/config/audit.h
> |
> | but no include/linux/audit.h as used in include/linux/fs.h
> |
> | Corrupted local bk?
>
> Sounds like something like that.  I don't know for sure.
> Just that 2.6.6-rc1 builds for me with your .config file
> (using tarball, not using bk).
>
> --
> ~Randy
> "We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
> (Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
