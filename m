Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293027AbSCJMsG>; Sun, 10 Mar 2002 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSCJMr4>; Sun, 10 Mar 2002 07:47:56 -0500
Received: from [194.228.240.11] ([194.228.240.11]:63404 "EHLO sakal.vgd.cz")
	by vger.kernel.org with ESMTP id <S293024AbSCJMrr>;
	Sun, 10 Mar 2002 07:47:47 -0500
Subject: 2.5.6 Swap weirdness
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF7BC4A71.4F6A5218-ONC1256B78.00383620@vgd.cz>
From: Petr.Titera@whitesoft.cz
Date: Sun, 10 Mar 2002 11:18:30 +0100
X-MIMETrack: Serialize by Router on Sakal/SRV/SOCO/CZ(Release 5.0.8 |June 18, 2001) at
 03/10/2002 01:47:45 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

     in linux kernel 2.5.6 swap statistics are displayed incorrectly. Used
space is added to total swap size and not subtracted from free space. See
attached output


[root@nevskij proc]# free
             total       used       free     shared    buffers     cached
Mem:        257348     159748      97600          0       9328      41004
-/+ buffers/cache:     109416     147932
Swap:       152800      24320     128480
[root@nevskij proc]# cat /proc/swaps
Filename                                Type            Size    Used
Priority
/dev/hda5                               partition       128480  24316   -1
[root@nevskij proc]#

Petr Titera

