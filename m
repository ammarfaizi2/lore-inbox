Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSGWUZB>; Tue, 23 Jul 2002 16:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGWUZB>; Tue, 23 Jul 2002 16:25:01 -0400
Received: from mail16.speakeasy.net ([216.254.0.216]:11214 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S318223AbSGWUZA>; Tue, 23 Jul 2002 16:25:00 -0400
Subject: non-critical ext3-fs errors?
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 23 Jul 2002 16:28:10 -0400
Message-Id: <1027456090.1982.28.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice these errors every now and then on my 100GB WD drive
(partitioned into bits) and particularly on this partition that I
compile everything on.   

EXT3-fs error (device ide0(3,7)): ext3_readdir: bad entry in directory
#17821: directory entry across blocks - offset=24, inode=17822,
rec_len=4076, name_len=3 

Now these errors dont cause the system to panic like other ext3 errors
do, so i'm wondering what the significance of these errors are.   I'm
running 2.4.19-rc3   and the drive is on VIA vt82c686b (rev 40) IDE
UDMA100 controller with dma enabled. 


