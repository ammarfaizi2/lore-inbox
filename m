Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286401AbRL0SBJ>; Thu, 27 Dec 2001 13:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286407AbRL0SAt>; Thu, 27 Dec 2001 13:00:49 -0500
Received: from [206.98.161.198] ([206.98.161.198]:7440 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S286401AbRL0SAp>; Thu, 27 Dec 2001 13:00:45 -0500
Subject: Problems booting 2.4.17
From: Edward Muller <emuller@learningpatterns.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Dec 2001 12:58:06 -0500
Message-Id: <1009475886.16791.0.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

I'm having problems booting 2.4.17 on a Mandrake 8.1 system (with all
current updates).

When I boot 2.4.17 (with an initrd image) I get the following...

kernel boots ...
Creating root device
mkrootdev: mknod failed: 17
Mounting root filesyste with flags data=ordered
Mount: error 16 mounting ext3 flags data=ordered
...Tried to remount without flags and fails with the same error...
Kernel Panic: No initrd found ...

I am using ext3 / /boot /usr /var & /home filesystems

2.4.8-34.1mdk boots fine however.

I'm about to go try 2.4.16 (it was working with reiserfs partitions
before).

The machine is an AMD Athalon 1.3 Ghz on an EPOC board with a 3ware 7800
series RAID card, with three 75/80 GB drives in a RAID 5 array.

Anyone else run into something like this? 

I'll report back about 2.4.16 and if anyone would like more info, just
shout.


-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

