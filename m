Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbTC0Twy>; Thu, 27 Mar 2003 14:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTC0Twy>; Thu, 27 Mar 2003 14:52:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1255 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261310AbTC0Twx>; Thu, 27 Mar 2003 14:52:53 -0500
From: bunk@fs.tum.de
Date: Thu, 27 Mar 2003 21:04:01 +0100
To: Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre6: IPMI unresolved symbols
Message-ID: <20030327200401.GX24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: From: Adrian Bunk <bunk@fs.tum.de>

panic_notifier_list and panic_timeout are not EXPORT_SYMBOL'ed in 
kernel/panic.c resulting in the following unresolved symbol errors when 
building IPMI modular:

<--  snip  -->

...
depmod: *** Unresolved symbols in /lib/modules/2.4.21-pre6/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in /lib/modules/2.4.21-pre6/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

