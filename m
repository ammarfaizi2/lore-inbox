Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUDSQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDSQ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:27:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:23694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261419AbUDSQ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:27:33 -0400
Date: Mon, 19 Apr 2004 09:21:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: tony@bakeyournoodle.com, linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
Message-Id: <20040419092155.1614862a.rddunlap@osdl.org>
In-Reply-To: <40836E12.8000402@debian.org>
References: <407F821A.3040908@debian.org>
	<20040418040111.GR3445@bakeyournoodle.com>
	<40836E12.8000402@debian.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 08:13:38 +0200 Giacomo A. Catenazzi wrote:

| Tony Breeds wrote:
| >
| > Either it is fixed in the bk2 snapshot or your .config is confused.
| > 
| > Grab bk2 if you're still getting the error post your .config and we'll
| > see wnat we can see.
| > 
| > Yours Tony
| >
| 
| I've still the same error on newer bk:
| 
| 
|    CC      init/main.o
| In file included from include/linux/proc_fs.h:6,
|                   from init/main.c:17:
| include/linux/fs.h:23:25: linux/audit.h: No such file or directory
| In file included from include/asm/irq.h:16,
|                   from include/linux/kernel_stat.h:5,
|                   from init/main.c:34:
| include/asm-i386/mach-default/irq_vectors.h:87:32: irq_vectors_limits.h: No such file or directory
| In file included from init/main.c:34:
| include/linux/kernel_stat.h:28: error: `NR_IRQS' undeclared here (not in a function)
| make[1]: *** [init/main.o] Error 1
| 
| 
| Attached my .config


2.6.6-rc1-bk4 builds for me with your .config file.
Were you using something earlier than (before) rc1-bk4 ?

--
~Randy
