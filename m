Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281870AbRKWC6M>; Thu, 22 Nov 2001 21:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281871AbRKWC6D>; Thu, 22 Nov 2001 21:58:03 -0500
Received: from kiln.isn.net ([198.167.161.1]:28536 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S281870AbRKWC5s>;
	Thu, 22 Nov 2001 21:57:48 -0500
Message-ID: <3BFDBB15.AD778DA4@isn.net>
Date: Thu, 22 Nov 2001 22:57:25 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: e2fsck-1.25 problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I'm OT here, but reading the docs on ext3fs I had to upgrade
from e2fsck-1.19 so I got the latest, 1.25 and installed it before
booting 2.4.15pre6.
make check said all was fine. But, when I rebooted some messages sailed
by about not being able to load shared libraries and libgcc_s.so.1 and
fsck said something about errors in the fs and REBOOT NOW. Very scary
always.
I booted up a recovery disk and ran e2fsck-1.10 on both of the relevant
devices and with -f and all was well. I rebooted back to 2.4.14 and got
the same messages flying by. Nothing of the sort in dmesg or the logs.
Can anybody give me a clue as to what is going on? The system goes ahead
and reboots and runs fine with either kernel AFAIK.
gcc-3.0.2
cc reese@isn.net
Thanks a bunch, Garst
