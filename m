Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRKGX3c>; Wed, 7 Nov 2001 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281084AbRKGX3X>; Wed, 7 Nov 2001 18:29:23 -0500
Received: from line205.comsat.net.ar ([200.47.131.205]:62876 "HELO
	line205.comsat.net.ar") by vger.kernel.org with SMTP
	id <S281075AbRKGX3O>; Wed, 7 Nov 2001 18:29:14 -0500
Date: Wed, 7 Nov 2001 20:30:07 -0300
From: martin sepulveda <msepulveda@labase.com.ar>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 and athlon
Message-Id: <20011107203007.09d19857.msepulveda@labase.com.ar>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i have a athlon 950 MHz (Via 686 chipset) that's acting
funny on 2.4.2, 2.4.6, 2.4.10 and 2.4.12-ac3 with Rik's VM.
512 MB memory, 1 GB swap. all partitions are ext2, and the system
is a RH 7.1.

after some time running (apache/mysql/bind, not really heavy
load for the bos, except for backing up sites), load starts
to go higher and higher, and eventually (after reaching loads
of 70 - 90), it only responds pings. since it's in a farming
facility and this behaviour is not predictable (not cron-related,
for example) i can't see any console output. this happend about dayly
on 2.4.6, and about weekly now (2.4.12-ac3 rik vm).

i guess it's all VM related, since it seems to get better, with
the kernel upgrades, but i'm not sure anyway.

does anyone have any idea of what might i do? i plan to give 2.4.14
a try, but don't know what patches or options do you believe will
be better. (no, i dont have another machine at hand to test, and
yes, it's our production server).

thanks in advance,

M.

-- 
Talent does what it can, genius what it must.
I do what I get paid to do.

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM dpu s+:- a- C++++ UL++++ P++++ L++++ E--- W- N-- o-- K- w-- 
O---- M-- V-- PS++ PE- Y++ PGP+++ t+ 5 X R+ !tv b+++ DI++ D+++ 
G++ e++ h++ r+ y++ 
------END GEEK CODE BLOCK------
