Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136123AbRDVNtp>; Sun, 22 Apr 2001 09:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136122AbRDVNtf>; Sun, 22 Apr 2001 09:49:35 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:10175 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S136118AbRDVNtW>; Sun, 22 Apr 2001 09:49:22 -0400
Posted-Date: Sun, 22 Apr 2001 15:49:18 +0200 (MET DST)
Date: Sun, 22 Apr 2001 15:48:49 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200104221348.PAA31776@db0bm.ampr.org>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.3-ac12
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

>> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
>> `rwsem_up_write_wake':rwsem.o(.text+0x3c6): undefined reference to
>> `__builtin_expect'
>
>Add a
>
>#define __builtin_expect

I had the same problem here, adding #define __builtin_expect in ../lib/rwsem.c
solved the problem.

gcc is :

[jean-luc@debian-f5ibh] ~ # gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
gcc version 2.95.3 20010315 (Debian release)

-------
Regards

		Jean-Luc
