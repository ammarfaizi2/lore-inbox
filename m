Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUJMJll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUJMJll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUJMJll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:41:41 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:28551 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S267939AbUJMJlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:41:39 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: xfs problems in 2.6.9-rc4 ?
Date: Wed, 13 Oct 2004 09:41:38 +0000 (UTC)
Organization: Cistron
Message-ID: <ckit8i$np4$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1097660498 24356 62.216.30.38 (13 Oct 2004 09:41:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On our usenet storage server (diablo setup) we are running
2.6.9-rc4 and we see a *lot* of this in dmesg:

xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
printk: 2899 messages suppressed.

dth@spool1:~$ mount  
/dev/hda1 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda5 on /usr type ext3 (rw)
/dev/hda6 on /var type ext3 (rw)
/dev/hda7 on /extra type ext3 (rw)
/dev/md0 on /news type ext3 (rw,data=writeback)
/dev/sdb1 on /news/spool/news/P.00 type xfs (rw,noatime)
/dev/sdd1 on /news/spool/news/P.01 type xfs (rw,noatime)
/dev/sdb5 on /news/spool/news/P.02 type xfs (rw,noatime)
/dev/sdb6 on /news/spool/news/P.03 type xfs (rw,noatime)
/dev/sdb7 on /news/spool/news/P.04 type xfs (rw,noatime)
/dev/sdb8 on /news/spool/news/P.05 type xfs (rw,noatime)
/dev/sdd5 on /news/spool/news/P.06 type xfs (rw,noatime)
/dev/sdd6 on /news/spool/news/P.07 type xfs (rw,noatime)
/dev/sdd7 on /news/spool/news/P.08 type xfs (rw,noatime)
/dev/sdd8 on /news/spool/news/P.09 type xfs (rw,noatime)

.config & kern.log output @ http://dth.net/kernel/

Anyone has any hints where to look ?

Danny
-- 
All those who believe in psychokinesis, raise my hand.

