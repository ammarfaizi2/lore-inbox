Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbREQK0S>; Thu, 17 May 2001 06:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbREQK0J>; Thu, 17 May 2001 06:26:09 -0400
Received: from [212.171.207.33] ([212.171.207.33]:49159 "EHLO gollum.link.it")
	by vger.kernel.org with ESMTP id <S261392AbREQKZ7>;
	Thu, 17 May 2001 06:25:59 -0400
Subject: smp hangs with 2.2.19 kernel
From: "Andrea Dell'Amico" <adellam@link.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 17 May 2001 12:25:35 +0200
Message-Id: <990095136.29185.5.camel@altrove>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo, I have a problem with a dual processor machine. With Red Hat
2.2.19 kernel, but with every 2.2.1x kernel, from Red Hat or self
compiled, the machine hangs with lot of processes in D state:

vmstat output is

procs       memory    swap          io     system         cpu
 r  b  w swpd free  buff cache si  so    bi    bo   in    cs  us  sy  id
 1 225 2   0  10632  10936  16456   0   0  6   3   14     9   6   3  14


The memory situation:

[root@petra petra]# free
             total       used       free     shared    buffers
cached
Mem:        523800     504688      19112          0      10620
31352
-/+ buffers/cache:     462716      61084
Swap:      2097136      35164    2061972


The box has 5 scsi disks with a aic7xxx controller. 4 disks are in RAID
1, the fifth is only used for the swap partition (2 GB).

When the machine hangs there are no logs.

Is there a way I can debug the cause? 

Thanks in advance,
andrea


-- 
Andrea Dell'Amico
<adellam@link.it> - Link s.r.l. <http://www.link.it>


