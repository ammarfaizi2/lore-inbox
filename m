Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRDUXTI>; Sat, 21 Apr 2001 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133041AbRDUXS6>; Sat, 21 Apr 2001 19:18:58 -0400
Received: from brimstone.ucr.edu ([138.23.89.35]:62214 "EHLO brimstone.ucr.edu")
	by vger.kernel.org with ESMTP id <S133025AbRDUXSv>;
	Sat, 21 Apr 2001 19:18:51 -0400
Date: Sat, 21 Apr 2001 16:18:51 -0700
From: ruschein@brimstone.ucr.edu
To: linux-kernel@vger.kernel.org
Subject: Linker Error With Kernel 2.4.4pre6 and GCC 2.95.3 (Debian)
Message-ID: <20010421161851.A24134@brimstone.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is what I get under a fairly recent Debian woody:

/usr/src/kernel/linux-2.4.4-pre6/lib/lib.a(rwsem.o): In function `__rwsem_do_wake':
rwsem.o(.text+0x2e): undefined reference to `__builtin_expect'
rwsem.o(.text+0x6f): undefined reference to `__builtin_expect'
make: *** [vmlinux] Error 1
bender:/usr/src/kernel/linux-2.4.4-pre6 [root]# gcc --version
2.95.3

-- 
Johannes
--
Dr. Johannes Ruscheinski
Infomine Lead Programmer            ***              LINUX,             ***
EMail:    ruschein@infomine.ucr.edu ***                                 ***
Location: science library, room 218 *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2290

If you want to send me any documents please read
http://www.infradead.org/fileexchange.html first.  Thanks!

 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \

"Sanity's just a one trick pony anyway.  You only get one trick --
 rational thinking -- but when you're good and crazy, the sky's the limit!"
 -- The Tick"
