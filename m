Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270973AbRHXI5D>; Fri, 24 Aug 2001 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271001AbRHXI4x>; Fri, 24 Aug 2001 04:56:53 -0400
Received: from [203.161.228.202] ([203.161.228.202]:25107 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S270973AbRHXI4p>; Fri, 24 Aug 2001 04:56:45 -0400
Date: 24 Aug 2001 09:06:55 -0000
Message-ID: <20010824090655.29285.qmail@yusufg.portal2.com>
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Cc: linux@3ware.com
Subject: 3ware RAID1 sequential read speed slower than write speed (2.4.8-ac10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P3-450 with 256MB RAM with a 3ware 6200 attached to 2 20GB Western
Digitial 7200RPM Caviar Drive  WD200BB

Running bonnie++ <http://www.coker.com.au/bonnie++/> on both an ext3
and ext2 partition, I get the following results

Version  1.01d      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
ext3           512M  6020  98 41022  57  6673   8  4619  77 21834  14 237.1   2


Version  1.01d      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
ext2           512M  6385  99 39969  32  9371  10  5540  91 27864  14 320.7   2


Whilst, I think the write performance is quite good. The read
performance seems to be quite bad. I expected read performance to be
better than write performance for RAID-1 configuration

Any ideas,patches to try ?

Regards, Yusuf
-- 
Yusuf Goolamabbas
yusufg@outblaze.com
