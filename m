Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTIARYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTIARYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:24:19 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:64518 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263151AbTIARYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:24:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Dirk Jakobsmeier <dirk@dirk-jakobsmeier.de>
Newsgroups: linux.kernel
Subject: raid1 error while rewind tape
Date: Mon, 01 Sep 2003 19:24:05 +0200
Organization: debitel.net - der Onlinedienst
Message-ID: <bivvbr$53i$1@ulysses.news.tiscali.de>
Reply-To: dirk@dirk-jakobsmeier.de
NNTP-Posting-Host: mwnews.dnsg.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1062437051 5234 195.71.125.220 (1 Sep 2003 17:24:11 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Mon, 1 Sep 2003 17:24:11 +0000 (UTC)
User-Agent: KNode/0.7.2
X-NNTP-Posting-Host: 217.185.55.198
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi you all

i have a big problem with running my backup server with kernel 2.4.21 and a
raid1. Both, the scsi disks and the tape use the same scsi controller.
While i let the system rewind the tape, and if this command needs long
time, the scsi driver from kernel recogizes an error.

kernel: scsi : aborting command due to timeout.
kernel: SCSI disk error
kernel:  I/O error
kernel: raid1: Disk failure
kernel: ^IOperation continuing on 1 devices
kernel: md: updating md2 RAID superblock on device
kernel: md: recovery thread got woken up
kernel: md2: resyncing spare disk
kernel: RAID1 conf printout:
.
.
.

Is there a possibility to handle this problem, or do i have to install a
second scsi controller?

Thanks for any help.

Dirk
