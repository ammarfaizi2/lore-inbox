Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRCYVur>; Sun, 25 Mar 2001 16:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRCYVu2>; Sun, 25 Mar 2001 16:50:28 -0500
Received: from protactinium.btinternet.com ([194.73.73.176]:62676 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S132219AbRCYVuQ>;
	Sun, 25 Mar 2001 16:50:16 -0500
Date: Sun, 25 Mar 2001 22:58:59 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: question on /dev/tap0
Message-ID: <Pine.LNX.4.21.0103252255170.12913-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

would somebody be able to explain to me
when you try to open /dev/tap0 which is a
character device file which has the permissions

File: "tap0"
Size: 0            Filetype: Character Device
Mode: (0666/crw-rw-rw-)

when tried to open

[mistral@linux /dev]$ cat tap0
cat: tap0: Operation not permitted

and strace shows that it gets a permission error
open("tap0", O_RDONLY|0x8000)           = -1 EPERM

is it just me or is this either
a) a bug
b) very misleading

thanks
	James

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
 10:50pm  up 58 min,  3 users,  load average: 0.30, 0.11, 0.03

