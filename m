Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRJ3VUO>; Tue, 30 Oct 2001 16:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJ3VUD>; Tue, 30 Oct 2001 16:20:03 -0500
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:33624 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S276344AbRJ3VTt>; Tue, 30 Oct 2001 16:19:49 -0500
Message-ID: <3BDF1999.CAF5D101@mandrakesoft.com>
Date: Tue, 30 Oct 2001 16:20:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, andrea@suse.de
Subject: pre5 VM livelock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.14-pre5 was looking very nice on my alpha, doing RPM builds.  It
seems to swap only when it needs to, and subjectively, performance
appears better.

However at this very moment, the kernel is livelocked.  I can type on
console and do sysrq to your heart's content... I can even sysrq-s and
sync successfully.  But no processing occurs.  I can ping, but two ssh
sessions are frozen.

Key symptoms:  Free swab 0Kb according to sysrq-m, and several processes
in run state according to sysrq-t.

Let me know if I should poke at this alpha further before rebooting.

further info:
free pages: 2560 kb (0kb highmem)
( active 2422 inactive 38578 free 320 )
swap cache: add 850670  delete 850666 find 323063/440091 race 1+0
free swap: 0kb
49074 pages of ram
786 free pages
1299 reserved pages
2683 pages shared
4 pages swap cached
4 pages in page table cache
buffer memory: 168kb

This behavior is reproducible, I am pretty sure.


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

