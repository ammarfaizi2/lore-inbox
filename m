Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264036AbTCXBlS>; Sun, 23 Mar 2003 20:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbTCXBlS>; Sun, 23 Mar 2003 20:41:18 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:2703 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S264036AbTCXBlQ>;
	Sun, 23 Mar 2003 20:41:16 -0500
Date: Mon, 24 Mar 2003 02:52:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux-2.4.21-pre5-jam1
Message-ID: <20030324015218.GA1929@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm back again ;). After wating for -pre5-aa, here it is a new -jam version.
It works for my dual PII.

I'm still pending of testing thoroughly the bproc part, but I can't get down
the cluster now. Anyways, do not know how many people are really interested
on that part...

Main changes:
- based on 2.4.21-pre5-aa2
- ptrace fix ;)
- inode size reduction (WARNING, see README, you _need_ gcc3)
- finedgrained timeslice for O(1) from Ingo
- cleanup of PII spli in config
- gcc -march support for i386
- ext3-0.9.19+htree+orlov
- perfctr-2.5.1
- kksymoops
- aic-20030318 (aic7xxx-6.2.30, aic79xx-1.3.4)
- reverted to i2c-sensors 2.7.0. CVS is under a big reorganization now...
- bproc-3.2.4

All patches:

000-aa2.bz2                   17-slab-loop-init.bz2
001-version.bz2               18-fat-fdmode.bz2
002-printk.bz2                19-interactive-timeslice.bz2
003-memparam.bz2              21-x86-pII.bz2
004-clone-detached.bz2        22-x86-check_gcc.bz2
005-self_exec_id.bz2          23-x86-mb.bz2
006-always-inline.bz2         24-config-nr-cpus.bz2
007-scsi-error-tmout.bz2      30-ext3-0.9.19+htree+orlov.bz2
009-config-syntax.bz2         40-perfctr-2.5.1.bz2
010-e1000-close.bz2           41-kksymoops.bz2
012-ide-scsi.bz2              50-aic-20030318.bz2
013-ptrace.bz2                55-ide-readahead.bz2
014-e100-leak.bz2             60-proconfig-0.9.7.bz2
10-inode.bz2                  70-i2c-2.7.0.bz2
11-handle2dentry.bz2          71-sensors-2.7.0.bz2
12-fast-csum-D-2.bz2          80-bproc-3.2.4.bz2
13-kill-per-cpu-stats.bz2     81-export-task_nice.bz2
14-O_STREAMING.bz2            90-make.bz2
15-binfmt-stack.bz2           README.txt
16-mremap-use-after-free.bz2

Download at
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre5-jam1.tar.bz2

Info:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre5-jam1/

Enjoy !!

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre5-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
