Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266662AbUGKWyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266662AbUGKWyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUGKWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 18:54:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6366 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266662AbUGKWyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 18:54:22 -0400
Date: Mon, 12 Jul 2004 00:54:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sc2@gmx.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: question kernel 2.6 problem
Message-ID: <20040711225409.GE4701@fs.tum.de>
References: <S265049AbUGGKsc/20040707104832Z+1012@vger.kernel.org> <002001c46415$4bb9dfe0$6bda6c50@b>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002001c46415$4bb9dfe0$6bda6c50@b>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 01:26:42PM +0200, sc2@gmx.at wrote:

> hello
> when i try to make the 2.6.7 kernel this error is coming
> i use gcc 3.2.1
> any ideas what i did wrong? (i did same stuff likle every time)
> thx
>  CC      arch/i386/kernel/asm-offsets.s
> In Datei, eingef?gt von include/asm/system.h:5,
>                     von include/asm/processor.h:18,
>                     von include/asm/thread_info.h:16,
>                     von include/linux/thread_info.h:21,
>                     von include/linux/spinlock.h:12,
>                     von include/linux/capability.h:45,
>                     von include/linux/sched.h:7,
>                     von arch/i386/kernel/asm-offsets.c:7:
> include/linux/kernel.h:10:20: stdarg.h: Datei oder Verzeichnis nicht
> gefunden
>...

Seems to be a bug in your compiler installation.

This file should be found by your compiler at a path like
  /usr/lib/gcc-lib/i486-linux/3.2.1/include/stdarg.h
(depending on how you configured gcc, it might be slightly different)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

