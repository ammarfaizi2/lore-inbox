Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbTCGMkr>; Fri, 7 Mar 2003 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCGMkq>; Fri, 7 Mar 2003 07:40:46 -0500
Received: from mail.cityisp.net ([66.230.219.2]:24073 "EHLO RADIUS.radius")
	by vger.kernel.org with ESMTP id <S261563AbTCGMkW> convert rfc822-to-8bit;
	Fri, 7 Mar 2003 07:40:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: gilson redrick <gilsonr@cityisp.net>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Mandrake/AMD x L-2.5.xx
Date: Fri, 7 Mar 2003 07:52:31 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303070752.31261.gilsonr@cityisp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to all.

Has anyone *successfully* compiled 2.5.xx using Mandrake-9.0 with AMD? I 
haven't: 2.5.59, 2.5.60, 2.5.61, and now 2.5.64, have eluded me. I had no 
problem compiling 2.4.19 and 2.4.20 (which I'm using right now), but not 
2.5.xx.

If I try to have some drivers built modularly, make modules_install complains:
depmod: *** Unresolved symbols in /lib/modules/2.5.64/kernel/drivers \
	/char/lp.ko, /ide/ide-cd.ko, /net/ppp_async.ko, 
	/net/ppp_generic.ko, /parport/parport_pc.ko, /scsi/ide-scsi.ko,
	/scsi/sg.ko.

If I have them built into the kernel, then make modules_install exits clean, 
*but* those functions *don't* get implemented. For example, the printer, as 
/var/log/dmesg reports:
	lp: driver loaded but no devices found

I have to have "init 3" into the loader as otherwise the booting up hangs on 
"Ok, loading the kernel."

All the software on my system is fairly new. In the case of gcc, I thought the 
v-3.2 might be an adverse factor, so I compiled and tried v-2.95.3; it made 
no difference. Likewise, I thought modutils-2.4.19 wasn't new enough, I 
installed the latest I could find, v-2.4.22-1, but it didn't help at all.

This is a 1.3GHz Duron with 256 MB of RAM, running Mandrake-9.0

Kindly respond to "gilsonr (at) cityisp.net." Thanks!

-- 
Regards,

gr
(in /usually/ balmy, sunny Florida's Suncoast)
[an Intel-free, M$-free, virus-free computer. Not by chance, but by choice: 
powered by MandrakeSoft-9.0 Linux-2.4.20]
