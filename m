Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTEPWuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTEPWuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:50:24 -0400
Received: from aneto.able.es ([212.97.163.22]:7679 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263281AbTEPWuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:50:16 -0400
Date: Sat, 17 May 2003 01:02:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux-2.4.21-rc2-jam1
Message-ID: <20030516230257.GA4653@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

New release, no important changes. Just I have to admit that bproc does not
work on top of -aa. I suspect that the O(1) scheduler is the one to blame.
I remembered that it worked with -aa, but I think it was before it adopted
the scheduler. So the bproc patch is there just to rty to debug. sigh. I like
-aa vm.

New things: hfsplus driver, updated aic.
Current contents:

000-aa.bz2 (-rc2-aa1)
001-version.bz2
002-printk.bz2
003-memparam.bz2
004-clone-detached.bz2
005-self_exec_id.bz2
006-always-inline.bz2
007-scsi-error-tmout.bz2
008-e1000-close.bz2
009-config-syntax.bz2
010-modular-ide.bz2
011-modular-ide-scsi.bz2
012-smp-call-mb.bz2
013-nfs.bz2
10-inode-size.bz2
11-handle2dentry.bz2
12-fast-csum-D-2.bz2
13-kill-per-cpu-stats.bz2
14-O_STREAMING.bz2
15-binfmt-stack.bz2
16-mremap-use-after-free.bz2
17-slab-loop-init.bz2
18-fat-fdmode.bz2
19-interactive-timeslice.bz2
21-x86-pII.bz2
22-x86-check_gcc.bz2
23-x86-mb.bz2
24-config-nr-cpus.bz2
30-ext3-0.9.19+htree+orlov.bz2
31-seq-single-ops.bz2
40-aic7xxx-20030502.bz2
41-aic-4G-boundary.bz2
45-ide-readahead.bz2
50-perfctr-2.5.2.bz2
51-kksymoops.bz2
52-proconfig-0.9.7.bz2
60-hfsplus-20030507-2.bz2
70-i2c-2.7.0.bz2
71-sensors-2.7.0.bz2
80-bproc-3.2.5.bz2
81-export-task_nice.bz2
90-make.bz2

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-rc2-jam1/

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc2-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
