Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbRGPNvQ>; Mon, 16 Jul 2001 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267391AbRGPNvG>; Mon, 16 Jul 2001 09:51:06 -0400
Received: from tower.t16.ds.pwr.wroc.pl ([156.17.232.1]:10880 "HELO
	tower.t16.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S267389AbRGPNut>; Mon, 16 Jul 2001 09:50:49 -0400
Date: Mon, 16 Jul 2001 15:50:57 +0200 (CEST)
From: Przemyslaw Wegrzyn <czajnik@tower.t16.ds.pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: File descriptors question
Message-ID: <Pine.LNX.4.21.0107161547100.652-100000@tower.t16.ds.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I run 2.2.19 kernel. I've recently noticed problems with VFS open file
limit. Of course I've changed it, but while examining it I noticed
something strange:

black:/proc# lsof  | wc -l
   1697
   ^^^^
black:/proc# more /proc/sys/fs/file-nr
4096    3623    8192
        ^^^^
black:/proc#

What are all those 3623 - 1697 descriptors used for ?
Is it normal ?
lsof reports includes sockets, FIFOs, etc , so sholdn't those values equal
?

-=Czaj-nick=-


