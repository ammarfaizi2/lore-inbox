Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTCETmv>; Wed, 5 Mar 2003 14:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTCETmu>; Wed, 5 Mar 2003 14:42:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28653 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261660AbTCETms>; Wed, 5 Mar 2003 14:42:48 -0500
Date: Wed, 5 Mar 2003 20:53:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dominik Brodowski <linux@brodo.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.64: cpufreq "userspace" governor doesn't compile
Message-ID: <20030305195311.GH20423@fs.tum.de>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 07:48:33PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.63 to v2.5.64
> ============================================
>...
> Dominik Brodowski <linux@brodo.de>:
>...
>   o cpufreq (3/5): "userspace" governor
>...

<--  snip  -->

...
  gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=userspace -DKBUILD_MODNAME=userspace -c -o 
drivers/cpufreq/userspace.o drivers/cpufreq/userspace.c
drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
drivers/cpufreq/userspace.c:514: structure has no member named `intf'
drivers/cpufreq/userspace.c:523: structure has no member named `intf'
make[2]: *** [drivers/cpufreq/userspace.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

